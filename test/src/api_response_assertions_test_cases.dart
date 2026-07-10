import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('APIResponseAssertions', () {
    test('APIResponseAssertions should check toBeOK', (page) async {
      final response = await page.request.get('https://example.com');
      await APIResponseAssertions(response).toBeOK();

      final response404 = await page.request.get(
        'https://example.com/non-existent',
      );
      await expectLater(
        () => APIResponseAssertions(response404).toBeOK(),
        throwsA(isA<AssertionError>()),
      );

      await APIResponseAssertions(response404).not.toBeOK();
    });

    test('APIResponseAssertions should check status', (page) async {
      final response = await page.request.get('https://example.com');
      await APIResponseAssertions(response).toHaveStatus(200);
      await APIResponseAssertions(response).toHaveStatusInRange(200, 299);

      await expectLater(
        () => APIResponseAssertions(response).toHaveStatus(404),
        throwsA(isA<AssertionError>()),
      );
      await APIResponseAssertions(response).not.toHaveStatus(404);
    });

    test('APIResponseAssertions should check status text', (page) async {
      final response = await page.request.get('https://example.com');
      await APIResponseAssertions(response).toHaveStatusText('OK');

      await expectLater(
        () => APIResponseAssertions(response).toHaveStatusText('Not Found'),
        throwsA(isA<AssertionError>()),
      );
      await APIResponseAssertions(response).not.toHaveStatusText('Not Found');
    });

    test('APIResponseAssertions should check URL', (page) async {
      final response = await page.request.get('https://example.com');
      await APIResponseAssertions(response).toHaveURL('https://example.com/');
      await APIResponseAssertions(
        response,
      ).toHaveURL(RegExp(r'.*example\.com.*'));

      await expectLater(
        () => APIResponseAssertions(response).toHaveURL('https://google.com/'),
        throwsA(isA<AssertionError>()),
      );
      await APIResponseAssertions(
        response,
      ).not.toHaveURL('https://google.com/');
    });

    test(
      'APIResponseAssertions should check successful, client error, server error',
      (page) async {
        final response = await page.request.get('https://example.com');
        await APIResponseAssertions(response).toBeSuccessful();
        await expectLater(
          () => APIResponseAssertions(response).toBeClientError(),
          throwsA(isA<AssertionError>()),
        );
        await expectLater(
          () => APIResponseAssertions(response).toBeServerError(),
          throwsA(isA<AssertionError>()),
        );

        final response404 = await page.request.get('https://example.com/404');
        await APIResponseAssertions(response404).toBeClientError();
        await expectLater(
          () => APIResponseAssertions(response404).toBeSuccessful(),
          throwsA(isA<AssertionError>()),
        );
        await APIResponseAssertions(response404).not.toBeSuccessful();
      },
    );

    test('APIResponseAssertions should check header', (page) async {
      final response = await page.request.get('https://example.com');
      await APIResponseAssertions(response).toHaveHeader('content-type', null);
      await APIResponseAssertions(
        response,
      ).toHaveHeader('content-type', 'text/html');

      await expectLater(
        () => APIResponseAssertions(
          response,
        ).toHaveHeader('non-existent-header', null),
        throwsA(isA<AssertionError>()),
      );
      await expectLater(
        () => APIResponseAssertions(
          response,
        ).toHaveHeader('content-type', 'application/json'),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
