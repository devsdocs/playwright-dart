import 'package:test/test.dart';
import 'package:playwright_dart/src/core/page.dart';
import 'package:playwright_dart/src/interaction/keyboard_key.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('Keyboard and Mouse Unit Tests', () {
    test('Keyboard should call correct page channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      });
      final page = testConnection.getObject('Page_1') as PageImpl;

      await page.keyboard.down('Shift');
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardDown',
      );
      expect(req['params']['key'], 'Shift');

      await page.keyboard.downKey(KeyboardKey.control);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardDown',
      );
      expect(req['params']['key'], 'Control');

      await page.keyboard.up('Shift');
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardUp',
      );
      expect(req['params']['key'], 'Shift');

      await page.keyboard.upKey(KeyboardKey.control);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardUp',
      );
      expect(req['params']['key'], 'Control');

      await page.keyboard.insertText('Hello');
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardInsertText',
      );
      expect(req['params']['text'], 'Hello');

      await page.keyboard.type('World', delay: 100);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardType',
      );
      expect(req['params']['text'], 'World');
      expect(req['params']['delay'], 100);

      await page.keyboard.press('Enter', delay: 50);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardPress',
      );
      expect(req['params']['key'], 'Enter');
      expect(req['params']['delay'], 50);

      await page.keyboard.pressKey(KeyboardKey.enter);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'keyboardPress',
      );
      expect(req['params']['key'], 'Enter');
    });

    test('Mouse should call correct page channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      });
      final page = testConnection.getObject('Page_1') as PageImpl;

      await page.mouse.move(100, 200, steps: 5);
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseMove',
      );
      expect(req['params']['x'], 100);
      expect(req['params']['y'], 200);
      expect(req['params']['steps'], 5);

      await page.mouse.down(
        button: PageMouseDownButtonEnum.right,
        clickCount: 2,
      );
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseDown',
      );
      expect(req['params']['button'], 'right');
      expect(req['params']['clickCount'], 2);

      await page.mouse.up(button: PageMouseUpButtonEnum.right, clickCount: 2);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseUp',
      );
      expect(req['params']['button'], 'right');
      expect(req['params']['clickCount'], 2);

      await page.mouse.click(
        50,
        60,
        button: PageMouseClickButtonEnum.middle,
        delay: 10,
        clickCount: 3,
      );
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseClick',
      );
      expect(req['params']['x'], 50);
      expect(req['params']['y'], 60);
      expect(req['params']['button'], 'middle');
      expect(req['params']['delay'], 10);
      expect(req['params']['clickCount'], 3);

      await page.mouse.dblclick(
        70,
        80,
        button: PageMouseClickButtonEnum.left,
        delay: 20,
      );
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseClick',
      );
      expect(req['params']['x'], 70);
      expect(req['params']['y'], 80);
      expect(req['params']['button'], 'left');
      expect(req['params']['delay'], 20);
      expect(req['params']['clickCount'], 2);

      await page.mouse.wheel(15, 25);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'mouseWheel',
      );
      expect(req['params']['deltaX'], 15);
      expect(req['params']['deltaY'], 25);
    });

    test('Touchscreen should call correct page channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      });
      final page = testConnection.getObject('Page_1') as PageImpl;

      await page.touchscreen.tap(10, 20);
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'touchscreenTap',
      );
      expect(req['params']['x'], 10);
      expect(req['params']['y'], 20);
    });
  });
}
