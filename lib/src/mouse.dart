import 'generated/channels.dart';
import 'page.dart';

class Mouse {
  final Page page;

  Mouse(this.page);

  Future<void> move(double x, double y, {int? steps}) async {
    await (page as PageImpl).channel_mouseMove(x: x, y: y, steps: steps);
  }

  Future<void> down({PageMouseDownButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseDown(
      button: button,
      clickCount: clickCount,
    );
  }

  Future<void> up({PageMouseUpButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseUp(
      button: button,
      clickCount: clickCount,
    );
  }

  Future<void> click(
    double x,
    double y, {
    double? delay,
    PageMouseClickButtonEnum? button,
    int? clickCount,
  }) async {
    await (page as PageImpl).channel_mouseClick(
      x: x,
      y: y,
      delay: delay,
      button: button,
      clickCount: clickCount,
    );
  }

  Future<void> dblclick(
    double x,
    double y, {
    double? delay,
    PageMouseClickButtonEnum? button,
  }) async {
    await click(x, y, delay: delay, button: button, clickCount: 2);
  }

  Future<void> wheel(double deltaX, double deltaY) async {
    await (page as PageImpl).channel_mouseWheel(deltaX: deltaX, deltaY: deltaY);
  }
}
