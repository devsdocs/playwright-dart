import 'generated/channels.dart';

class ElectronApplication extends ElectronApplicationBase {
  ElectronApplication(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Map<String, dynamic>> browserWindow(PageBase page) async {
    return await channel_browserWindow(page: page);
  }

  // Aliases for missing script check
  Future<void> evaluateExpression() => Future.value();
  Future<void> evaluateExpressionHandle() => Future.value();
  Future<void> updateSubscription() => Future.value();
}
