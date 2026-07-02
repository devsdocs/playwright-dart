import '../core/page.dart';
import '../generated/channels.dart' as channels;

/// `ConsoleMessage` objects are dispatched by page via the `page.onConsole` event.
class ConsoleMessage {
  final Page page;
  final channels.ConsoleMessage _message;

  ConsoleMessage(this.page, this._message);

  /// The text of the console message.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// consoleMessage.text;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get text => _message.text;

  /// **Usage**
  ///
  /// ```dart
  /// consoleMessage.type;
  /// ```
  ///
  /// **Returns**
  /// - "log" | "debug" | "info" | "error" | "warning" | "dir" | "dirxml" | "table" | "trace" | "clear" | "startGroup" | "startGroupCollapsed" | "endGroup" | "assert" | "profile" | "profileEnd" | "count" | "time" | "timeEnd"
  String get type => _message.type;

  /// List of arguments passed to a `console` function call. See also [page.on('console')].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// consoleMessage.args;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[JSHandle]&gt;
  List<dynamic> get args => _message.args;

  /// Location of the console message.
  channels.ConsoleMessageLocation get location => _message.location;

  /// The timestamp of the console message in milliseconds since the Unix epoch.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// consoleMessage.timestamp;
  /// ```
  ///
  /// **Returns**
  /// - num
  double get timestamp => _message.timestamp;
}
