import 'artifact.dart';
import '../core/page.dart';

/// Represents a download triggered by the page.
class Download {
  final Page page;
  final String url;
  final String suggestedFilename;
  final Artifact _artifact;

  Download(this.page, this.url, this.suggestedFilename, this._artifact);

  /// Cancels a download. Will not fail if the download is already finished or canceled. Upon successful cancellations, `download.failure()` would resolve to `'canceled'`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await download.cancel();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> cancel() => _artifact.cancel();

  /// Deletes the downloaded file. Will wait for the download to finish if necessary.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await download.delete();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> delete() => _artifact.delete();

  /// Returns download error if any. Will wait for the download to finish if necessary.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await download.failure();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String> failure() => _artifact.failure();

  /// Returns path to the downloaded file for a successful download, or throws for a failed/canceled download. The method will wait for the download to finish if necessary. The method throws when connected remotely.
  ///
  /// Note that the download's file name is a random GUID, use [download.suggestedFilename()] to get suggested file name.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await download.path();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String?> path() => _artifact.pathAfterFinished();

  /// Copy the download to a user-specified path. It is safe to call this method while the download is still in progress. Will wait for the download to finish if necessary.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await download.saveAs('/path/to/save/at/' + download.suggestedFilename());
  /// ```
  ///
  /// **Arguments**
  /// - `path` String
  ///
  ///   Path where the download should be copied.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> saveAs(String path) => _artifact.saveAs(path);
}
