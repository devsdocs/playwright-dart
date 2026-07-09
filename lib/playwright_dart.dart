/// Playwright Dart — a complete Dart SDK for browser automation.
///
/// This library provides 100% API parity with Node.js Playwright v1.60.0.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:playwright_dart/playwright_dart.dart';
///
/// void main() async {
///   final playwright = await PlaywrightDart.create();
///   final browser = await playwright.chromium.launch();
///   final page = await browser.newPage();
///   await page.goto('https://example.com');
///   await browser.close();
/// }
/// ```
library;

// Core
export 'src/core/playwright.dart';
export 'src/core/browser_type.dart';
export 'src/core/browser.dart';
export 'src/core/browser_context.dart';
export 'src/core/page.dart';
export 'src/core/frame.dart'; // also exports ExpectResult, ExpectReceived
export 'src/core/locator.dart';
export 'src/core/selectors.dart';
export 'src/generated/channels.dart' hide ConsoleMessage;

// Interaction
export 'src/interaction/element_handle.dart';
export 'src/interaction/jshandle.dart';
export 'src/interaction/locator_assertions.dart';
export 'src/interaction/page_assertions.dart';
export 'src/interaction/api_response_assertions.dart';
export 'src/interaction/keyboard.dart';
export 'src/interaction/mouse.dart';
export 'src/interaction/file_chooser.dart';
export 'src/interaction/interaction_types.dart';
export 'src/core/route_matcher.dart';
export 'src/core/pdf_dimension.dart';
export 'src/core/pdf_format.dart';
export 'src/core/browser_permission.dart';

// Network
export 'src/network/request.dart';
export 'src/network/response.dart';
export 'src/network/route.dart';
export 'src/network/route_error_code.dart';
export 'src/network/api_request_context.dart';
export 'src/network/websocket.dart';
export 'src/network/websocket_route.dart';

// Utilities
export 'src/utils/tracing.dart';
export 'src/utils/cdp_session.dart';
export 'src/interaction/dialog.dart';
export 'src/utils/console_message.dart';
export 'src/utils/video.dart';
export 'src/utils/worker.dart';
export 'src/utils/artifact.dart';
export 'src/infrastructure/stream.dart';
export 'src/infrastructure/writable_stream.dart';

// Debugging
export 'src/debugging/debugger.dart';
export 'src/debugging/debug_controller.dart';
export 'src/debugging/binding_call.dart';
export 'src/debugging/event_target.dart';
export 'src/debugging/disposable.dart';

// Platform
export 'src/platform/android.dart';
export 'src/platform/android_device.dart';
export 'src/platform/android_socket.dart';
export 'src/platform/electron.dart';

// Utilities (additional)
export 'src/utils/clock.dart';
export 'src/network/route_handler.dart';
export 'src/platform/electron_application.dart';

// Infrastructure
export 'src/infrastructure/connection.dart';
export 'src/infrastructure/channel_owner.dart';
export 'src/infrastructure/driver.dart';
export 'src/infrastructure/transport.dart';
export 'src/infrastructure/file_payload.dart';
export 'src/infrastructure/serialization.dart';
export 'src/infrastructure/event_emitter.dart';
export 'src/infrastructure/playwright_errors.dart';
// DOM node types from package:html — exports Node, Element, Document, Text, etc.
// Use these as type parameters for ElementHandle<T> and JSHandle<T>.
export 'src/infrastructure/html_node.dart';
export 'src/infrastructure/waiter.dart';

// Internal (needed for advanced usage)
export 'src/infrastructure/root.dart';
export 'src/network/socks_support.dart';
export 'src/infrastructure/json_pipe.dart';
export 'src/infrastructure/local_utils.dart';

export 'src/utils/download.dart';

// Dart-Native Features
export 'src/config/playwright_config.dart';
export 'src/reporting/html_reporter.dart';
