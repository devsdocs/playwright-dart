import 'src/driver.dart';
import 'src/transport.dart';
import 'src/connection.dart';
import 'src/playwright.dart';
import 'src/channel_owner.dart';

export 'src/playwright.dart';
export 'src/browser_type.dart';
export 'src/browser.dart';
export 'src/browser_context.dart';
export 'src/page.dart';
export 'src/frame.dart';
export 'src/locator.dart';
export 'src/generated/channels.dart';

class PlaywrightDart {
  static Future<Playwright> create() async {
    final process = await Driver.run();
    final transport = StdioTransport(process);
    final connection = Connection(transport);

    // Initialize the root object to get Playwright
    final result = await connection.sendMessageToServer('', 'initialize', {
      'sdkLanguage':
          'javascript', // Server currently expects javascript, python, java, or csharp
    });

    return ChannelOwner.from<Playwright>(
      connection,
      result['playwright'] as Map<String, dynamic>,
    );
  }
}
