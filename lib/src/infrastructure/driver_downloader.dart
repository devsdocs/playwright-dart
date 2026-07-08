import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import '../utils/logger.dart';
import 'package:path/path.dart' as p;

import '../utils/version.dart';

Future<String> _fetchNodeVersion(String driverVersion) async {
  try {
    final pkgUrl = 'https://registry.npmjs.org/playwright-core/$driverVersion';
    final pkgRes = await http.get(Uri.parse(pkgUrl));
    if (pkgRes.statusCode == 200) {
      final json = jsonDecode(pkgRes.body);
      final gitHead = json['gitHead'] as String?;
      if (gitHead != null) {
        final scriptUrl =
            'https://raw.githubusercontent.com/microsoft/playwright/$gitHead/utils/build/build-playwright-driver.sh';
        final scriptRes = await http.get(Uri.parse(scriptUrl));
        if (scriptRes.statusCode == 200) {
          final match =
              RegExp(r'NODE_VERSION="([^"]+)"').firstMatch(scriptRes.body);
          if (match != null && match.groupCount >= 1) {
            return match.group(1)!;
          }
        }
      }
    }
  } catch (e) {
    Logger.debug(
      'Failed to fetch dynamic Node.js version: $e',
      name: 'playwright.driver',
    );
  }
  return '20.14.0';
}

class NodePlatform {
  final String suffix;
  final String extension;
  final bool isWindows;
  NodePlatform(this.suffix, this.extension, this.isWindows);
}

NodePlatform _getNodePlatform() {
  if (Platform.isWindows) {
    return NodePlatform('win-x64', 'zip', true);
  } else if (Platform.isMacOS) {
    final result = Process.runSync('uname', ['-m']);
    if (result.stdout.toString().trim() == 'arm64') {
      return NodePlatform('darwin-arm64', 'tar.gz', false);
    }
    return NodePlatform('darwin-x64', 'tar.gz', false);
  } else if (Platform.isLinux) {
    final result = Process.runSync('uname', ['-m']);
    if (result.stdout.toString().trim() == 'aarch64') {
      return NodePlatform('linux-arm64', 'tar.gz', false);
    }
    return NodePlatform('linux-x64', 'tar.gz', false);
  }
  throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
}

Future<String> downloadDriver() async {
  final driverVersion = await getPlaywrightVersion();
  final userHome =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
  if (userHome == null) {
    throw StateError('Could not find home directory');
  }

  final driverDir = Directory(
    p.join(userHome, '.playwright-dart', 'driver', driverVersion),
  );
  final cliPath = p.join(driverDir.path, 'package', 'cli.js');
  final markerPath = p.join(driverDir.path, '.installed');
  if (File(cliPath).existsSync() && File(markerPath).existsSync()) {
    return driverDir.path;
  }

  Logger.info('Assembling Playwright driver $driverVersion...');

  if (!driverDir.existsSync()) {
    driverDir.createSync(recursive: true);
  }

  // 1. Download and extract playwright-core
  final coreUrl =
      'https://registry.npmjs.org/playwright-core/-/playwright-core-$driverVersion.tgz';
  Logger.info('Downloading playwright-core...');
  final coreResponse = await http.get(Uri.parse(coreUrl));
  if (coreResponse.statusCode != 200) {
    throw StateError(
      'Failed to download playwright-core: ${coreResponse.statusCode}',
    );
  }

  Logger.info('Extracting playwright-core package...');
  final coreArchive =
      TarDecoder().decodeBytes(GZipDecoder().decodeBytes(coreResponse.bodyBytes));
  for (final file in coreArchive) {
    if (file.isFile) {
      final outputPath = p.join(driverDir.path, p.normalize(file.name));
      File(outputPath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(file.content as List<int>);
    }
  }

  // 2. Download and extract Node.js binary
  final platform = _getNodePlatform();
  final nodeVersion = await _fetchNodeVersion(driverVersion);
  final nodeDirName = 'node-v$nodeVersion-${platform.suffix}';
  final nodeUrl =
      'https://nodejs.org/dist/v$nodeVersion/$nodeDirName.${platform.extension}';
  Logger.info('Downloading Node.js $nodeVersion...');
  final nodeResponse = await http.get(Uri.parse(nodeUrl));
  if (nodeResponse.statusCode != 200) {
    throw StateError(
      'Failed to download Node.js: ${nodeResponse.statusCode}',
    );
  }

  Logger.info('Extracting Node.js binary...');
  Archive nodeArchive;
  if (platform.extension == 'zip') {
    nodeArchive = ZipDecoder().decodeBytes(nodeResponse.bodyBytes);
  } else {
    nodeArchive =
        TarDecoder().decodeBytes(GZipDecoder().decodeBytes(nodeResponse.bodyBytes));
  }

  for (final file in nodeArchive) {
    if (file.isFile) {
      final name = file.name;
      if (name.endsWith('node.exe') || name.endsWith('bin/node')) {
        final out =
            File(p.join(driverDir.path, platform.isWindows ? 'node.exe' : 'node'));
        out.createSync(recursive: true);
        out.writeAsBytesSync(file.content as List<int>);
        if (!platform.isWindows) {
          Process.runSync('chmod', ['+x', out.path]);
        }
      } else if (name.endsWith('LICENSE')) {
        final out = File(p.join(driverDir.path, 'LICENSE'));
        out.createSync(recursive: true);
        out.writeAsBytesSync(file.content as List<int>);
      }
    }
  }

  File(markerPath).writeAsStringSync('done');
  Logger.info('Driver assembled successfully.');
  return driverDir.path;
}

Future<void> ensureBrowsersInstalled() async {
  final driverDirPath = await downloadDriver();
  final cliPath = p.join(driverDirPath, 'package', 'cli.js');
  final browserMarkerPath = p.join(driverDirPath, '.browsers-installed');

  if (File(browserMarkerPath).existsSync()) {
    return;
  }

  Logger.info('Installing browsers (this may take a few minutes)...');
  final nodePath = p.join(
    driverDirPath,
    Platform.isWindows ? 'node.exe' : 'node',
  );
  final installProcess = Process.runSync(nodePath, [cliPath, 'install']);
  if (installProcess.exitCode != 0) {
    Logger.info(installProcess.stdout.toString());
    Logger.error(installProcess.stderr.toString());
    throw StateError('Failed to install browsers: ${installProcess.exitCode}');
  }

  // Linux requires OS-level shared libraries
  if (Platform.isLinux) {
    await _installLinuxDeps(nodePath, cliPath);
  }

  File(browserMarkerPath).writeAsStringSync('done');
  Logger.info('Browsers installed successfully.');
}

/// Installs OS-level browser dependencies on Linux via `install-deps`.
Future<void> _installLinuxDeps(String nodePath, String cliPath) async {
  Logger.info('Installing Linux browser dependencies...');

  final direct = Process.runSync(nodePath, [cliPath, 'install-deps']);
  if (direct.exitCode == 0) {
    Logger.info('Linux browser dependencies installed.');
    return;
  }

  Logger.debug(
    'install-deps without sudo failed (exit ${direct.exitCode}), retrying with sudo...',
    name: 'playwright.driver',
  );

  final withSudo = Process.runSync('sudo', [nodePath, cliPath, 'install-deps']);
  if (withSudo.exitCode == 0) {
    Logger.info('Linux browser dependencies installed (via sudo).');
    return;
  }

  Logger.error(withSudo.stderr.toString());
  throw StateError(
    'Failed to install Linux browser dependencies.\n'
    'Please run the following command manually and try again:\n\n'
    '  sudo $nodePath $cliPath install-deps\n',
  );
}
