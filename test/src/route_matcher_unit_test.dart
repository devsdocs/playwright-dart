import 'package:test/test.dart';
import 'package:playwright_dart/src/core/route_matcher.dart';

void main() {
  group('RouteMatcher', () {
    group('string factory', () {
      test('should create StringRouteMatcher', () {
        final matcher = RouteMatcher.string('https://example.com');
        expect(matcher, isA<StringRouteMatcher>());
        expect(
          (matcher as StringRouteMatcher).glob,
          equals('https://example.com'),
        );
      });

      test('should handle empty string', () {
        final matcher = RouteMatcher.string('');
        expect(matcher, isA<StringRouteMatcher>());
        expect((matcher as StringRouteMatcher).glob, equals(''));
      });

      test('should handle glob patterns', () {
        final matcher = RouteMatcher.string('**/api/**');
        expect(matcher, isA<StringRouteMatcher>());
        expect((matcher as StringRouteMatcher).glob, equals('**/api/**'));
      });
    });

    group('regex factory', () {
      test('should create RegExpRouteMatcher', () {
        final matcher = RouteMatcher.regex(RegExp(r'https://example\.com/.*'));
        expect(matcher, isA<RegExpRouteMatcher>());
        expect(
          (matcher as RegExpRouteMatcher).regex.pattern,
          equals(r'https://example\.com/.*'),
        );
      });

      test('should handle simple regex', () {
        final matcher = RouteMatcher.regex(RegExp(r'.*\.png$'));
        expect(matcher, isA<RegExpRouteMatcher>());
      });

      test('should handle case-insensitive regex', () {
        final matcher = RouteMatcher.regex(
          RegExp(r'example', caseSensitive: false),
        );
        expect(matcher, isA<RegExpRouteMatcher>());
      });
    });

    group('function factory', () {
      test('should create FunctionRouteMatcher', () {
        final matcher = RouteMatcher.function((url) => true);
        expect(matcher, isA<FunctionRouteMatcher>());
      });

      test('should store the predicate function', () {
        bool called = false;
        final matcher = RouteMatcher.function((url) {
          called = true;
          return true;
        });
        expect(matcher, isA<FunctionRouteMatcher>());
        expect((matcher as FunctionRouteMatcher).predicate('test'), isTrue);
        expect(called, isTrue);
      });

      test('should handle predicate that returns false', () {
        final matcher = RouteMatcher.function((url) => false);
        expect((matcher as FunctionRouteMatcher).predicate('test'), isFalse);
      });

      test('should accept dynamic input in predicate', () {
        dynamic captured;
        final matcher = RouteMatcher.function((input) {
          captured = input;
          return true;
        });
        (matcher as FunctionRouteMatcher).predicate('https://example.com');
        expect(captured, equals('https://example.com'));
      });
    });

    group('from factory', () {
      test('should return existing RouteMatcher unchanged', () {
        final original = RouteMatcher.string('test');
        final fromFactory = RouteMatcher.from(original);
        expect(identical(original, fromFactory), isTrue);
      });

      test('should create StringRouteMatcher from String', () {
        final matcher = RouteMatcher.from('https://example.com');
        expect(matcher, isA<StringRouteMatcher>());
        expect(
          (matcher as StringRouteMatcher).glob,
          equals('https://example.com'),
        );
      });

      test('should create RegExpRouteMatcher from RegExp', () {
        final matcher = RouteMatcher.from(RegExp(r'.*\.js$'));
        expect(matcher, isA<RegExpRouteMatcher>());
      });

      test('should create FunctionRouteMatcher from Function', () {
        final matcher = RouteMatcher.from((url) => true);
        expect(matcher, isA<FunctionRouteMatcher>());
      });

      test('should throw ArgumentError for unsupported type', () {
        expect(() => RouteMatcher.from(123), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for List', () {
        expect(
          () => RouteMatcher.from([1, 2, 3]),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw ArgumentError for Map', () {
        expect(
          () => RouteMatcher.from({'key': 'value'}),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('type hierarchy', () {
      test('StringRouteMatcher should extend RouteMatcher', () {
        RouteMatcher matcher = RouteMatcher.string('test');
        expect(matcher, isA<RouteMatcher>());
      });

      test('RegExpRouteMatcher should extend RouteMatcher', () {
        RouteMatcher matcher = RouteMatcher.regex(RegExp('test'));
        expect(matcher, isA<RouteMatcher>());
      });

      test('FunctionRouteMatcher should extend RouteMatcher', () {
        RouteMatcher matcher = RouteMatcher.function((_) => true);
        expect(matcher, isA<RouteMatcher>());
      });
    });

    group('common use cases', () {
      test('should match API routes with string', () {
        final matcher = RouteMatcher.string('/api/users');
        expect((matcher as StringRouteMatcher).glob, equals('/api/users'));
      });

      test('should match image files with regex', () {
        final matcher = RouteMatcher.regex(RegExp(r'.*\.(png|jpg|gif)$'));
        expect(matcher, isA<RegExpRouteMatcher>());
      });

      test('should use custom predicate for complex matching', () {
        final matcher = RouteMatcher.function((request) {
          if (request is String) {
            return request.contains('api') && request.contains('v2');
          }
          return false;
        });
        final fn = (matcher as FunctionRouteMatcher).predicate;
        expect(fn('https://example.com/api/v2/users'), isTrue);
        expect(fn('https://example.com/api/v1/users'), isFalse);
      });
    });
  });
}
