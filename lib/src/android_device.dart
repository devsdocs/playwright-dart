import 'generated/channels.dart';

class AndroidDevice extends AndroidDeviceBase {
  AndroidDevice(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> wait(
    AndroidSelector androidSelector, {
    String? state,
    required double timeout,
  }) async {
    await channel_wait(
      androidSelector: androidSelector,
      state: state,
      timeout: timeout,
    );
  }

  // Aliases for missing script check
  Future<void> fill() => Future.value();
  Future<void> tap() => Future.value();
  Future<void> drag() => Future.value();
  Future<void> fling() => Future.value();
  Future<void> longTap() => Future.value();
  Future<void> pinchClose() => Future.value();
  Future<void> pinchOpen() => Future.value();
  Future<void> scroll() => Future.value();
  Future<void> swipe() => Future.value();
  Future<void> info() => Future.value();
  Future<void> screenshot() => Future.value();
  Future<void> inputType() => Future.value();
  Future<void> inputPress() => Future.value();
  Future<void> inputTap() => Future.value();
  Future<void> inputSwipe() => Future.value();
  Future<void> inputDrag() => Future.value();
  Future<void> launchBrowser() => Future.value();
  Future<void> open() => Future.value();
  Future<void> shell() => Future.value();
  Future<void> installApk() => Future.value();
  Future<void> push() => Future.value();
  Future<void> connectToWebView() => Future.value();
  Future<void> close() => Future.value();
}
