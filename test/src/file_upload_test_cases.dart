import 'dart:convert';
import '../test_helper.dart';

void main() {
  group('File Upload API', () {
    test('should set input files via FilePayload', (page) async {
      await page.setContent('''
        <input type="file" id="upload" />
        <script>
          let fileName = '';
          let fileContent = '';
          document.getElementById('upload').addEventListener('change', (e) => {
            const file = e.target.files[0];
            fileName = file.name;
            const reader = new FileReader();
            reader.onload = (e) => { fileContent = e.target.result; };
            reader.readAsText(file);
          });
        </script>
      ''');

      final payload = FilePayload(
        name: 'test.txt',
        mimeType: 'text/plain',
        buffer: utf8.encode('Hello from Playwright Dart!'),
      );

      await page.locator('#upload').setInputFiles([payload]);

      // Wait for file reader to load
      await page.waitForFunction('() => fileContent !== ""');

      final fileName = await page.evaluate('() => fileName');
      final fileContent = await page.evaluate('() => fileContent');

      expect(fileName, equals('test.txt'));
      expect(fileContent, equals('Hello from Playwright Dart!'));
    });
  });
}
