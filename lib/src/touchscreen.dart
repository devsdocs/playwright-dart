import 'page.dart';

class Touchscreen {
  final Page page;

  Touchscreen(this.page);

  Future<void> tap(double x, double y) async {
    await (page as PageImpl).channel_touchscreenTap(x: x, y: y);
  }
}
