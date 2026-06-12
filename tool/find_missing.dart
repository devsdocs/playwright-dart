import 'dart:io';

void main() {
  final channelsContent = File(
    'lib/src/generated/channels.dart',
  ).readAsStringSync();
  final pageContent = File('lib/src/page.dart').readAsStringSync();
  final frameContent = File('lib/src/frame.dart').readAsStringSync();
  final browserContent = File('lib/src/browser.dart').readAsStringSync();
  final contextContent = File(
    'lib/src/browser_context.dart',
  ).readAsStringSync();
  final locatorContent = File('lib/src/locator.dart').readAsStringSync();

  final keyboardContent = File('lib/src/keyboard.dart').existsSync()
      ? File('lib/src/keyboard.dart').readAsStringSync()
      : '';
  final mouseContent = File('lib/src/mouse.dart').existsSync()
      ? File('lib/src/mouse.dart').readAsStringSync()
      : '';

  final Map<String, String> wrapperContents = {
    'PageBase': pageContent,
    'FrameBase': frameContent,
    'BrowserBase': browserContent,
    'BrowserContextBase': contextContent,
  };

  final Map<String, List<String>> missingMethods = {};

  final lines = channelsContent.split('\n');
  String? currentClass;

  for (final line in lines) {
    if (line.startsWith('abstract class ') && line.contains('Base extends')) {
      final match = RegExp(r'abstract class (\w+Base)').firstMatch(line);
      if (match != null) {
        currentClass = match.group(1);
      }
    }

    if (currentClass != null) {
      if (line.contains(' channel_')) {
        final match = RegExp(r' channel_([a-zA-Z0-9_]+)\(').firstMatch(line);
        if (match != null) {
          final methodName = match.group(1)!;

          if (currentClass == 'FrameBase') {
            final hasInFrame =
                frameContent.contains(' $methodName(') ||
                frameContent.contains(' $methodName<');
            final hasInLocator =
                locatorContent.contains(' $methodName(') ||
                locatorContent.contains(' $methodName<');

            // Skip methods that don't make sense on Locator
            final skipLocator = [
              'addScriptTag',
              'addStyleTag',
              'waitForTimeout',
              'waitForFunction',
              'expect',
              'title',
              'frameElement',
              'content',
              'setContent',
              'goto',
              'evaluateExpression',
              'evaluateExpressionHandle',
              'evalOnSelector',
              'evalOnSelectorAll',
              'dragAndDrop',
              'waitForSelector',
            ].contains(methodName);

            if (!hasInFrame) {
              missingMethods.putIfAbsent('Frame', () => []).add(methodName);
            }
            if (!hasInLocator && !skipLocator) {
              missingMethods.putIfAbsent('Locator', () => []).add(methodName);
            }
          } else if (wrapperContents.containsKey(currentClass)) {
            final cleanClassName = currentClass.replaceAll('Base', '');
            final wrapperContent = wrapperContents[currentClass]!;
            bool hasMethod =
                wrapperContent.contains(' $methodName(') ||
                wrapperContent.contains(' $methodName<');

            if (cleanClassName == 'Page') {
              if (methodName.startsWith('keyboard')) {
                final shortName =
                    methodName.substring(8, 9).toLowerCase() +
                    methodName.substring(9);
                hasMethod = keyboardContent.contains(' $shortName(');
              } else if (methodName.startsWith('mouse')) {
                final shortName =
                    methodName.substring(5, 6).toLowerCase() +
                    methodName.substring(6);
                hasMethod = mouseContent.contains(' $shortName(');
              }
            }

            if (!hasMethod) {
              missingMethods
                  .putIfAbsent(cleanClassName, () => [])
                  .add(methodName);
            }
          }
        }
      }
    }
  }

  print('=== Missing API Wrappers ===\n');
  for (final entry in missingMethods.entries) {
    print('${entry.key}:');
    print('  ${entry.value.join(', ')}');
    print('');
  }
}
