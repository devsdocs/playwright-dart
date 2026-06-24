@TestOn('vm')
library;

import 'dart:io';
import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlReporter', () {
    late HtmlReporter reporter;
    final testResultsDir = Directory('test-results/html-report');

    setUp(() async {
      // Clean up any previous test results
      if (await testResultsDir.exists()) {
        await testResultsDir.delete(recursive: true);
      }

      reporter = HtmlReporter(
        outputDir: 'test-results/html-report',
        metadata: ReportMetadata(
          title: 'Playwright Dart Test Suite',
          projectName: 'playwright-dart',
          startTime: DateTime.now(),
          environment: {
            'platform': Platform.operatingSystem,
            'dartVersion': '3.0.0',
            'playwrightVersion': '1.40.0',
          },
        ),
      );
    });

    tearDown(() async {
      // Don't clean up test results so user can view the output
    });

    test(
      'should generate comprehensive HTML report with meaningful results',
      () async {
        // Add a successful login test
        reporter.addTestResult(
          TestResult(
            name: 'User can login with valid credentials',
            file: 'test/auth/login_test.dart',
            status: TestStatus.passed,
            duration: 2340,
            steps: [
              TestStep(
                title: 'Navigate to login page',
                duration: 450,
                status: 'passed',
              ),
              TestStep(
                title: 'Enter username',
                duration: 120,
                status: 'passed',
              ),
              TestStep(title: 'Enter password', duration: 95, status: 'passed'),
              TestStep(
                title: 'Click login button',
                duration: 890,
                status: 'passed',
              ),
              TestStep(
                title: 'Verify redirect to dashboard',
                duration: 785,
                status: 'passed',
              ),
            ],
            metadata: {
              'browser': 'chromium',
              'viewport': '1920x1080',
              'testId': 'auth-001',
            },
          ),
        );

        // Add a failed checkout test
        reporter.addTestResult(
          TestResult(
            name: 'User can complete checkout process',
            file: 'test/checkout/checkout_test.dart',
            status: TestStatus.failed,
            duration: 5670,
            error:
                'Expected payment button to be visible, but it was not found',
            stackTrace: '''
    at Object.<anonymous> (test/checkout/checkout_test.dart:45:12)
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at async CheckoutPage.completePayment (test/pages/checkout_page.dart:23:8)
    at async Object.<anonymous> (test/checkout/checkout_test.dart:44:5)''',
            screenshotPath: 'test-results/screenshots/checkout-failure.png',
            steps: [
              TestStep(
                title: 'Add item to cart',
                duration: 890,
                status: 'passed',
              ),
              TestStep(
                title: 'Navigate to checkout',
                duration: 560,
                status: 'passed',
              ),
              TestStep(
                title: 'Enter shipping address',
                duration: 1240,
                status: 'passed',
              ),
              TestStep(
                title: 'Select payment method',
                duration: 780,
                status: 'passed',
              ),
              TestStep(
                title: 'Complete payment',
                duration: 2200,
                status: 'failed',
                error: 'Expected payment button to be visible',
              ),
            ],
            retryCount: 1,
            metadata: {
              'browser': 'chromium',
              'viewport': '1920x1080',
              'testId': 'checkout-002',
              'flaky': true,
            },
          ),
        );

        // Add a skipped test
        reporter.addTestResult(
          TestResult(
            name: 'User can delete account',
            file: 'test/account/delete_account_test.dart',
            status: TestStatus.skipped,
            duration: 0,
            steps: [],
            metadata: {
              'skipReason': 'Feature not yet implemented',
              'testId': 'account-003',
            },
          ),
        );

        // Add a test with video and trace
        reporter.addTestResult(
          TestResult(
            name: 'Search functionality returns relevant results',
            file: 'test/search/search_test.dart',
            status: TestStatus.passed,
            duration: 3120,
            videoPath: 'test-results/videos/search-test.webm',
            tracePath: 'test-results/traces/search-test.zip',
            steps: [
              TestStep(
                title: 'Navigate to search page',
                duration: 340,
                status: 'passed',
              ),
              TestStep(
                title: 'Enter search query',
                duration: 180,
                status: 'passed',
              ),
              TestStep(title: 'Submit search', duration: 890, status: 'passed'),
              TestStep(
                title: 'Verify search results',
                duration: 1710,
                status: 'passed',
              ),
            ],
            attachments: [
              TestAttachment(
                name: 'search-results.png',
                path: 'test-results/screenshots/search-results.png',
                contentType: 'image/png',
              ),
            ],
            metadata: {
              'browser': 'firefox',
              'viewport': '1280x720',
              'testId': 'search-004',
            },
          ),
        );

        // Add a slow test
        reporter.addTestResult(
          TestResult(
            name: 'Large file upload completes successfully',
            file: 'test/upload/upload_test.dart',
            status: TestStatus.passed,
            duration: 15400,
            steps: [
              TestStep(
                title: 'Navigate to upload page',
                duration: 320,
                status: 'passed',
              ),
              TestStep(
                title: 'Select large file (100MB)',
                duration: 150,
                status: 'passed',
              ),
              TestStep(
                title: 'Start upload',
                duration: 14930,
                status: 'passed',
              ),
            ],
            metadata: {
              'browser': 'chromium',
              'viewport': '1920x1080',
              'testId': 'upload-005',
              'slow': true,
            },
          ),
        );

        await reporter.generate();

        print('HTML report generated at: test-results/html-report/index.html');
        print('Data file generated at: test-results/html-report/data.json');
        print('');
        print('Report includes:');
        print('  - 3 passed tests');
        print('  - 1 failed test with screenshot');
        print('  - 1 skipped test');
        print('  - Tests with video and trace files');
        print('  - Tests with attachments');
        print('  - Tests with retry information');
        print('  - Tests with metadata (browser, viewport, test IDs)');

        final reportDir = Directory('test-results/html-report');
        expect(await reportDir.exists(), isTrue);

        final indexFile = File('${reportDir.path}/index.html');
        expect(await indexFile.exists(), isTrue);

        final dataFile = File('${reportDir.path}/data.json');
        expect(await dataFile.exists(), isTrue);
      },
    );
  });
}
