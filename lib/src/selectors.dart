import 'playwright.dart';
import 'browser_context.dart';
import 'generated/channels.dart';

/// Selectors can be used to install custom selector engines.
class Selectors {
  final Playwright _playwright;
  final List<SelectorEngine> _registrations = [];
  String _testIdAttributeName = 'data-testid';

  Selectors(this._playwright);

  /// Registers a custom selector engine.
  Future<void> register(
    String name,
    String script, {
    bool contentScript = false,
  }) async {
    final engine = SelectorEngine(
      name: name,
      source: script,
      contentScript: contentScript,
    );
    _registrations.add(engine);
    for (final context
        in _playwright.connection.objects.values.whereType<BrowserContext>()) {
      await context.channel_registerSelectorEngine(selectorEngine: engine);
    }
  }

  /// Sets the test-id attribute name.
  void setTestIdAttribute(String name) {
    _testIdAttributeName = name;
    for (final context
        in _playwright.connection.objects.values.whereType<BrowserContext>()) {
      context.channel_setTestIdAttributeName(testIdAttributeName: name);
    }
  }

  /// Internal method called when a new BrowserContext is created.
  Future<void> addContext(BrowserContext context) async {
    if (_testIdAttributeName != 'data-testid') {
      context.channel_setTestIdAttributeName(
        testIdAttributeName: _testIdAttributeName,
      );
    }
    for (final engine in _registrations) {
      await context.channel_registerSelectorEngine(selectorEngine: engine);
    }
  }
}
