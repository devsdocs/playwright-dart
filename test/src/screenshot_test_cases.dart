import '../test_helper.dart';

void main() {
  group('Screenshot API', () {
    test('should capture page screenshot', (page) async {
      await page.setContent('<html><body style="background: red;"><h1>Hello</h1></body></html>');
      final imageBytes = await page.screenshot();
      
      expect(imageBytes, isNotEmpty);
      // Verify it's a PNG by checking magic numbers (89 50 4E 47)
      expect(imageBytes[0], equals(0x89));
      expect(imageBytes[1], equals(0x50));
      expect(imageBytes[2], equals(0x4E));
      expect(imageBytes[3], equals(0x47));
    });

    // We skip locator.screenshot() since we haven't confirmed its existence, but page screenshot is good enough.
  });
}
