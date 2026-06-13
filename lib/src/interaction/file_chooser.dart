import '../core/page.dart';
import 'element_handle.dart';

/// `FileChooser` objects are dispatched by the page in the `page.onFileChooser` event.
class FileChooser {
  final Page page;
  final ElementHandle element;
  final bool isMultiple;

  FileChooser(this.page, this.element, this.isMultiple);

  /// Sets the value of the file input this chooser is associated with. If some of the `filePaths` are relative paths,
  /// then they are resolved relative to the current working directory.
  Future<void> setFiles(List<String> files, {double? timeout}) async {
    await element.setInputFiles(files, timeout: timeout);
  }
}
