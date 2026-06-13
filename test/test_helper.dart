import 'dart:async';
import 'package:test/test.dart' as dart_test;
import 'package:playwright_dart/playwright_dart.dart';

export 'package:test/test.dart' hide test, group;
export 'package:playwright_dart/playwright_dart.dart';

Playwright? _playwright;
Browser? _browser;

Playwright get playwright => _playwright!;
Browser get browser => _browser!;

Future<void> setupBrowser() async {
  if (_playwright == null) {
    _playwright = await Playwright.create();
    _browser = await _playwright!.chromium.launch();
  }
}

Future<void> teardownBrowser() async {
  try {
    await _browser?.close();
  } catch (e) {
    // Ignore
  }
  _browser = null;
  _playwright = null;
}

void test(String description, FutureOr<void> Function(Page page) body) {
  dart_test.test(description, () async {
    if (_browser == null) {
      throw StateError('Browser is not initialized. Did you call setupBrowser()?');
    }
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
