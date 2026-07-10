import 'package:test/test.dart';
import 'package:playwright_dart/src/network/api_request_context.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('APIRequestContext Unit Tests', () {
    test(
      'APIRequestContextImpl should call correct channel methods for HTTP requests',
      () async {
        final testConnection = TestConnection(
          handler: (request) {
            if (request['method'] == 'fetch') {
              return <String, dynamic>{
                'id': request['id'],
                'result': <String, dynamic>{
                  'response': <String, dynamic>{
                    'url': 'https://example.com',
                    'status': 200,
                    'statusText': 'OK',
                    'headers': <dynamic>[],
                    'fetchUid': 'fetch_uid_123',
                  },
                },
              };
            } else if (request['method'] == 'dispose') {
              return <String, dynamic>{
                'id': request['id'],
                'result': <String, dynamic>{},
              };
            } else if (request['method'] == 'storageState') {
              return <String, dynamic>{
                'id': request['id'],
                'result': <String, dynamic>{
                  'cookies': <dynamic>[],
                  'origins': <dynamic>[],
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
          'APIRequestContext',
          'APIRequestContext_1',
          {},
        );
        final requestContext =
            testConnection.getObject('APIRequestContext_1')
                as APIRequestContextImpl;

        // Test GET
        await requestContext.get('https://example.com/get');
        var req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/get');
        expect(req['params']['method'], 'GET');

        // Test POST
        await requestContext.post(
          'https://example.com/post',
          jsonData: '{"test":1}',
        );
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/post');
        expect(req['params']['method'], 'POST');
        expect(req['params']['jsonData'], '{"test":1}');

        // Test PUT
        await requestContext.put('https://example.com/put');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/put');
        expect(req['params']['method'], 'PUT');

        // Test DELETE
        await requestContext.delete('https://example.com/delete');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/delete');
        expect(req['params']['method'], 'DELETE');

        // Test PATCH
        await requestContext.patch('https://example.com/patch');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/patch');
        expect(req['params']['method'], 'PATCH');

        // Test HEAD
        await requestContext.head('https://example.com/head');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/head');
        expect(req['params']['method'], 'HEAD');

        // Test fetch
        await requestContext.fetch(
          'https://example.com/fetch',
          method: 'OPTIONS',
        );
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fetch',
        );
        expect(req['params']['url'], 'https://example.com/fetch');
        expect(req['params']['method'], 'OPTIONS');

        // Test storageState
        final state = await requestContext.storageState();
        expect(state.cookies, isEmpty);
        expect(state.origins, isEmpty);

        // Test dispose
        await requestContext.dispose();
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'dispose',
        );
        expect(req['params'], isEmpty);
      },
    );
  });
}
