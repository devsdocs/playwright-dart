import '../test_helper.dart';

void main() {
  group('PDF API', () {
    test('should generate PDF', (page) async {
      await page.goto('https://example.com');

      final pdfBytes = await page.pdf(format: 'A4', landscape: true);

      expect(pdfBytes, isNotEmpty);
      expect(pdfBytes.length, greaterThan(100));

      // Checking for PDF magic number %PDF
      expect(pdfBytes[0], equals(0x25)); // %
      expect(pdfBytes[1], equals(0x50)); // P
      expect(pdfBytes[2], equals(0x44)); // D
      expect(pdfBytes[3], equals(0x46)); // F
    });
  });
}
