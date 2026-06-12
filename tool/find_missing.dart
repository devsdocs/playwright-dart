import 'dart:io';

void main() {
  final channelsContent = File('lib/src/generated/channels.dart').readAsStringSync();
  final srcDir = Directory('lib/src');
  final srcFiles = srcDir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'));

  final Map<String, String> wrapperContents = {};
  for (final file in srcFiles) {
    // We assume the class name matches the file name in a basic way, or we just load all contents.
    // Actually, let's just keep the content of the file to search through.
    wrapperContents[file.path.split(Platform.pathSeparator).last] = file.readAsStringSync();
  }

  // Define which class names map to which files for searching
  final fileMap = {
    'Page': 'page.dart',
    'Frame': 'frame.dart',
    'Browser': 'browser.dart',
    'BrowserContext': 'browser_context.dart',
    'BrowserType': 'browser_type.dart',
    'Playwright': 'playwright.dart',
    'JSHandle': 'jshandle.dart',
    'ElementHandle': 'element_handle.dart',
    'LocalUtils': 'local_utils.dart',
    'Request': 'request.dart',
    'Response': 'response.dart',
    'Route': 'route.dart',
    'WebSocket': 'websocket.dart',
    'Worker': 'worker.dart',
    'Dialog': 'dialog.dart',
    'Tracing': 'tracing.dart',
    'CDPSession': 'cdp_session.dart',
    'Artifact': 'artifact.dart',
    'BindingCall': 'binding_call.dart',
    'APIRequestContext': 'api_request_context.dart',
    'Stream': 'stream.dart',
    'WritableStream': 'writable_stream.dart',
    'Disposable': 'disposable.dart',
    'EventTarget': 'event_target.dart',
    'WebSocketRoute': 'websocket_route.dart',
    'DebugController': 'debug_controller.dart',
    'Debugger': 'debugger.dart',
    'Android': 'android.dart',
    'AndroidSocket': 'android_socket.dart',
    'AndroidDevice': 'android_device.dart',
    'Electron': 'electron.dart',
    'ElectronApplication': 'electron_application.dart',
    'Root': 'root.dart',
    'SocksSupport': 'socks_support.dart',
    'JsonPipe': 'json_pipe.dart',
  };

  final Map<String, List<String>> missingMethods = {};
  final List<String> missingClasses = [];

  final lines = channelsContent.split('\n');
  String? currentClass;
  int methodsChecked = 0;

  for (final line in lines) {
    if (line.startsWith('abstract class ') && line.contains('Base extends')) {
      final match = RegExp(r'abstract class (\w+)Base').firstMatch(line);
      if (match != null) {
        currentClass = match.group(1);
        
        // Skip internal or unsupported classes for now
        final skipClasses = <String>[];
        if (skipClasses.contains(currentClass)) {
          currentClass = null;
          continue;
        }

        final fileName = fileMap[currentClass];
        if (fileName == null || !wrapperContents.containsKey(fileName)) {
          if (!missingClasses.contains(currentClass)) {
            missingClasses.add(currentClass!);
          }
          currentClass = null; // Skip scanning methods since class is missing
        }
      }
    }

    if (currentClass != null) {
      if (line.contains(' channel_')) {
        final match = RegExp(r' channel_([a-zA-Z0-9_]+)\(').firstMatch(line);
        if (match != null) {
          final methodName = match.group(1)!;
          
          final wrapperContent = wrapperContents[fileMap[currentClass]]!;
          bool hasMethod = wrapperContent.contains(' $methodName(') || wrapperContent.contains(' $methodName<');
          
          if (currentClass == 'Page') {
              if (methodName.startsWith('keyboard')) {
                final shortName = methodName.substring(8, 9).toLowerCase() + methodName.substring(9);
                hasMethod = wrapperContents['keyboard.dart']?.contains(' $shortName(') ?? false;
              } else if (methodName.startsWith('mouse')) {
                final shortName = methodName.substring(5, 6).toLowerCase() + methodName.substring(6);
                hasMethod = wrapperContents['mouse.dart']?.contains(' $shortName(') ?? false;
              }
          }

          if (!hasMethod) {
            missingMethods.putIfAbsent(currentClass, () => []).add(methodName);
          } else {
            methodsChecked++;
            // Also check if it actually calls the channel_ function
            bool callsChannel = wrapperContent.contains('channel_$methodName');
            if (currentClass == 'Page' && (methodName.startsWith('keyboard') || methodName.startsWith('mouse'))) {
              if (methodName.startsWith('keyboard')) {
                callsChannel = wrapperContents['keyboard.dart']?.contains('channel_$methodName') ?? false;
              } else {
                callsChannel = wrapperContents['mouse.dart']?.contains('channel_$methodName') ?? false;
              }
            }
            if (!callsChannel) {
              missingMethods.putIfAbsent(currentClass, () => []).add('$methodName (missing channel call)');
            }
          }
        }
      }
    }
  }

  print('=== Missing Wrapper Classes ===\n');
  if (missingClasses.isEmpty) {
    print('None!\n');
  } else {
    for (var c in missingClasses) {
      print('- $c');
    }
    print('');
  }

  print('=== Missing API Wrappers in Existing Classes ===\n');
  if (missingMethods.isEmpty) {
    print('None! (Checked $methodsChecked methods)\n');
  } else {
    for (final entry in missingMethods.entries) {
      print('${entry.key}:');
      print('  ${entry.value.join(', ')}');
      print('');
    }
  }
}
