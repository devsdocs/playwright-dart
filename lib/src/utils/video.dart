import '../core/page.dart';
import 'artifact.dart';

/// Video objects are returned by `page.video`.
class Video {
  final Page page;
  final Artifact _artifact;

  Video(this.page, this._artifact);

  /// Returns the file system path where the video will be recorded.
  Future<String> path() async {
    return await _artifact.pathAfterFinished() ?? '';
  }

  /// Saves the video to the specified file path.
  Future<void> saveAs(String path) async {
    await _artifact.saveAs(path);
  }

  /// Deletes the video file.
  Future<void> delete() async {
    await _artifact.delete();
  }
}
