import 'generated/channels.dart';

/// Interface for Dialog
abstract interface class Dialog {
  String get type;
  String get message;
  String get defaultValue;
  Future<void> accept({String? promptText});
  Future<void> dismiss();
}

class DialogImpl extends DialogBase implements Dialog {
  DialogImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  String get type => initializer['type'] as String;
  @override
  String get message => initializer['message'] as String;
  @override
  String get defaultValue => initializer['defaultValue'] as String? ?? '';

  @override
  Future<void> accept({String? promptText}) async {
    await channel_accept(promptText: promptText);
  }

  @override
  Future<void> dismiss() async {
    await channel_dismiss();
  }
}
