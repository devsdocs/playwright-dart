import 'test_helper.dart';

import 'src/locator_test_cases.dart' as locator_test_cases;
import 'src/network_test_cases.dart' as network_test_cases;
import 'src/page_test_cases.dart' as page_test_cases;
import 'src/mouse_keyboard_test_cases.dart' as mouse_keyboard_test_cases;
import 'src/browser_context_test_cases.dart' as browser_context_test_cases;
import 'src/frame_test_cases.dart' as frame_test_cases;
import 'src/dialog_test_cases.dart' as dialog_test_cases;
import 'src/real_world_test_cases.dart' as real_world_test_cases;
import 'src/screenshot_test_cases.dart' as screenshot_test_cases;
import 'src/console_test_cases.dart' as console_test_cases;
import 'src/emulation_test_cases.dart' as emulation_test_cases;
import 'src/touchscreen_test_cases.dart' as touchscreen_test_cases;
import 'src/waiting_test_cases.dart' as waiting_test_cases;
import 'src/file_upload_test_cases.dart' as file_upload_test_cases;
import 'src/page_navigation_test_cases.dart' as page_navigation_test_cases;
import 'src/locator_advanced_test_cases.dart' as locator_advanced_test_cases;
import 'src/evaluate_test_cases.dart' as evaluate_test_cases;

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  locator_test_cases.main();
  network_test_cases.main();
  page_test_cases.main();
  mouse_keyboard_test_cases.main();
  browser_context_test_cases.main();
  frame_test_cases.main();
  dialog_test_cases.main();
  screenshot_test_cases.main();
  console_test_cases.main();
  emulation_test_cases.main();
  touchscreen_test_cases.main();
  waiting_test_cases.main();
  file_upload_test_cases.main();
  page_navigation_test_cases.main();
  locator_advanced_test_cases.main();
  evaluate_test_cases.main();
  real_world_test_cases.main();
}
