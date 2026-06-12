import 'generated/channels.dart';

class Dialog extends DialogBase {
  Dialog(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  String get type => initializer['type'] as String;
  String get message => initializer['message'] as String;
  String get defaultValue => initializer['defaultValue'] as String? ?? '';

  Future<void> accept({String? promptText}) async {
    await channel_accept(promptText: promptText);
  }

  Future<void> dismiss() async {
    await channel_dismiss();
  }
}
