import 'dart:io';
import 'dart:convert';
import 'package:playwright_dart/src/reporting/html_reporter.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlReporter', () {
    test(
      'generate() writes index.html and data.json and uses injected clock',
      () async {
        final dir = Directory.systemTemp.createTempSync(
          'playwright_html_report_test',
        );
        try {
          final mockTime = DateTime.utc(2025, 1, 1, 12, 0, 0);

          final reporter = HtmlReporter(
            outputDir: dir.path,
            metadata: ReportMetadata(
              title: 'Test Report',
              projectName: 'Test Project',
            ),
            clock: () => mockTime,
          );

          reporter.addTestResult(
            TestResult(
              name: 'test 1',
              file: 'test_1.dart',
              status: TestStatus.passed,
              duration: 150,
              steps: [],
            ),
          );

          await reporter.generate();

          final indexFile = File('${dir.path}/index.html');
          expect(indexFile.existsSync(), isTrue);
          final html = indexFile.readAsStringSync();
          expect(html.contains('Test Report'), isTrue);
          expect(html.contains('Test Project'), isTrue);
          // Verify clock injection works
          expect(html.contains(mockTime.toIso8601String()), isTrue);

          final dataFile = File('${dir.path}/data.json');
          expect(dataFile.existsSync(), isTrue);
          final data = jsonDecode(dataFile.readAsStringSync());
          expect(data['stats']['total'], 1);
          expect(data['stats']['passed'], 1);
          expect(data['stats']['duration'], 150);
        } finally {
          dir.deleteSync(recursive: true);
        }
      },
    );
  });
}
