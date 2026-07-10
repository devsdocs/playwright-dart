import 'package:test/test.dart';
import 'package:playwright_dart/src/interaction/dialog.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('DialogImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );

      // Dialog initializer needs a page ref — pre-create the Page.
      testConn.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConn.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      });

      testConn.dispatchCreate('Dialog', 'Dialog_1', {
        'type': 'confirm',
        'message': 'Are you sure?',
        'defaultValue': 'default text',
        'page': {'guid': 'Page_1'},
      });
    });

    test('DialogImpl is created from dispatchCreate', () {
      expect(testConn.getObject('Dialog_1'), isA<DialogImpl>());
    });

    test('implements Dialog interface', () {
      expect(testConn.getObject('Dialog_1'), isA<Dialog>());
    });

    test('type returns value from initializer', () {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      expect(dialog.type, equals('confirm'));
    });

    test('message returns value from initializer', () {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      expect(dialog.message, equals('Are you sure?'));
    });

    test('defaultValue returns value from initializer', () {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      expect(dialog.defaultValue, equals('default text'));
    });

    test('accept sends accept message', () async {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      await dialog.accept();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'accept'),
        isTrue,
      );
    });

    test('accept sends promptText when provided', () async {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      await dialog.accept(promptText: 'user input');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'accept',
      );
      expect(msg['params']['promptText'], equals('user input'));
    });

    test('accept sends no promptText when not provided', () async {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      await dialog.accept();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'accept',
      );
      expect(msg['params'].containsKey('promptText'), isFalse);
    });

    test('dismiss sends dismiss message', () async {
      final dialog = testConn.getObject('Dialog_1') as DialogImpl;
      await dialog.dismiss();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'dismiss'),
        isTrue,
      );
    });

    test('different dialog types work', () async {
      testConn.dispatchCreate('Dialog', 'Dialog_alert', {
        'type': 'alert',
        'message': 'Hello!',
        'defaultValue': '',
        'page': {'guid': 'Page_1'},
      });
      final dialog = testConn.getObject('Dialog_alert') as DialogImpl;
      expect(dialog.type, equals('alert'));
      expect(dialog.message, equals('Hello!'));
    });

    test('prompt dialog type', () async {
      testConn.dispatchCreate('Dialog', 'Dialog_prompt', {
        'type': 'prompt',
        'message': 'Enter value:',
        'defaultValue': 'suggested',
        'page': {'guid': 'Page_1'},
      });
      final dialog = testConn.getObject('Dialog_prompt') as DialogImpl;
      expect(dialog.type, equals('prompt'));
      expect(dialog.defaultValue, equals('suggested'));
    });
  });
}
