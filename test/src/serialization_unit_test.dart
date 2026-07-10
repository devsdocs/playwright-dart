import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/serialization.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'package:playwright_dart/src/interaction/interaction_types.dart';
import 'package:playwright_dart/src/infrastructure/file_payload.dart';

void main() {
  group('parseSerializedValue', () {
    test('returns double when n is set', () {
      expect(parseSerializedValue(SerializedValue(n: 42.0)), equals(42.0));
    });

    test('returns int-like double for integer values', () {
      expect(parseSerializedValue(SerializedValue(n: 0.0)), equals(0.0));
    });

    test('returns bool true', () {
      expect(parseSerializedValue(SerializedValue(b: true)), isTrue);
    });

    test('returns bool false', () {
      expect(parseSerializedValue(SerializedValue(b: false)), isFalse);
    });

    test('returns string', () {
      expect(
        parseSerializedValue(SerializedValue(s: 'hello')),
        equals('hello'),
      );
    });

    test('returns empty string', () {
      expect(parseSerializedValue(SerializedValue(s: '')), equals(''));
    });

    test('returns null for undefined v', () {
      expect(
        parseSerializedValue(
          SerializedValue(v: SerializedValueVEnum.undefined),
        ),
        isNull,
      );
    });

    test('returns null for null v', () {
      expect(
        parseSerializedValue(
          SerializedValue(v: SerializedValueVEnum.nullValue),
        ),
        isNull,
      );
    });

    test('returns NaN for nan v', () {
      final result = parseSerializedValue(
        SerializedValue(v: SerializedValueVEnum.nan),
      );
      expect(result is double && (result).isNaN, isTrue);
    });

    test('returns Infinity for infinity v', () {
      expect(
        parseSerializedValue(SerializedValue(v: SerializedValueVEnum.infinity)),
        equals(double.infinity),
      );
    });

    test('returns -Infinity for minusInfinity v', () {
      expect(
        parseSerializedValue(
          SerializedValue(v: SerializedValueVEnum.minusInfinity),
        ),
        equals(double.negativeInfinity),
      );
    });

    test('returns -0.0 for minusZero v', () {
      final result =
          parseSerializedValue(
                SerializedValue(v: SerializedValueVEnum.minusZero),
              )
              as double;
      expect(result, equals(-0.0));
      expect(result.isNegative, isTrue);
    });

    test('returns RegExp for r field', () {
      final result = parseSerializedValue(
        SerializedValue(
          r: SerializedValueR(p: r'foo\d+', f: ''),
        ),
      );
      expect(result, isA<RegExp>());
      expect((result as RegExp).pattern, equals(r'foo\d+'));
    });

    test('RegExp with i flag is case-insensitive', () {
      final result =
          parseSerializedValue(
                SerializedValue(
                  r: SerializedValueR(p: 'hello', f: 'i'),
                ),
              )
              as RegExp;
      expect(result.isCaseSensitive, isFalse);
    });

    test('RegExp with m flag is multiline', () {
      final result =
          parseSerializedValue(
                SerializedValue(
                  r: SerializedValueR(p: 'test', f: 'm'),
                ),
              )
              as RegExp;
      expect(result.isMultiLine, isTrue);
    });

    test('parses list (a field)', () {
      final sv = SerializedValue(
        a: [
          SerializedValue(n: 1.0),
          SerializedValue(s: 'two'),
          SerializedValue(b: true),
        ],
      );
      final result = parseSerializedValue(sv) as List;
      expect(result, equals([1.0, 'two', true]));
    });

    test('parses nested list', () {
      final sv = SerializedValue(
        a: [
          SerializedValue(a: [SerializedValue(n: 99.0)]),
        ],
      );
      final result = parseSerializedValue(sv) as List;
      expect(result[0], equals([99.0]));
    });

    test('parses object (o field)', () {
      final sv = SerializedValue(
        o: [
          SerializedValueOItems(k: 'x', v: SerializedValue(n: 1.0)),
          SerializedValueOItems(
            k: 'y',
            v: SerializedValue(s: 'hi'),
          ),
        ],
      );
      final result = parseSerializedValue(sv) as Map<String, dynamic>;
      expect(result['x'], equals(1.0));
      expect(result['y'], equals('hi'));
    });

    test('returns null for empty SerializedValue', () {
      expect(parseSerializedValue(SerializedValue()), isNull);
    });
  });

  group('serializeValue', () {
    test('serializes null', () {
      final sv = serializeValue(null);
      expect(sv.v, equals(SerializedValueVEnum.undefined));
    });

    test('serializes int as double n', () {
      final sv = serializeValue(42);
      expect(sv.n, equals(42.0));
    });

    test('serializes double', () {
      final sv = serializeValue(3.14);
      expect(sv.n, equals(3.14));
    });

    test('serializes NaN', () {
      final sv = serializeValue(double.nan);
      expect(sv.v, equals(SerializedValueVEnum.nan));
    });

    test('serializes Infinity', () {
      final sv = serializeValue(double.infinity);
      expect(sv.v, equals(SerializedValueVEnum.infinity));
    });

    test('serializes -Infinity', () {
      final sv = serializeValue(double.negativeInfinity);
      expect(sv.v, equals(SerializedValueVEnum.minusInfinity));
    });

    test('serializes -0.0', () {
      final sv = serializeValue(-0.0);
      expect(sv.v, equals(SerializedValueVEnum.minusZero));
    });

    test('serializes true', () {
      final sv = serializeValue(true);
      expect(sv.b, isTrue);
    });

    test('serializes false', () {
      final sv = serializeValue(false);
      expect(sv.b, isFalse);
    });

    test('serializes string', () {
      final sv = serializeValue('hello world');
      expect(sv.s, equals('hello world'));
    });

    test('serializes empty string', () {
      final sv = serializeValue('');
      expect(sv.s, equals(''));
    });

    test('serializes RegExp without flags', () {
      final sv = serializeValue(RegExp(r'foo\d+'));
      expect(sv.r, isNotNull);
      expect(sv.r!.p, equals(r'foo\d+'));
      expect(sv.r!.f, equals(''));
    });

    test('serializes case-insensitive RegExp with i flag', () {
      final sv = serializeValue(RegExp('test', caseSensitive: false));
      expect(sv.r!.f, contains('i'));
    });

    test('serializes multiline RegExp with m flag', () {
      final sv = serializeValue(RegExp('test', multiLine: true));
      expect(sv.r!.f, contains('m'));
    });

    test('serializes List', () {
      final sv = serializeValue([1, 'two', true]);
      expect(sv.a, isNotNull);
      expect(sv.a!.length, equals(3));
      expect(sv.a![0].n, equals(1.0));
      expect(sv.a![1].s, equals('two'));
      expect(sv.a![2].b, isTrue);
    });

    test('serializes empty List', () {
      final sv = serializeValue([]);
      expect(sv.a, isEmpty);
    });

    test('serializes Map<String, dynamic>', () {
      final sv = serializeValue({'x': 1, 'y': 'hello'});
      expect(sv.o, isNotNull);
      expect(sv.o!.length, equals(2));
      final keys = sv.o!.map((e) => e.k).toSet();
      expect(keys, containsAll(['x', 'y']));
    });

    test('serializes nested Map', () {
      final sv = serializeValue({
        'inner': {'val': 42},
      });
      expect(sv.o, isNotNull);
      final inner = sv.o!.firstWhere((e) => e.k == 'inner');
      expect(inner.v.o, isNotNull);
    });

    test('unknown type returns undefined', () {
      final sv = serializeValue(Object());
      expect(sv.v, equals(SerializedValueVEnum.undefined));
    });
  });

  group('serializeArgument', () {
    test('wraps value in SerializedArgument with empty handles', () {
      final arg = serializeArgument(42);
      expect(arg, isA<SerializedArgument>());
      expect(arg.handles, isEmpty);
      expect(arg.value.n, equals(42.0));
    });

    test('works with null', () {
      final arg = serializeArgument(null);
      expect(arg.value.v, equals(SerializedValueVEnum.undefined));
    });

    test('works with string', () {
      final arg = serializeArgument('test');
      expect(arg.value.s, equals('test'));
    });
  });

  group('roundtrip serializeValue → parseSerializedValue', () {
    void roundtrip(dynamic value, {dynamic expected}) {
      final sv = serializeValue(value);
      final result = parseSerializedValue(sv);
      expect(result, equals(expected ?? value));
    }

    test('null roundtrips', () {
      final sv = serializeValue(null);
      expect(parseSerializedValue(sv), isNull);
    });

    test('integer roundtrips as double', () => roundtrip(42, expected: 42.0));
    test('double roundtrips', () => roundtrip(3.14));
    test('bool true roundtrips', () => roundtrip(true));
    test('bool false roundtrips', () => roundtrip(false));
    test('string roundtrips', () => roundtrip('hello'));
    test('empty string roundtrips', () => roundtrip(''));
    test('list roundtrips', () => roundtrip([1.0, 'two', false]));
    test('map roundtrips', () => roundtrip({'a': 1.0, 'b': 'x'}));

    test('Infinity roundtrips', () {
      final sv = serializeValue(double.infinity);
      expect(parseSerializedValue(sv), equals(double.infinity));
    });

    test('-Infinity roundtrips', () {
      final sv = serializeValue(double.negativeInfinity);
      expect(parseSerializedValue(sv), equals(double.negativeInfinity));
    });

    test('NaN roundtrips', () {
      final sv = serializeValue(double.nan);
      final result = parseSerializedValue(sv) as double;
      expect(result.isNaN, isTrue);
    });
  });

  group('parseSelectOptions', () {
    test('returns empty params for null input', () {
      final result = parseSelectOptions(null);
      expect(result.elements, isNull);
      expect(result.options, isNull);
    });

    test('returns empty params for empty list', () {
      final result = parseSelectOptions([]);
      expect(result.elements, isNull);
      expect(result.options, isNull);
    });

    test('extracts value-based options', () {
      final result = parseSelectOptions([
        SelectOption(value: 'opt1'),
        SelectOption(value: 'opt2'),
      ]);
      expect(result.options, isNotNull);
      expect(result.options!.length, equals(2));
      expect(result.options!.first['value'], equals('opt1'));
    });

    test('extracts label-based options', () {
      final result = parseSelectOptions([SelectOption(label: 'Option 1')]);
      expect(result.options, isNotNull);
      expect(result.options!.first['label'], equals('Option 1'));
    });

    test('extracts index-based options', () {
      final result = parseSelectOptions([SelectOption(index: 0)]);
      expect(result.options, isNotNull);
      expect(result.options!.first['index'], equals(0));
    });

    test('mixed options and elements — elements go to elements list', () {
      final result = parseSelectOptions([SelectOption(value: 'v1')]);
      expect(result.options, isNotNull);
      expect(result.elements, isNull);
    });
  });

  group('parseInputFiles', () {
    test('returns empty params for null', () {
      final result = parseInputFiles(null);
      expect(result.payloads, isNull);
      expect(result.localPaths, isNull);
    });

    test('returns empty params for empty list', () {
      final result = parseInputFiles([]);
      expect(result.payloads, isNull);
      expect(result.localPaths, isNull);
    });

    test('extracts local path from InputFile.path', () {
      final result = parseInputFiles([InputFile.path('/tmp/file.txt')]);
      expect(result.localPaths, isNotNull);
      expect(result.localPaths!.first, equals('/tmp/file.txt'));
      expect(result.payloads, isNull);
    });

    test('extracts multiple local paths', () {
      final result = parseInputFiles([
        InputFile.path('/tmp/a.txt'),
        InputFile.path('/tmp/b.txt'),
      ]);
      expect(result.localPaths!.length, equals(2));
    });

    test('extracts payload from InputFile.payload with base64 buffer', () {
      final result = parseInputFiles([
        InputFile.payload(
          FilePayload(
            name: 'test.txt',
            mimeType: 'text/plain',
            buffer: [104, 101, 108, 108, 111], // "hello"
          ),
        ),
      ]);
      expect(result.payloads, isNotNull);
      expect(result.payloads!.first['name'], equals('test.txt'));
      expect(result.payloads!.first['mimeType'], equals('text/plain'));
      expect(result.payloads!.first['buffer'], equals('aGVsbG8='));
      expect(result.localPaths, isNull);
    });

    test('mixed paths and payloads', () {
      final result = parseInputFiles([
        InputFile.path('/tmp/local.txt'),
        InputFile.payload(
          FilePayload(name: 'uploaded.txt', mimeType: 'text/plain', buffer: []),
        ),
      ]);
      expect(result.localPaths, isNotNull);
      expect(result.payloads, isNotNull);
    });
  });
}
