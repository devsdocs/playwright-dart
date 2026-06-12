import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'version.dart';

String getPlatformName() {
  if (Platform.isWindows) {
    return 'win32_x64';
  } else if (Platform.isMacOS) {
    // Check for arm64
    final result = Process.runSync('uname', ['-m']);
    if (result.stdout.toString().trim() == 'arm64') {
      return 'mac-arm64';
    }
    return 'mac';
  } else if (Platform.isLinux) {
    final result = Process.runSync('uname', ['-m']);
    if (result.stdout.toString().trim() == 'aarch64') {
      return 'linux-arm64';
    }
    return 'linux';
  }
  throw UnsupportedError('Unsupported platform: \${Platform.operatingSystem}');
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
  final executablePath = p.join(
    driverDir.path,
    Platform.isWindows ? 'playwright.cmd' : 'playwright.sh',
  );

  if (File(executablePath).existsSync()) {
    return executablePath;
  }

  print('Downloading Playwright driver $driverVersion...');

  if (!driverDir.existsSync()) {
    driverDir.createSync(recursive: true);
  }

  final platformName = getPlatformName();
  final url =
      'https://playwright.azureedge.net/builds/driver/playwright-$driverVersion-$platformName.zip';
  final zipPath = p.join(driverDir.path, 'driver.zip');

  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw StateError(
      'Failed to download driver: \${response.statusCode} \${response.body}',
    );
  }

  File(zipPath).writeAsBytesSync(response.bodyBytes);

  print('Extracting driver...');
  if (Platform.isWindows) {
    final result = Process.runSync('powershell', [
      '-Command',
      'Expand-Archive -Path "$zipPath" -DestinationPath "${driverDir.path}" -Force',
    ]);
    if (result.exitCode != 0) {
      throw StateError('Failed to extract driver: ${result.stderr}');
    }
  } else {
    final result = Process.runSync('unzip', [
      '-o',
      zipPath,
      '-d',
      driverDir.path,
    ]);
    if (result.exitCode != 0) {
      throw StateError('Failed to extract driver: ${result.stderr}');
    }
  }

  File(zipPath).deleteSync();

  if (!Platform.isWindows) {
    Process.runSync('chmod', ['+x', p.join(driverDir.path, 'node')]);
  }

  print('Installing browsers (this may take a few minutes)...');
  final nodePath = p.join(
    driverDir.path,
    Platform.isWindows ? 'node.exe' : 'node',
  );
  final cliPath = p.join(driverDir.path, 'package', 'cli.js');

  final installProcess = Process.runSync(nodePath, [cliPath, 'install']);
  if (installProcess.exitCode != 0) {
    print(installProcess.stdout);
    print(installProcess.stderr);
    throw StateError('Failed to install browsers: \${installProcess.exitCode}');
  }

  print('Driver and browsers downloaded successfully.');
  return driverDir.path;
}
