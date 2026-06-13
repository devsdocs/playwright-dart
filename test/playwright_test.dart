import 'test_helper.dart';

import 'src/locator_test_cases.dart' as locator_test_cases;
import 'src/network_test_cases.dart' as network_test_cases;
import 'src/page_test_cases.dart' as page_test_cases;
import 'src/mouse_keyboard_test_cases.dart' as mouse_keyboard_test_cases;
import 'src/browser_context_test_cases.dart' as browser_context_test_cases;
import 'src/frame_test_cases.dart' as frame_test_cases;
import 'src/dialog_test_cases.dart' as dialog_test_cases;
import 'src/real_world_test_cases.dart' as real_world_test_cases;

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
  real_world_test_cases.main();
}
