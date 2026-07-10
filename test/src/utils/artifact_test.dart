import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/artifact.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('Artifact', () {
    test('ArtifactImpl calls correct channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'pathAfterFinished') {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{'value': '/tmp/artifact.png'},
            };
          } else if (request['method'] == 'failure') {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{'error': 'Network error'},
            };
          }
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );
      testConnection.dispatchCreate('Artifact', 'Artifact_1', {});
      final artifact = testConnection.getObject('Artifact_1') as ArtifactImpl;

      expect(await artifact.pathAfterFinished(), '/tmp/artifact.png');

      await artifact.saveAs('/target.png');
      expect(
        testConnection.transport.sentMessages.any(
          (m) =>
              m['method'] == 'saveAs' && m['params']['path'] == '/target.png',
        ),
        isTrue,
      );

      await artifact.delete();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'delete',
        ),
        isTrue,
      );

      expect(await artifact.failureError(), 'Network error');
      expect(await artifact.failure(), 'Network error');

      await artifact.cancel();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'cancel',
        ),
        isTrue,
      );
    });
  });
}
