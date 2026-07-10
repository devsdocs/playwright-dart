import 'package:test/test.dart';
import 'package:playwright_dart/src/debugging/binding_call.dart';
import 'package:playwright_dart/src/debugging/disposable.dart';
import 'package:playwright_dart/src/debugging/event_target.dart';
import 'package:playwright_dart/src/debugging/debugger.dart';
import 'package:playwright_dart/src/debugging/debug_controller.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('Debugging Module', () {
    test('DisposableImpl should call dispose', () async {
      final testConnection = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );
      testConnection.dispatchCreate('Disposable', 'Disposable_1', {});
      final disposable =
          testConnection.getObject('Disposable_1') as DisposableImpl;

      await disposable.dispose();

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'dispose',
      );
      expect(req['guid'], 'Disposable_1');
    });

    test('BindingCallImpl should call resolve', () async {
      final testConnection = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );
      testConnection.dispatchCreate('BindingCall', 'BindingCall_1', {});
      final bindingCall =
          testConnection.getObject('BindingCall_1') as BindingCallImpl;

      await bindingCall.resolve('test result');

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'resolve',
      );
      expect(req['guid'], 'BindingCall_1');
      expect(req['params']['result'], isNotNull);
    });

    test('BindingCallImpl should call reject', () async {
      final testConnection = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );
      testConnection.dispatchCreate('BindingCall', 'BindingCall_1', {});
      final bindingCall =
          testConnection.getObject('BindingCall_1') as BindingCallImpl;

      await bindingCall.reject('test error');

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'reject',
      );
      expect(req['guid'], 'BindingCall_1');
      expect(req['params']['error']['error']['message'], 'test error');
      expect(req['params']['error']['error']['name'], 'Error');
    });

    test('EventTargetImpl can be instantiated', () {
      final testConnection = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );
      testConnection.dispatchCreate('EventTarget', 'EventTarget_1', {});
      final eventTarget = testConnection.getObject('EventTarget_1');

      expect(eventTarget, isA<EventTargetImpl>());
    });

    test('DebuggerImpl should send commands and handle events', () async {
      final testConnection = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );
      testConnection.dispatchCreate('Debugger', 'Debugger_1', {});
      final debugger = testConnection.getObject('Debugger_1') as DebuggerImpl;

      final pauseFuture = debugger.onPausedStateChanged.first;
      testConnection.dispatchEvent('Debugger_1', 'pausedStateChanged', {
        'pausedDetails': {'reason': 'breakpoint'},
      });
      final details = await pauseFuture;
      expect(details['reason'], 'breakpoint');

      await debugger.requestPause();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'requestPause',
        ),
        isTrue,
      );

      await debugger.resume();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'resume',
        ),
        isTrue,
      );

      await debugger.next();
      expect(
        testConnection.transport.sentMessages.any((m) => m['method'] == 'next'),
        isTrue,
      );

      await debugger.runTo(DebuggerRunToLocation(file: 'test.dart'));
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'runTo',
        ),
        isTrue,
      );
    });

    test(
      'DebugControllerImpl should send commands and handle events',
      () async {
        final testConnection = TestConnection(
          handler: (req) => <String, dynamic>{
            'id': req['id'],
            'result': <String, dynamic>{},
          },
        );
        testConnection.dispatchCreate(
          'DebugController',
          'DebugController_1',
          {},
        );
        final controller =
            testConnection.getObject('DebugController_1')
                as DebugControllerImpl;

        final pausedFuture = controller.onPaused.first;
        testConnection.dispatchEvent('DebugController_1', 'paused', {
          'paused': true,
        });
        expect(await pausedFuture, isTrue);

        await controller.initialize(
          codegenId: 'id1',
          sdkLanguage: SDKLanguage.values.first,
        );
        final initReq = testConnection.transport.sentMessages.firstWhere(
          (m) => m['method'] == 'initialize',
        );
        expect(initReq['params']['codegenId'], 'id1');

        await controller.setReportStateChanged(enabled: true);
        expect(
          testConnection.transport.sentMessages.any(
            (m) => m['method'] == 'setReportStateChanged',
          ),
          isTrue,
        );

        await controller.highlight(selector: '.test');
        final highlightReq = testConnection.transport.sentMessages.firstWhere(
          (m) => m['method'] == 'highlight',
        );
        expect(highlightReq['params']['selector'], '.test');

        await controller.hideHighlight();
        expect(
          testConnection.transport.sentMessages.any(
            (m) => m['method'] == 'hideHighlight',
          ),
          isTrue,
        );

        await controller.resume();
        expect(
          testConnection.transport.sentMessages.any(
            (m) => m['method'] == 'resume',
          ),
          isTrue,
        );

        await controller.kill();
        expect(
          testConnection.transport.sentMessages.any(
            (m) => m['method'] == 'kill',
          ),
          isTrue,
        );
      },
    );
  });
}
