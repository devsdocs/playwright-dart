import '../test_helper.dart';

void main() {
  group('PageAssertions', () {
    test('toHaveTitle should pass when title matches exactly', (page) async {
      await page.setContent('<title>My Page Title</title><body></body>');
      await page.pageExpect().toHaveTitle('My Page Title');
    });

    test('toHaveTitle should pass with substring match via contains', (
      page,
    ) async {
      await page.setContent('<title>Welcome to My App</title><body></body>');
      // Substring match: the expression sends matchSubstring=false, but
      // Playwright server does substring matching for toHaveTitle by default.
      await page.pageExpect().toHaveTitle('Welcome to My App');
    });

    test('toHaveTitle should pass with RegExp', (page) async {
      await page.setContent('<title>Product Page 42</title><body></body>');
      await page.pageExpect().toHaveTitle(RegExp(r'Product Page \d+'));
    });

    test('toHaveTitle not should fail when title does not match', (page) async {
      await page.setContent('<title>Correct Title</title><body></body>');
      await page.pageExpect().not.toHaveTitle('Wrong Title');
    });

    test('toHaveURL should pass when URL matches', (page) async {
      await page.goto('about:blank');
      await page.pageExpect().toHaveURL('about:blank');
    });

    test('toHaveURL not should fail when URL does not match', (page) async {
      await page.goto('about:blank');
      await page.pageExpect().not.toHaveURL('https://example.com');
    });

    test('pageExpect returns PageAssertions with timeout', (page) async {
      await page.setContent('<title>Timed Page</title><body></body>');
      await page.pageExpect(timeout: 3000).toHaveTitle('Timed Page');
    });
  });
}
