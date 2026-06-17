/// Enum for typesafe keyboard key names
enum KeyboardKey {
  // Modifier keys
  shift('Shift'),
  control('Control'),
  alt('Alt'),
  meta('Meta'),

  // Navigation keys
  arrowUp('ArrowUp'),
  arrowDown('ArrowDown'),
  arrowLeft('ArrowLeft'),
  arrowRight('ArrowRight'),
  home('Home'),
  end('End'),
  pageUp('PageUp'),
  pageDown('PageDown'),

  // Editing keys
  backspace('Backspace'),
  delete('Delete'),
  enter('Enter'),
  tab('Tab'),
  escape('Escape'),

  // Function keys
  f1('F1'),
  f2('F2'),
  f3('F3'),
  f4('F4'),
  f5('F5'),
  f6('F6'),
  f7('F7'),
  f8('F8'),
  f9('F9'),
  f10('F10'),
  f11('F11'),
  f12('F12'),

  // Letter keys
  keyA('KeyA'),
  keyB('KeyB'),
  keyC('KeyC'),
  keyD('KeyD'),
  keyE('KeyE'),
  keyF('KeyF'),
  keyG('KeyG'),
  keyH('KeyH'),
  keyI('KeyI'),
  keyJ('KeyJ'),
  keyK('KeyK'),
  keyL('KeyL'),
  keyM('KeyM'),
  keyN('KeyN'),
  keyO('KeyO'),
  keyP('KeyP'),
  keyQ('KeyQ'),
  keyR('KeyR'),
  keyS('KeyS'),
  keyT('KeyT'),
  keyU('KeyU'),
  keyV('KeyV'),
  keyW('KeyW'),
  keyX('KeyX'),
  keyY('KeyY'),
  keyZ('KeyZ'),

  // Number keys
  digit0('Digit0'),
  digit1('Digit1'),
  digit2('Digit2'),
  digit3('Digit3'),
  digit4('Digit4'),
  digit5('Digit5'),
  digit6('Digit6'),
  digit7('Digit7'),
  digit8('Digit8'),
  digit9('Digit9'),

  // Space
  space('Space');

  final String value;
  const KeyboardKey(this.value);
}
