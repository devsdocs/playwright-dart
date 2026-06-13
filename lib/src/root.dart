import 'generated/channels.dart';

class Root extends RootBase {
  Root(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<RootInitializeResult> initialize({
    required SDKLanguage sdkLanguage,
  }) async {
    return await channel_initialize(sdkLanguage: sdkLanguage);
  }
}
