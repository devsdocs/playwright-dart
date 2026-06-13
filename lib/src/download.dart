import 'artifact.dart';
import 'page.dart';

/// Represents a download triggered by the page.
class Download {
  final Page page;
  final String url;
  final String suggestedFilename;
  final Artifact _artifact;

  Download(this.page, this.url, this.suggestedFilename, this._artifact);

  Future<void> cancel() => _artifact.cancel();
  Future<void> delete() => _artifact.delete();
  Future<String> failure() => _artifact.failure();
  Future<String?> path() => _artifact.pathAfterFinished();
  Future<void> saveAs(String path) => _artifact.saveAs(path);
}
