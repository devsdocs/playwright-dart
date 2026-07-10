import 'package:test/test.dart';
import 'package:playwright_dart/src/platform/electron.dart';
import 'package:playwright_dart/src/platform/electron_application.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('Electron API', () {
    test('launch sends command and returns ElectronApplication', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'launch') {
            return {
              'id': request['id'],
              'result': {
                'electronApplication': {'guid': 'ElectronApplication_1'},
              },
            };
          }
          return {};
        },
      );

      testConnection.dispatchCreate('Electron', 'Electron_1', {});
      final electron = testConnection.getObject('Electron_1') as ElectronImpl;

      testConnection.dispatchCreate(
        'ElectronApplication',
        'ElectronApplication_1',
        {
          'context': {'guid': 'BrowserContext_1'},
          'process': {'guid': 'ChildProcess_1'},
        },
      );

      final app = await electron.launch(
        executablePath: '/usr/bin/electron',
        timeout: 10000,
      );

      expect(app, isNotNull);

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'launch',
      );
      expect(req['params']['executablePath'], '/usr/bin/electron');
      expect(req['params']['timeout'], 10000);
    });

    test('ElectronApplicationImpl should call correct channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'evaluateExpression') {
            return {
              'id': request['id'],
              'result': {
                'value': {'b': true},
              },
            };
          } else if (request['method'] == 'evaluateExpressionHandle') {
            return {
              'id': request['id'],
              'result': {
                'handle': {'guid': 'JSHandle_1'},
              },
            };
          } else if (request['method'] == 'browserWindow') {
            return {
              'id': request['id'],
              'result': {
                'handle': {'guid': 'JSHandle_2'},
              },
            };
          }
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate(
        'ElectronApplication',
        'ElectronApplication_1',
        {
          'context': {'guid': 'BrowserContext_1'},
          'process': {'guid': 'ChildProcess_1'},
        },
      );
      final app =
          testConnection.getObject('ElectronApplication_1')
              as ElectronApplicationImpl;

      testConnection.dispatchCreate('JSHandle', 'JSHandle_1', {});
      testConnection.dispatchCreate('JSHandle', 'JSHandle_2', {});

      // We don't have Page_1 in the mock, so we can't easily test browserWindow
      // without creating a mock Page object. Let's test evaluateExpression.

      final evalResult = await app.evaluateExpression(
        '1 + 1',
        isFunction: false,
        arg: 'test',
      );
      expect(evalResult, true); // Since our mock returns {'b': true}
      final evalReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'evaluateExpression',
      );
      expect(evalReq['params']['expression'], '1 + 1');
      expect(evalReq['params']['arg'], isNotNull);

      final handle = await app.evaluateExpressionHandle(
        '() => window',
        isFunction: true,
      );
      expect(handle, isNotNull);
      final handleReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'evaluateExpressionHandle',
      );
      expect(handleReq['params']['expression'], '() => window');

      await app.updateSubscription(
        ElectronApplicationUpdateSubscriptionEventEnum.console,
        true,
      );
      final subReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'updateSubscription',
      );
      expect(subReq['params']['event'], 'console');
      expect(subReq['params']['enabled'], true);
    });
  });
}
