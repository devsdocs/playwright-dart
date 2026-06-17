import '../generated/channels.dart';
import '../core/page.dart';

class Mouse {
  final Page page;

  Mouse(this.page);

  /// Moves the mouse cursor to the specified coordinates.
  ///
  /// The [x] and [y] parameters are absolute coordinates relative to the viewport.
  /// Use [steps] to simulate a smoother mouse movement (higher values = more steps).
  ///
  /// Example:
  /// ```dart
  /// await mouse.move(100, 100);
  /// await mouse.move(200, 200, steps: 10);
  /// ```
  Future<void> move(double x, double y, {int? steps}) async {
    await (page as PageImpl).channel_mouseMove(x: x, y: y, steps: steps);
  }

  /// Presses a mouse button down and holds it.
  ///
  /// Use this for drag-and-drop operations or when you need to hold a button.
  /// Remember to call [up] to release the button.
  ///
  /// Example:
  /// ```dart
  /// await mouse.move(100, 100);
  /// await mouse.down(button: PageMouseDownButtonEnum.left);
  /// await mouse.move(200, 200);
  /// await mouse.up(button: PageMouseUpButtonEnum.left);
  /// ```
  Future<void> down({PageMouseDownButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseDown(
      button: button,
      clickCount: clickCount,
    );
  }

  /// Releases a mouse button that was previously pressed down.
  ///
  /// Use this after calling [down] to release a held button.
  ///
  /// Example:
  /// ```dart
  /// await mouse.down(button: PageMouseDownButtonEnum.left);
  /// await mouse.up(button: PageMouseUpButtonEnum.left);
  /// ```
  Future<void> up({PageMouseUpButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseUp(
      button: button,
      clickCount: clickCount,
    );
  }

  /// Clicks at the specified coordinates.
  ///
  /// This is the most common way to click. It performs a complete click cycle
  /// (down then up). Use [button] to specify which mouse button to click.
  /// Use [delay] to add a delay between down and up (in milliseconds).
  /// Use [clickCount] for double/triple clicks.
  ///
  /// Example:
  /// ```dart
  /// await mouse.click(100, 100);
  /// await mouse.click(50, 50, button: PageMouseClickButtonEnum.right);
  /// await mouse.click(100, 100, delay: 100);
  /// ```
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

  /// Double-clicks at the specified coordinates.
  ///
  /// This is a convenience method that performs two clicks in quick succession.
  ///
  /// Example:
  /// ```dart
  /// await mouse.dblclick(100, 100);
  /// await mouse.dblclick(50, 50, button: PageMouseClickButtonEnum.right);
  /// ```
  Future<void> dblclick(
    double x,
    double y, {
    double? delay,
    PageMouseClickButtonEnum? button,
  }) async {
    await click(x, y, delay: delay, button: button, clickCount: 2);
  }

  /// Scrolls the mouse wheel.
  ///
  /// Use [deltaX] for horizontal scrolling and [deltaY] for vertical scrolling.
  /// Positive values scroll down/right, negative values scroll up/left.
  ///
  /// Example:
  /// ```dart
  /// await mouse.wheel(0, 100); // Scroll down
  /// await mouse.wheel(0, -100); // Scroll up
  /// await mouse.wheel(100, 0); // Scroll right
  /// ```
  Future<void> wheel(double deltaX, double deltaY) async {
    await (page as PageImpl).channel_mouseWheel(deltaX: deltaX, deltaY: deltaY);
  }

  // Shorthand convenience methods for common mouse operations

  /// Left-clicks at the specified coordinates.
  Future<void> leftClick(
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.left,
      clickCount: clickCount,
    );
  }

  /// Right-clicks at the specified coordinates.
  Future<void> rightClick(
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.right,
      clickCount: clickCount,
    );
  }

  /// Middle-clicks at the specified coordinates.
  Future<void> middleClick(
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.middle,
      clickCount: clickCount,
    );
  }

  /// Double left-clicks at the specified coordinates.
  Future<void> leftDblclick(double x, double y, {double? delay}) async {
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.left);
  }

  /// Double right-clicks at the specified coordinates.
  Future<void> rightDblclick(double x, double y, {double? delay}) async {
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.right);
  }

  /// Double middle-clicks at the specified coordinates.
  Future<void> middleDblclick(double x, double y, {double? delay}) async {
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.middle);
  }

  /// Scrolls up by the specified amount.
  Future<void> scrollUp(double amount) async => wheel(0, -amount);

  /// Scrolls down by the specified amount.
  Future<void> scrollDown(double amount) async => wheel(0, amount);

  /// Scrolls left by the specified amount.
  Future<void> scrollLeft(double amount) async => wheel(-amount, 0);

  /// Scrolls right by the specified amount.
  Future<void> scrollRight(double amount) async => wheel(amount, 0);
}
