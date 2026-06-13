import 'dart:async';
import '../test_helper.dart';

void main() {
  group('Dialog API', () {
    test('should handle alert dialog', (page) async {
      final dialogCompleter = Completer<Dialog>();

      // Setup listener
      page.onDialog.listen((dialog) {
        dialogCompleter.complete(dialog);
      });
      await Future.delayed(Duration(milliseconds: 100));

      // Trigger dialog
      await page.evaluate("() => setTimeout(() => alert('Hello Alert'), 0)");

      final dialog = await dialogCompleter.future;
      expect(dialog.type, equals('alert'));
      expect(dialog.message, equals('Hello Alert'));

      await dialog.accept();
    });

    test('should handle confirm dialog and return result', (page) async {
      final dialogCompleter = Completer<Dialog>();

      page.onDialog.listen((dialog) async {
        expect(dialog.type, equals('confirm'));
        expect(dialog.message, equals('Are you sure?'));
        await dialog.accept();
        dialogCompleter.complete(dialog);
      });
      await Future.delayed(Duration(milliseconds: 100));

      final result = await page.evaluate('''() => {
        return new Promise(resolve => {
          setTimeout(() => {
            const res = confirm('Are you sure?');
            resolve(res);
          }, 0);
        });
      }''');

      await dialogCompleter.future;
      expect(result, isTrue);
    });
  });
}
