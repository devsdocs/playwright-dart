import 'package:test/test.dart';
import 'package:playwright_dart/src/core/page.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('Video API', () {
    test('path() calls pathAfterFinished on underlying artifact', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'pathAfterFinished') {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{'value': '/tmp/video.webm'},
            };
          }
          return <String, dynamic>{};
        },
      );

      testConnection.dispatchCreate('Artifact', 'Artifact_1', {
        'absolutePath': '/tmp/recording.webm',
      });
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
        'video': {'guid': 'Artifact_1'},
      });

      final page = testConnection.getObject('Page_1') as PageImpl;
      final video = page.video();

      expect(video, isNotNull);

      final path = await video!.path();
      expect(path, '/tmp/video.webm');

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'pathAfterFinished',
      );
      expect(req['guid'], 'Artifact_1');
    });

    test('saveAs() and delete() call corresponding artifact methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'saveAs' || request['method'] == 'delete') {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{},
            };
          }
          return <String, dynamic>{};
        },
      );

      testConnection.dispatchCreate('Artifact', 'Artifact_1', {
        'absolutePath': '/tmp/recording.webm',
      });
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
        'video': {'guid': 'Artifact_1'},
      });

      final page = testConnection.getObject('Page_1') as PageImpl;
      final video = page.video();

      await video!.saveAs('/dest/video.webm');
      final saveReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'saveAs',
      );
      expect(saveReq['guid'], 'Artifact_1');
      expect(saveReq['params']['path'], '/dest/video.webm');

      await video.delete();
      final deleteReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'delete',
      );
      expect(deleteReq['guid'], 'Artifact_1');
    });
  });
}
