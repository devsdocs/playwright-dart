import 'package:playwright_dart/src/infrastructure/driver_downloader.dart';

void main() async {
  print('Pre-installing Playwright browsers...');
  await ensureBrowsersInstalled();
  print('Playwright browsers installed successfully!');
}
