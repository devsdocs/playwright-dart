import 'dart:io';

void main() {
  final channelsContent = File(
    'lib/src/generated/channels.dart',
  ).readAsStringSync();

  // Recursively collect all wrapper dart files under lib/src (excluding generated)
  final Map<String, String> wrapperContents = {};
  final srcDir = Directory('lib/src');
  for (final entity in srcDir.listSync(recursive: true).whereType<File>()) {
    if (entity.path.endsWith('.dart') && !entity.path.contains('generated')) {
      final filename = entity.path.split(Platform.pathSeparator).last;
      wrapperContents[filename] = entity.readAsStringSync();
    }
  }

  // Combined content for cross-file searches (keyboard, mouse, etc.)
  final allWrapperContent = wrapperContents.values.join('\n');

  // Map channel class name → wrapper filename
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

  // Classes deliberately skipped (internal / unimportant)
  const skipClasses = <String>{};

  // Channel methods deliberately implemented under a different public name.
  // Map: 'ClassName' -> {'channelMethodName'} to suppress from "missing" report.
  const knownRenames = <String, Set<String>>{
    'Page': {
      // close() calls channel_runBeforeUnload internally
      'runBeforeUnload',
      // webStorage* are exposed as storageItems / storageGetItem / etc.
      'webStorageClear',
      'webStorageGetItem',
      'webStorageItems',
      'webStorageRemoveItem',
      'webStorageSetItem',
    },
    'BrowserContext': {
      // credentials* are exposed as installVirtualAuthenticator /
      // addVirtualCredential / getVirtualCredentials / removeVirtualCredential
      'credentialsInstall',
      'credentialsCreate',
      'credentialsGet',
      'credentialsDelete',
    },
  };

  final Map<String, List<String>> missingMethods = {};
  final List<String> missingClasses = [];
  final List<String> missingFileMapEntries = [];

  final lines = channelsContent.split('\n');
  String? currentClass;
  int methodsChecked = 0;

  for (final line in lines) {
    if (line.startsWith('abstract class ') && line.contains('Base extends')) {
      final match = RegExp(r'abstract class (\w+)Base').firstMatch(line);
      if (match != null) {
        currentClass = match.group(1);

        if (skipClasses.contains(currentClass)) {
          currentClass = null;
          continue;
        }

        final fileName = fileMap[currentClass];
        if (fileName == null) {
          if (!missingFileMapEntries.contains(currentClass)) {
            missingFileMapEntries.add(currentClass!);
          }
          currentClass = null;
        } else if (!wrapperContents.containsKey(fileName)) {
          if (!missingClasses.contains(currentClass)) {
            missingClasses.add(currentClass!);
          }
          currentClass = null;
        }
      }
    }

    if (currentClass != null && line.trim().startsWith('Future<')) {
      final match = RegExp(
        r'^\s*Future<.*?> ([a-zA-Z0-9_]+)\(',
      ).firstMatch(line);
      if (match != null) {
        final methodName = match.group(1)!;
        final fileName = fileMap[currentClass]!;
        final wrapperContent = wrapperContents[fileName]!;

        // Keyboard/mouse/touchscreen methods live in separate files
        bool hasMethod;
        if (currentClass == 'Page' && methodName.startsWith('keyboard')) {
          final shortName =
              methodName.substring(8, 9).toLowerCase() +
              methodName.substring(9);
          hasMethod =
              wrapperContents['keyboard.dart']?.contains(' $shortName(') ??
              false;
        } else if (currentClass == 'Page' && methodName.startsWith('mouse')) {
          final shortName =
              methodName.substring(5, 6).toLowerCase() +
              methodName.substring(6);
          hasMethod =
              wrapperContents['mouse.dart']?.contains(' $shortName(') ?? false;
        } else if (currentClass == 'Page' &&
            methodName.startsWith('touchscreen')) {
          final shortName =
              methodName.substring(11, 12).toLowerCase() +
              methodName.substring(12);
          hasMethod =
              wrapperContents['touchscreen.dart']?.contains(' $shortName(') ??
              false;
        } else {
          hasMethod =
              wrapperContent.contains(' $methodName(') ||
              wrapperContent.contains(' $methodName<');
        }

        if (!hasMethod) {
          // Check if it's a known rename for this class
          if (knownRenames[currentClass]?.contains(methodName) == true) {
            methodsChecked++;
          } else {
            missingMethods.putIfAbsent(currentClass, () => []).add(methodName);
          }
        } else {
          methodsChecked++;
          // Also verify the channel_ function is actually called
          bool callsChannel;
          if (currentClass == 'Page' && methodName.startsWith('keyboard')) {
            callsChannel =
                wrapperContents['keyboard.dart']?.contains(
                  'channel.$methodName(',
                ) ??
                false;
          } else if (currentClass == 'Page' && methodName.startsWith('mouse')) {
            callsChannel =
                wrapperContents['mouse.dart']?.contains(
                  'channel.$methodName(',
                ) ??
                false;
          } else {
            callsChannel = allWrapperContent.contains('channel.$methodName(');
          }

          if (!callsChannel) {
            missingMethods
                .putIfAbsent(currentClass, () => [])
                .add('$methodName (declared but channel method not called)');
          }
        }
      }
    }
  }

  print('=== Missing fileMap Entries (need an entry in fileMap) ===\n');
  if (missingFileMapEntries.isEmpty) {
    print('None!\n');
  } else {
    for (var c in missingFileMapEntries) {
      print('- $c');
    }
    print('');
  }

  print('=== Missing Wrapper Class Files ===\n');
  if (missingClasses.isEmpty) {
    print('None!\n');
  } else {
    for (var c in missingClasses) {
      print('- $c (file: ${fileMap[c]})');
    }
    print('');
  }

  print('=== Missing API Wrappers in Existing Classes ===\n');
  if (missingMethods.isEmpty) {
    print('None! (Checked $methodsChecked methods)\n');
  } else {
    for (final entry in missingMethods.entries) {
      print('${entry.key}:');
      for (final m in entry.value) {
        print('  - $m');
      }
      print('');
    }
    print('(Checked $methodsChecked methods successfully)');
  }
}
