import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';
import 'dart:convert';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();

  print('--- Phase 1: Logging in and saving state ---');
  final context1 = await browser.newContext();
  final page1 = await context1.newPage();
  await page1.goto('https://example.com');

  // Simulate logging in
  await context1.addCookies([
    SetNetworkCookie(
      name: 'session_token',
      value: 'logged_in_user_abc',
      domain: 'example.com',
      path: '/',
    ),
  ]);

  // Extract and save state
  final state = await context1.storageState();
  final stateJson = jsonEncode(state.toJson());
  final file = File('auth_state.json');
  await file.writeAsString(stateJson);
  print('Saved auth state to ${file.path}');
  await context1.close();

  print('\\n--- Phase 2: Restoring state in a new browser ---');
  final savedStateJson = jsonDecode(await file.readAsString());

  final context2 = await browser.newContext();
  await context2.setStorageState(
    BrowserContextSetStorageStateStorageState.fromJson(savedStateJson),
  );

  final page2 = await context2.newPage();
  await page2.goto('https://example.com');

  final cookies = await context2.cookies();
  print('Restored session cookies:');
  for (var cookie in cookies) {
    print('- ${cookie.name}: ${cookie.value}');
  }

  await context2.close();
  await browser.close();
  await file.delete();
}
