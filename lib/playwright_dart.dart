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
export 'src/playwright.dart';
export 'src/browser_type.dart';
export 'src/browser.dart';
export 'src/browser_context.dart';
export 'src/page.dart';
export 'src/frame.dart';
export 'src/locator.dart';
export 'src/generated/channels.dart' hide Channel;

// Interaction
export 'src/element_handle.dart';
export 'src/jshandle.dart';
export 'src/keyboard.dart';
export 'src/mouse.dart';

// Network
export 'src/request.dart';
export 'src/response.dart';
export 'src/route.dart';
export 'src/api_request_context.dart';
export 'src/websocket.dart';
export 'src/websocket_route.dart';

// Utilities
export 'src/tracing.dart';
export 'src/cdp_session.dart';
export 'src/dialog.dart';
export 'src/worker.dart';
export 'src/artifact.dart';
export 'src/stream.dart';
export 'src/writable_stream.dart';

// Debugging
export 'src/debugger.dart';
export 'src/debug_controller.dart';
export 'src/binding_call.dart';
export 'src/event_target.dart';
export 'src/disposable.dart';

// Platform
export 'src/android.dart';
export 'src/android_device.dart';
export 'src/android_socket.dart';
export 'src/electron.dart';
export 'src/electron_application.dart';

// Infrastructure
export 'src/connection.dart';
export 'src/channel_owner.dart';
export 'src/driver.dart';
export 'src/transport.dart';
export 'src/file_payload.dart';
export 'src/serialization.dart';

// Internal (needed for advanced usage)
export 'src/root.dart';
export 'src/socks_support.dart';
export 'src/json_pipe.dart';
export 'src/local_utils.dart';
