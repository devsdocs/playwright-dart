import 'page.dart';

class Mouse {
  final Page page;

  Mouse(this.page);

  Future<void> move(double x, double y, {int? steps}) async {
    await page.channel_mouseMove(x: x, y: y, steps: steps);
  }

  Future<void> down({String? button, int? clickCount}) async {
    await page.channel_mouseDown(button: button, clickCount: clickCount);
  }

  Future<void> up({String? button, int? clickCount}) async {
    await page.channel_mouseUp(button: button, clickCount: clickCount);
  }

  Future<void> click(
    double x,
    double y, {
    double? delay,
    String? button,
    int? clickCount,
  }) async {
    await page.channel_mouseClick(
      x: x,
      y: y,
      delay: delay,
      button: button,
      clickCount: clickCount,
    );
  }

  Future<void> wheel(double deltaX, double deltaY) async {
    await page.channel_mouseWheel(deltaX: deltaX, deltaY: deltaY);
  }
}
