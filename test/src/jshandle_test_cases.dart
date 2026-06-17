import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('JSHandle API', () {
    test('should return jsonValue', (page) async {
      final handle = await page.waitForFunction('() => ({a: 1, b: "hello"})');
      expect(handle, isNotNull);

      final value = await handle.jsonValue();
      expect(value, isA<Map>());
      expect(value['a'], equals(1));
      expect(value['b'], equals('hello'));

      await handle.dispose();
    });

    test('should get property', (page) async {
      final handle = await page.waitForFunction('() => ({a: 1, b: "hello"})');

      final propA = await handle.getProperty('a');
      expect(await propA.jsonValue(), equals(1));

      final propB = await handle.getProperty('b');
      expect(await propB.jsonValue(), equals('hello'));

      await propA.dispose();
      await propB.dispose();
      await handle.dispose();
    });

    test('should get properties', (page) async {
      final handle = await page.waitForFunction('() => ({a: 1, b: "hello"})');

      final props = await handle.getProperties();
      expect(props.length, equals(2));
      expect(await props['a']!.jsonValue(), equals(1));
      expect(await props['b']!.jsonValue(), equals('hello'));

      await handle.dispose();
    });

    test('should evaluate against handle', (page) async {
      final handle = await page.waitForFunction('() => ({a: 1, b: "hello"})');

      final result = await handle.evaluate('(obj) => obj.a + 10');
      expect(result, equals(11));

      final handle2 = await handle.evaluateHandle('(obj) => obj.a');
      expect(await handle2.jsonValue(), equals(1));

      await handle2.dispose();
      await handle.dispose();
    });
  });
}
