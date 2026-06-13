import 'page.dart';
import 'generated/channels.dart' as channels;

/// `ConsoleMessage` objects are dispatched by page via the `page.onConsole` event.
class ConsoleMessage {
  final Page page;
  final channels.ConsoleMessage _message;

  ConsoleMessage(this.page, this._message);

  /// The text of the console message.
  String get text => _message.text;

  /// The type of the console message.
  String get type => _message.type;

  /// List of arguments passed to the console function call.
  List<dynamic> get args => _message.args;

  /// Location of the console message.
  Map<String, dynamic> get location => _message.location;

  /// The timestamp when the message was generated.
  double get timestamp => _message.timestamp;
}
