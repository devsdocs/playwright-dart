void main() {
  String s = '''
page.on('requestfailed', request => {
  console.log(request.url() + ' ' + request.failure().errorText);
});
final popupFuture = page.waitForEvent('popup');
final popupFuture = context.waitForEvent('page');
page.waitForEvent('requestfinished');
  ''';

  const eventMap = {
    'requestfailed': 'onRequestFailed',
    'requestfinished': 'onRequestFinished',
    'filechooser': 'onFileChooser',
    'framenavigated': 'onFrameNavigated',
    'framedetached': 'onFrameDetached',
    'frameattached': 'onFrameAttached',
    'pageerror': 'onPageError',
    'websocket': 'onWebSocket',
    'worker': 'onWorker',
    'page': 'onPage',
  };

  s = s.replaceAllMapped(RegExp(r'\.on\(([\047"])([a-zA-Z]+)\1,\s*'), (m) {
    final eventName = m.group(2)!.toLowerCase();
    final mapped =
        eventMap[eventName] ??
        'on\${eventName[0].toUpperCase()}\${eventName.substring(1)}';
    return '.\$mapped.listen(';
  });

  s = s.replaceAllMapped(RegExp(r'\.waitForEvent\(([\047"])([a-zA-Z]+)\1\)'), (
    m,
  ) {
    final eventName = m.group(2)!.toLowerCase();
    final mapped =
        eventMap[eventName] ??
        'on\${eventName[0].toUpperCase()}\${eventName.substring(1)}';
    return '.\$mapped.first';
  });

  print(s);
}
