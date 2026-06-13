import 'dart:async';
import 'package:test/test.dart' as dart_test;
import 'package:playwright_dart/playwright_dart.dart';

export 'package:test/test.dart' hide test, group;
export 'package:playwright_dart/playwright_dart.dart';

Playwright? _playwright;
Browser? _browser;
bool _tearDownRegistered = false;

Future<void> _ensureSetup() async {
  if (_playwright == null) {
    _playwright = await Playwright.create();
    _browser = await _playwright!.chromium.launch();
  }
}

void test(String description, FutureOr<void> Function(Page page) body) {
  if (!_tearDownRegistered) {
    dart_test.setUpAll(() async {
      await _ensureSetup();
    });
    dart_test.tearDownAll(() async {
      try {
        await _browser?.close();
      } catch (e) {
        // Ignore TargetClosedError
      }
      _browser = null;
      _playwright = null;
    });
    _tearDownRegistered = true;
  }

  dart_test.test(description, () async {
    final context = await _browser!.newContext();
    final page = await context.newPage();
    try {
      await body(page);
    } finally {
      try {
        await context.close();
      } catch (e) {
        // Ignore TargetClosedError
      }
    }
  });
}

void group(String description, void Function() body) {
  dart_test.group(description, body);
}
