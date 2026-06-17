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
import 'src/page_advanced_test_cases.dart' as page_advanced_test_cases;
import 'src/browser_context_advanced_test_cases.dart'
    as browser_context_advanced_test_cases;
import 'src/network_advanced_test_cases.dart' as network_advanced_test_cases;
import 'src/input_devices_test_cases.dart' as input_devices_test_cases;
import 'src/websocket_connect_test_cases.dart' as websocket_connect_test_cases;
import 'src/lifecycle_test_cases.dart' as lifecycle_test_cases;
import 'src/tracing_test_cases.dart' as tracing_test_cases;
import 'src/storage_state_test_cases.dart' as storage_state_test_cases;
import 'src/pdf_test_cases.dart' as pdf_test_cases;
import 'src/init_script_test_cases.dart' as init_script_test_cases;
import 'src/cdp_session_test_cases.dart' as cdp_session_test_cases;
import 'src/worker_test_cases.dart' as worker_test_cases;
import 'src/download_test_cases.dart' as download_test_cases;
import 'src/api_request_context_test_cases.dart'
    as api_request_context_test_cases;
import 'src/locator_assertions_test_cases.dart'
    as locator_assertions_test_cases;
import 'src/route_from_har_test_cases.dart' as route_from_har_test_cases;
import 'src/selectors_test_cases.dart' as selectors_test_cases;
import 'src/jshandle_test_cases.dart' as jshandle_test_cases;
import 'src/element_handle_test_cases.dart' as element_handle_test_cases;
import 'src/page_assertions_test_cases.dart' as page_assertions_test_cases;
import 'src/get_by_role_aria_test_cases.dart' as get_by_role_aria_test_cases;
import 'src/locator_filter_visible_test_cases.dart'
    as locator_filter_visible_test_cases;
import 'src/page_properties_test_cases.dart' as page_properties_test_cases;
import 'src/response_request_fixes_test_cases.dart'
    as response_request_fixes_test_cases;

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
  page_advanced_test_cases.main();
  browser_context_advanced_test_cases.main();
  network_advanced_test_cases.main();
  input_devices_test_cases.main();
  websocket_connect_test_cases.main();
  lifecycle_test_cases.main();
  tracing_test_cases.main();
  storage_state_test_cases.main();
  pdf_test_cases.main();
  init_script_test_cases.main();
  cdp_session_test_cases.main();
  worker_test_cases.main();
  download_test_cases.main();
  api_request_context_test_cases.main();
  real_world_test_cases.main();
  locator_assertions_test_cases.main();
  route_from_har_test_cases.main();
  selectors_test_cases.main();
  jshandle_test_cases.main();
  element_handle_test_cases.main();
  page_assertions_test_cases.main();
  get_by_role_aria_test_cases.main();
  locator_filter_visible_test_cases.main();
  page_properties_test_cases.main();
  response_request_fixes_test_cases.main();
}
