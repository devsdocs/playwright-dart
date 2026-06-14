import '../test_helper.dart';

void main() {
  group('Evaluate API', () {
    test('should evaluate with arguments', (page) async {
      final result = await page.evaluate('(a) => a * 2', 21);
      expect(result, equals(42));
    });

    test('should evaluate with object argument', (page) async {
      final result = await page.evaluate('(obj) => obj.x + obj.y', {
        'x': 10,
        'y': 20,
      });
      expect(result, equals(30));
    });

    test('should evaluate returning array', (page) async {
      final result = await page.evaluate('() => [1, 2, 3]');
      expect(result, equals([1, 2, 3]));
    });

    test('should evaluate returning object', (page) async {
      final result = await page.evaluate('() => ({ name: "test", value: 42 })');
      expect(result, isA<Map>());
      expect(result['name'], equals('test'));
      expect(result['value'], equals(42));
    });

    test('should evaluate returning null', (page) async {
      final result = await page.evaluate('() => null');
      expect(result, isNull);
    });

    test('should evaluate returning boolean', (page) async {
      expect(await page.evaluate('() => true'), isTrue);
      expect(await page.evaluate('() => false'), isFalse);
    });

    test('should evaluate returning string', (page) async {
      final result = await page.evaluate('() => "hello"');
      expect(result, equals('hello'));
    });

    test('should evaluate returning NaN', (page) async {
      final result = await page.evaluate('() => NaN');
      expect(result, isNaN);
    });

    test('should evaluate returning Infinity', (page) async {
      final result = await page.evaluate('() => Infinity');
      expect(result, equals(double.infinity));
    });

    test('should evaluate returning -Infinity', (page) async {
      final result = await page.evaluate('() => -Infinity');
      expect(result, equals(double.negativeInfinity));
    });

    test('should evaluate returning -0', (page) async {
      final result = await page.evaluate('() => -0');
      expect(result, equals(-0.0));
      expect(result.isNegative, isTrue);
    });

    test('should pass special numbers as arguments', (page) async {
      expect(await page.evaluate('(a) => Number.isNaN(a)', double.nan), isTrue);
      expect(
        await page.evaluate('(a) => a === Infinity', double.infinity),
        isTrue,
      );
      expect(
        await page.evaluate('(a) => a === -Infinity', double.negativeInfinity),
        isTrue,
      );
      expect(await page.evaluate('(a) => Object.is(a, -0)', -0.0), isTrue);
    });

    test('should evaluate with DOM interaction', (page) async {
      await page.setContent('''
        <ul>
          <li>One</li>
          <li>Two</li>
          <li>Three</li>
        </ul>
      ''');

      final count = await page.evaluate(
        '() => document.querySelectorAll("li").length',
      );
      expect(count, equals(3));
    });
  });

  group('WaitForFunction API', () {
    test('should wait for DOM change', (page) async {
      await page.setContent('''
        <div id="status">loading</div>
        <script>
          setTimeout(() => {
            document.getElementById("status").textContent = "done";
          }, 500);
        </script>
      ''');

      await page.waitForFunction(
        '() => document.getElementById("status").textContent === "done"',
      );
      final text = await page.locator('#status').textContent();
      expect(text, equals('done'));
    });

    test('should wait for variable', (page) async {
      await page.setContent('''
        <script>
          window.ready = false;
          setTimeout(() => { window.ready = true; }, 300);
        </script>
      ''');

      await page.waitForFunction('() => window.ready');
      expect(await page.evaluate('() => window.ready'), isTrue);
    });
  });
}
