import 'dart:io';
import 'package:path/path.dart' as p;
import 'driver_downloader.dart';
import '../utils/logger.dart';

class Driver {
  /// Exposed for testing to override Process.start behavior
  static Future<Process> Function(String, List<String>) processStart =
      Process.start;

  /// Exposed for testing to override driver download behavior
  static Future<String> Function() getDriverPath = downloadDriver;

  static Future<Process> run() async {
    final driverDirPath = await getDriverPath();
    final nodePath = p.join(
      driverDirPath,
      Platform.isWindows ? 'node.exe' : 'node',
    );
    final cliPath = p.join(driverDirPath, 'package', 'cli.js');

    Logger.info('Starting Playwright driver...');
    final process = await processStart(nodePath, [cliPath, 'run-driver']);

    Logger.debug(
      'Driver process started (pid ${process.pid}).',
      name: 'playwright.driver',
    );
    return process;
  }
}
