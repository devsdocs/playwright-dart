import '../generated/channels.dart';
import '../infrastructure/serialization.dart';

/// Interface for BindingCall
abstract interface class BindingCall {
  Future<void> resolve(dynamic result);
  Future<void> reject(dynamic error);
}

class BindingCallImpl extends BindingCallBase implements BindingCall {
  BindingCallImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> resolve(dynamic result) async {
    await channel_resolve(result: serializeArgument(result));
  }

  @override
  Future<void> reject(dynamic error) async {
    // Basic error serialization mapping for now
    await channel_reject(
      error: SerializedError(
        error: SerializedErrorError.fromJson({
          'message': error.toString(),
          'name': 'Error',
          'stack': '',
        }),
      ),
    );
  }
}
