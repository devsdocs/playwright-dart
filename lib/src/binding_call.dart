import 'generated/channels.dart';
import 'serialization.dart';

class BindingCall extends BindingCallBase {
  BindingCall(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> resolve(dynamic result) async {
    await channel_resolve(result: serializeArgument(result));
  }

  Future<void> reject(dynamic error) async {
    // Basic error serialization mapping for now
    final serializedError = SerializedError(
      error: {'message': error.toString(), 'name': 'Error', 'stack': ''},
    );
    await channel_reject(error: serializedError);
  }
}
