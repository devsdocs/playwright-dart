import 'dart:convert';
import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Generic evaluate<T>', () {
    test('evaluate<int> returns typed int', (page) async {
      final result = await page.evaluate<int>('() => 42');
      expect(result, isA<int>());
      expect(result, equals(42));
    });

    test('evaluate<String> returns typed string', (page) async {
      final result = await page.evaluate<String>('() => "hello"');
      expect(result, isA<String>());
      expect(result, equals('hello'));
    });

    test('evaluate<bool> returns typed bool', (page) async {
      final result = await page.evaluate<bool>('() => true');
      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('evaluate<Map> returns typed map', (page) async {
      final result = await page.evaluate<Map<String, dynamic>>(
        '() => ({ name: "dart", version: 3 })',
      );
      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], equals('dart'));
      expect(result['version'], equals(3));
    });

    test('evaluate<List> returns typed list', (page) async {
      final result = await page.evaluate<List>('() => [1, 2, 3]');
      expect(result, isA<List>());
      expect(result, equals([1, 2, 3]));
    });

    test('evaluate without generic still works (backwards compat)', (
      page,
    ) async {
      final result = await page.evaluate('() => 99');
      expect(result, equals(99));
    });

    test('locator.evaluate<int> returns typed result', (page) async {
      await page.setContent('<ul><li>a</li><li>b</li><li>c</li></ul>');
      final count = await page
          .locator('ul')
          .evaluate<int>('(el) => el.children.length');
      expect(count, isA<int>());
      expect(count, equals(3));
    });

    test('locator.evaluateAll<int> returns typed result', (page) async {
      await page.setContent('<ul><li>a</li><li>b</li><li>c</li></ul>');
      final count = await page
          .locator('li')
          .evaluateAll<int>('(els) => els.length');
      expect(count, isA<int>());
      expect(count, equals(3));
    });
  });

  group('APIRequestContext auto-JSON data param', () {
    test('post with data: Map auto-serializes to JSON', (page) async {
      final request = await playwright.newRequest();

      final response = await request.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      );

      expect(response.status, equals(201));

      await request.dispose();
    });

    test('post with data: Map matches manual jsonData', (page) async {
      final request = await playwright.newRequest();

      final r1 = await request.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'title': 'test', 'body': 'body', 'userId': 1},
      );

      final r2 = await request.post(
        'https://jsonplaceholder.typicode.com/posts',
        jsonData: jsonEncode({'title': 'test', 'body': 'body', 'userId': 1}),
      );

      expect(r1.status, equals(201));
      expect(r2.status, equals(201));

      await request.dispose();
    });

    test('explicit jsonData takes precedence over data', (page) async {
      final request = await playwright.newRequest();

      final response = await request.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'ignored': true},
        jsonData: jsonEncode({'title': 'explicit', 'body': 'bar', 'userId': 1}),
      );

      expect(response.status, equals(201));

      await request.dispose();
    });

    test('put with data: Map auto-serializes', (page) async {
      final request = await playwright.newRequest();

      final response = await request.put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'id': 1, 'title': 'updated', 'body': 'bar', 'userId': 1},
      );

      expect(response.status, equals(200));

      await request.dispose();
    });

    test('patch with data: Map auto-serializes', (page) async {
      final request = await playwright.newRequest();

      final response = await request.patch(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'title': 'patched'},
      );

      expect(response.status, equals(200));

      await request.dispose();
    });

    test('delete with data: Map auto-serializes', (page) async {
      final request = await playwright.newRequest();

      final response = await request.delete(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'reason': 'test'},
      );

      expect(response.status, equals(200));

      await request.dispose();
    });
  });

  group('Response.json<T> generic', () {
    test('json<Map<String, dynamic>> returns typed map', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '{"name":"dart","version":3}',
        );
      });

      await page.goto('https://example.com');
      final responseFuture = page.waitForResponse(
        RouteMatcher.function((dynamic r) => r.url.contains('/api/data')),
      );
      await page.evaluate(
        'async () => { await fetch("https://example.com/api/data"); }',
      );
      final response = await responseFuture;

      final data = await response.json<Map<String, dynamic>>();
      expect(data, isA<Map<String, dynamic>>());
      expect(data['name'], equals('dart'));
      expect(data['version'], equals(3));
    });

    test('json<List> returns typed list', (page) async {
      await page.route('**/api/list', (route) async {
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '[1, 2, 3]',
        );
      });

      await page.goto('https://example.com');
      final responseFuture = page.waitForResponse(
        RouteMatcher.function((dynamic r) => r.url.contains('/api/list')),
      );
      await page.evaluate(
        'async () => { await fetch("https://example.com/api/list"); }',
      );
      final response = await responseFuture;

      final data = await response.json<List>();
      expect(data, isA<List>());
      expect(data, equals([1, 2, 3]));
    });

    test('json without generic still works (backwards compat)', (page) async {
      await page.route('**/api/plain', (route) async {
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '{"ok":true}',
        );
      });

      await page.goto('https://example.com');
      final responseFuture = page.waitForResponse(
        RouteMatcher.function((dynamic r) => r.url.contains('/api/plain')),
      );
      await page.evaluate(
        'async () => { await fetch("https://example.com/api/plain"); }',
      );
      final response = await responseFuture;

      final data = await response.json();
      expect(data['ok'], isTrue);
    });
  });
}
