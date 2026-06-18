import 'package:playwright_dart/playwright_dart.dart';

/// Example demonstrating HTML reporter with asset copying.
void main() async {
  // Create HTML reporter
  final reporter = HtmlReporter(
    outputDir: 'test-results/html-report',
    metadata: ReportMetadata(
      title: 'My Test Suite Report',
      projectName: 'My Project',
      startTime: DateTime.now(),
      environment: {
        'platform': 'windows',
        'dartVersion': '3.0.0',
        'nodeVersion': 'v20.0.0',
      },
    ),
  );

  // Add test results with assets
  reporter.addTestResult(TestResult(
    name: 'Example Test 1',
    file: 'tests/example_test.dart',
    status: TestStatus.passed,
    duration: 1500,
    screenshotPath: 'test-results/screenshots/test1.png',
    videoPath: 'test-results/videos/test1.webm',
    tracePath: 'test-results/traces/test1.zip',
    steps: [
      TestStep(
        title: 'Navigate to page',
        duration: 500,
        status: 'passed',
      ),
      TestStep(
        title: 'Click button',
        duration: 300,
        status: 'passed',
      ),
      TestStep(
        title: 'Verify text',
        duration: 700,
        status: 'passed',
      ),
    ],
    attachments: [
      TestAttachment(
        name: 'screenshot.png',
        path: 'test-results/screenshots/test1.png',
        contentType: 'image/png',
      ),
    ],
    metadata: {
      'browser': 'chromium',
      'viewport': '1280x720',
    },
  ));

  reporter.addTestResult(TestResult(
    name: 'Example Test 2',
    file: 'tests/example_test.dart',
    status: TestStatus.failed,
    duration: 2300,
    error: 'Expected element to be visible',
    stackTrace: 'at Object.<anonymous> (tests/example_test.dart:15:10)\n'
        'at processTicksAndRejections (node:internal/process/task_queues:96:5)',
    screenshotPath: 'test-results/screenshots/test2-failure.png',
    steps: [
      TestStep(
        title: 'Navigate to page',
        duration: 500,
        status: 'passed',
      ),
      TestStep(
        title: 'Click button',
        duration: 300,
        status: 'passed',
      ),
      TestStep(
        title: 'Verify text',
        duration: 1500,
        status: 'failed',
        error: 'Expected element to be visible',
      ),
    ],
    retryCount: 1,
    metadata: {
      'browser': 'chromium',
      'viewport': '1280x720',
    },
  ));

  // Generate the report
  // This will:
  // 1. Create the output directory
  // 2. Generate index.html with embedded CSS and JavaScript
  // 3. Generate data.json for dynamic loading
  // 4. Copy assets (screenshots, videos, traces, attachments) to assets/ subdirectory
  await reporter.generate();

  print('HTML report generated at test-results/html-report/index.html');
  print('Assets copied to:');
  print('  - test-results/html-report/assets/screenshots/');
  print('  - test-results/html-report/assets/videos/');
  print('  - test-results/html-report/assets/traces/');
  print('  - test-results/html-report/assets/attachments/');
}
