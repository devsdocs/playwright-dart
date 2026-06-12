import 'dart:io';
import 'package:path/path.dart' as p;
import 'driver_downloader.dart';

class Driver {
  static Future<Process> run() async {
    final driverDirPath = await downloadDriver();
    final nodePath = p.join(
      driverDirPath,
      Platform.isWindows ? 'node.exe' : 'node',
    );
    final cliPath = p.join(driverDirPath, 'package', 'cli.js');

    final process = await Process.start(nodePath, [
      cliPath,
      'run-driver',
    ], mode: ProcessStartMode.normal);

    return process;
  }
}
