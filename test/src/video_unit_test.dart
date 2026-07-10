import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/video.dart';
import 'package:playwright_dart/src/utils/artifact.dart';
import 'package:playwright_dart/src/core/page.dart';

void main() {
  group('Video Unit Tests', () {
    late _MockArtifact artifact;
    late _MockPage page;
    late Video video;

    setUp(() {
      artifact = _MockArtifact();
      page = _MockPage();
      video = Video(page, artifact);
    });

    test('page property returns the page', () {
      expect(video.page, same(page));
    });

    test('path delegates to artifact.pathAfterFinished', () async {
      artifact.pathResult = '/recordings/video.webm';
      final result = await video.path();
      expect(result, equals('/recordings/video.webm'));
      expect(artifact.pathAfterFinishedCalled, isTrue);
    });

    test('path returns empty string when artifact returns null', () async {
      artifact.pathResult = null;
      final result = await video.path();
      expect(result, equals(''));
    });

    test('saveAs delegates to artifact.saveAs with correct path', () async {
      await video.saveAs('/output/video.webm');
      expect(artifact.saveAsPath, equals('/output/video.webm'));
    });

    test('delete delegates to artifact.delete', () async {
      await video.delete();
      expect(artifact.deleteCalled, isTrue);
    });
  });
}

// ── Minimal mocks ─────────────────────────────────────────────────────────────

class _MockArtifact implements Artifact {
  String? pathResult;
  String? saveAsPath;
  bool deleteCalled = false;
  bool pathAfterFinishedCalled = false;

  @override
  Future<String?> pathAfterFinished() async {
    pathAfterFinishedCalled = true;
    return pathResult;
  }

  @override
  Future<void> saveAs(String path) async => saveAsPath = path;

  @override
  Future<void> delete() async => deleteCalled = true;

  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

class _MockPage implements Page {
  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}
