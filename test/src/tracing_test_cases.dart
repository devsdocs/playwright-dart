import 'dart:io';

import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Tracing API', () {
    test('should record and stop tracing, returning zip bytes', (page) async {
      final context = page.context;
      await context.tracing.start(screenshots: true, snapshots: true);
      await context.tracing.startChunk(name: 'test_trace', title: 'Test Trace');

      await page.goto('https://example.com');
      await page.locator('h1').isVisible();

      final result = await context.tracing.stopChunk(
        mode: TracingTracingStopChunkModeEnum.archive,
      );

      expect(result.artifact, isNotNull);

      final artifact = result.artifact! as Artifact;
      final streamResult = await artifact.stream();
      final stream = streamResult.stream as PlaywrightStream;

      final buffer = <int>[];
      while (true) {
        final chunk = await stream.read();
        if (chunk.isEmpty) break;
        buffer.addAll(chunk);
      }

      expect(buffer, isNotEmpty);
      expect(buffer.length, greaterThan(100)); // Zip file should be substantial

      // Optional: Save it temporarily to ensure it writes correctly
      final tempFile = File('test_trace.zip');
      await tempFile.writeAsBytes(buffer);
      expect(await tempFile.exists(), isTrue);

      // Verify it's a valid ZIP file (PK signature)
      final signature = String.fromCharCodes(buffer.sublist(0, 2));
      expect(signature, equals('PK'));

      await tempFile.delete();
      await artifact.delete();
    });
  });
}
