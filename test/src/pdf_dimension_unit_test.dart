import 'package:test/test.dart';
import 'package:playwright_dart/src/core/pdf_dimension.dart';

void main() {
  group('PdfUnit', () {
    test('should have correct string values', () {
      expect(PdfUnit.px.value, equals('px'));
      expect(PdfUnit.inch.value, equals('in'));
      expect(PdfUnit.cm.value, equals('cm'));
      expect(PdfUnit.mm.value, equals('mm'));
    });

    test('should have all four units', () {
      expect(PdfUnit.values, hasLength(4));
      expect(PdfUnit.values, contains(PdfUnit.px));
      expect(PdfUnit.values, contains(PdfUnit.inch));
      expect(PdfUnit.values, contains(PdfUnit.cm));
      expect(PdfUnit.values, contains(PdfUnit.mm));
    });
  });

  group('PdfDimension', () {
    group('string constructor', () {
      test('should create dimension from string', () {
        const dim = PdfDimension.string('A4');
        expect(dim.value, equals('A4'));
      });

      test('should preserve empty string', () {
        const dim = PdfDimension.string('');
        expect(dim.value, equals(''));
      });

      test('should preserve numeric string', () {
        const dim = PdfDimension.string('210mm');
        expect(dim.value, equals('210mm'));
      });
    });

    group('number constructor', () {
      test('should create dimension from integer', () {
        final dim = PdfDimension.number(100);
        expect(dim.value, equals('100'));
      });

      test('should create dimension from double', () {
        final dim = PdfDimension.number(210.5);
        expect(dim.value, equals('210.5'));
      });

      test('should handle zero', () {
        final dim = PdfDimension.number(0);
        expect(dim.value, equals('0'));
      });

      test('should handle negative numbers', () {
        final dim = PdfDimension.number(-50);
        expect(dim.value, equals('-50'));
      });
    });

    group('withUnit constructor', () {
      test('should create dimension with px unit', () {
        final dim = PdfDimension.withUnit(100, PdfUnit.px);
        expect(dim.value, equals('100px'));
      });

      test('should create dimension with inch unit', () {
        final dim = PdfDimension.withUnit(8.5, PdfUnit.inch);
        expect(dim.value, equals('8.5in'));
      });

      test('should create dimension with cm unit', () {
        final dim = PdfDimension.withUnit(21, PdfUnit.cm);
        expect(dim.value, equals('21cm'));
      });

      test('should create dimension with mm unit', () {
        final dim = PdfDimension.withUnit(297, PdfUnit.mm);
        expect(dim.value, equals('297mm'));
      });

      test('should handle double values with units', () {
        final dim = PdfDimension.withUnit(29.7, PdfUnit.cm);
        expect(dim.value, equals('29.7cm'));
      });

      test('should handle zero with units', () {
        final dim = PdfDimension.withUnit(0, PdfUnit.mm);
        expect(dim.value, equals('0mm'));
      });
    });

    group('toString', () {
      test('should return the value string', () {
        const dim = PdfDimension.string('Letter');
        expect(dim.toString(), equals('Letter'));
      });

      test('should return numeric string for number constructor', () {
        final dim = PdfDimension.number(100);
        expect(dim.toString(), equals('100'));
      });

      test('should return value with unit for withUnit constructor', () {
        final dim = PdfDimension.withUnit(210, PdfUnit.mm);
        expect(dim.toString(), equals('210mm'));
      });
    });

    group('common use cases', () {
      test('should support A4 paper width in mm', () {
        final width = PdfDimension.withUnit(210, PdfUnit.mm);
        expect(width.toString(), equals('210mm'));
      });

      test('should support A4 paper height in mm', () {
        final height = PdfDimension.withUnit(297, PdfUnit.mm);
        expect(height.toString(), equals('297mm'));
      });

      test('should support Letter paper width in inches', () {
        final width = PdfDimension.withUnit(8.5, PdfUnit.inch);
        expect(width.toString(), equals('8.5in'));
      });

      test('should support Letter paper height in inches', () {
        final height = PdfDimension.withUnit(11, PdfUnit.inch);
        expect(height.toString(), equals('11in'));
      });

      test('should support pixel dimensions', () {
        final width = PdfDimension.withUnit(800, PdfUnit.px);
        expect(width.toString(), equals('800px'));
      });
    });
  });
}
