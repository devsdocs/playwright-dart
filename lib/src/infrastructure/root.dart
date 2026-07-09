import '../generated/channels.dart';

/// Interface for Root
abstract interface class Root {
  Future<RootInitializeResult> initialize({required SDKLanguage sdkLanguage});
}

class RootImpl extends RootBase implements Root {
  RootImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<RootInitializeResult> initialize({
    required SDKLanguage sdkLanguage,
  }) async {
    return await channel.initialize(sdkLanguage: sdkLanguage);
  }
}
