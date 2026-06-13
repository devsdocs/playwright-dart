import '../test_helper.dart';

void main() {
  group('Real World Scenarios', () {
    test('TodoMVC: End-to-End interaction', (page) async {
      await page.goto('https://demo.playwright.dev/todomvc/');

      // Wait for the app to initialize
      await page.waitForSelector('.new-todo');

      // Add a new todo
      final newTodo = page.locator('.new-todo');
      await newTodo.fill('Learn Playwright Dart');
      await page.keyboard.press('Enter');

      // Verify it was added
      final todoItems = page.locator('.todo-list li');
      expect(await todoItems.evaluateAll('els => els.length'), equals(1));
      expect(await todoItems.textContent(), contains('Learn Playwright Dart'));

      // Add another todo
      await newTodo.fill('Write more tests');
      await page.keyboard.press('Enter');
      expect(await todoItems.evaluateAll('els => els.length'), equals(2));

      // Mark the first one as completed
      // Since we don't have nth() yet, let's use page.locator with nth-child
      final firstCheckbox = page.locator('.todo-list li:first-child .toggle');
      await firstCheckbox.check();

      // Verify it has the completed class
      final className = await page
          .locator('.todo-list li:first-child')
          .evaluate("el => el.className");
      expect(className, contains('completed'));

      // Filter to show only active
      await page.locator('a[href="#/active"]').click();

      // Wait for filtering to apply
      await Future.delayed(Duration(milliseconds: 500));

      expect(
        await page
            .locator('.todo-list li:visible')
            .evaluateAll('els => els.length'),
        equals(1),
      );
      expect(
        await page.locator('.todo-list li:visible').textContent(),
        contains('Write more tests'),
      );

      // Clear completed
      await page.locator('.clear-completed').click();

      // Go back to all
      await page.locator('a[href="#/"]').click();
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        await page
            .locator('.todo-list li:visible')
            .evaluateAll('els => els.length'),
        equals(1),
      );
      expect(
        await page.locator('.todo-list li:visible').textContent(),
        contains('Write more tests'),
      );
    }, timeout: Timeout(Duration(seconds: 45)));

    test(
      'Playwright Dev: Navigation and Search',
      (page) async {
        await page.goto('https://playwright.dev/');

        // Check title
        final title = await page.title();
        expect(title, contains('Playwright'));

        // Click "Get started" link - use a more specific selector
        await page.locator('.hero__subtitle a, a.getStarted, a:has-text("Get started")').click(timeout: 15000);

        // Verify navigation to intro/installation page
        final currentUrl = await page.evaluate('() => window.location.href');
        expect(currentUrl, anyOf(contains('/docs/intro'), contains('/docs/')));
      },
      timeout: Timeout(Duration(seconds: 60)),
    );
  });
}
