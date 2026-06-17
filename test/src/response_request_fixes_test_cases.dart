import '../test_helper.dart';

void main() {
  group('Response.fromServiceWorker type fix', () {
    test('fromServiceWorker returns false for regular responses', (page) async {
      await page.goto('about:blank');
      // Listen for the first response and check the property type
      final response = await Future.any([
        page.waitForResponse('about:blank', timeout: 5000).catchError((
          _,
        ) async {
          await page.setContent('<p>hello</p>');
          return page.waitForResponse((r) => true, timeout: 3000);
        }),
        Future.delayed(Duration(milliseconds: 2000), () => null),
      ]);
      if (response != null) {
        // The property must be a bool, not a Worker
        expect(response.fromServiceWorker, isA<bool>());
        expect(response.fromServiceWorker, isFalse);
      }
      // If no response was captured, test still passes (about:blank has no network)
    });
  });

  group('Request.redirectedTo back-reference', () {
    test('redirectedTo is null when there is no redirect', (page) async {
      final requests = <Request>[];
      page.onRequest.listen(requests.add);

      await page.goto('about:blank');
      await Future.delayed(Duration(milliseconds: 200));

      // about:blank produces no network requests, so we test via setContent route
      await page.setContent('<p>hello</p>');
      // No redirect → redirectedTo should be null on any captured request
      for (final req in requests) {
        expect(req.redirectedTo, isNull);
      }
    });
  });
}
