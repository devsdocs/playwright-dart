import 'dart:io';

import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Persistent Context & Storage State API', () {
    test('should save and restore storage state', (page) async {
      final context = await browser.newContext();
      await context.addCookies([
        SetNetworkCookie(
          name: 'test_cookie',
          value: '12345',
          domain: 'example.com',
          path: '/',
        ),
      ]);

      final state = await context.storageState();

      expect(state.cookies, isNotEmpty);
      expect(state.cookies.first.name, equals('test_cookie'));
      expect(state.cookies.first.value, equals('12345'));

      // Create a new context and restore the state
      final newContext = await browser.newContext();
      await newContext.setStorageState(
        BrowserContextSetStorageStateStorageState.fromJson(state.toJson()),
      );

      final restoredCookies = await newContext.cookies();
      expect(restoredCookies, isNotEmpty);
      expect(restoredCookies.first.name, equals('test_cookie'));
      expect(restoredCookies.first.value, equals('12345'));

      await newContext.close();
    });

    test('should launch a persistent context', (page) async {
      final tempDir = Directory.systemTemp.createTempSync(
        'playwright_persistent_',
      );

      try {
        final persistentContext = await playwright.chromium
            .launchPersistentContext(tempDir.path);

        final p = await persistentContext.newPage();
        await p.goto('https://example.com');

        await p.evaluate(
          'localStorage.setItem("persistent_key", "persistent_value");',
        );

        await persistentContext.close();

        // Relaunch the same context directory
        final persistentContext2 = await playwright.chromium
            .launchPersistentContext(tempDir.path);

        final p2 = await persistentContext2.newPage();
        await p2.goto('https://example.com');
        final value = await p2.evaluate(
          'localStorage.getItem("persistent_key");',
        );
        expect(value, equals('persistent_value'));

        await persistentContext2.close();
      } finally {
        if (tempDir.existsSync()) {
          await Future.delayed(const Duration(milliseconds: 500));
          try {
            tempDir.deleteSync(recursive: true);
          } catch (e) {
            print('Could not delete temp directory (likely Windows lock): $e');
          }
        }
      }
    });
  });
}
