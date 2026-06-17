import '../test_helper.dart';

void main() {
  group('Infrastructure Interfaces', () {
    test('BindingCall interface exists', (page) {
      expect(BindingCall, isNotNull);
    });

    test('JsonPipe interface exists', (page) {
      expect(JsonPipe, isNotNull);
    });

    test('WritableStream interface exists', (page) {
      expect(WritableStream, isNotNull);
    });

    test('PlaywrightStream interface exists', (page) {
      expect(PlaywrightStream, isNotNull);
    });

    test('Root interface exists', (page) {
      expect(Root, isNotNull);
    });

    test('LocalUtils interface exists', (page) {
      expect(LocalUtils, isNotNull);
    });

    test('Disposable interface exists', (page) {
      expect(Disposable, isNotNull);
    });

    test('EventTarget interface exists', (page) {
      expect(EventTarget, isNotNull);
    });
  });
}
