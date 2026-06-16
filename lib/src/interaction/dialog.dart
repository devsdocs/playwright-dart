import '../core/page.dart';

import '../generated/channels.dart';

/// Interface for Dialog

abstract interface class Dialog {
  Page get page;

  String get type;

  String get message;

  String get defaultValue;

  Future<void> accept({String? promptText});

  Future<void> dismiss();
}

class DialogImpl extends DialogBase implements Dialog {
  @override
  Page get page => typedInitializer.page as Page;

  DialogImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  @override
  String get type => typedInitializer.type;

  @override
  String get message => typedInitializer.message;

  @override
  String get defaultValue => typedInitializer.defaultValue;

  @override
  Future<void> accept({String? promptText}) async {
    await channel_accept(promptText: promptText);
  }

  @override
  Future<void> dismiss() async {
    await channel_dismiss();
  }
}
