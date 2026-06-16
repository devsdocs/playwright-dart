import 'playwright.dart';
import 'browser_context.dart';
import '../generated/channels.dart';
import '../utils/locator_utils.dart';

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
        in (_playwright as PlaywrightImpl).connection.objects.values
            .whereType<BrowserContext>()) {
      await (context as BrowserContextImpl).channel_registerSelectorEngine(
        selectorEngine: engine,
      );
    }
  }

  /// Sets the test-id attribute name globally.
  ///
  /// This persists the name so that any future [BrowserContext] created via
  /// [Browser.newContext] automatically inherits it through [addContext].
  /// Existing contexts are updated immediately.
  Future<void> setTestIdAttribute(String name) async {
    _testIdAttributeName = name;
    setTestIdAttributeName(name);
    for (final context
        in (_playwright as PlaywrightImpl).connection.objects.values
            .whereType<BrowserContext>()) {
      await (context as BrowserContextImpl).channel_setTestIdAttributeName(
        testIdAttributeName: name,
      );
    }
  }

  /// Internal method called by [Browser.newContext] when a new [BrowserContext]
  /// is created.
  ///
  /// Applies any pending testId attribute name and registered selector engines
  /// to the freshly-created context **before** it is returned to the caller,
  /// so that every operation on the new context already uses the correct
  /// configuration.
  Future<void> addContext(BrowserContext context) async {
    if (_testIdAttributeName != 'data-testid') {
      // Must be awaited so the attribute is in effect before the context is used.
      await (context as BrowserContextImpl).channel_setTestIdAttributeName(
        testIdAttributeName: _testIdAttributeName,
      );
    }
    for (final engine in _registrations) {
      await (context as BrowserContextImpl).channel_registerSelectorEngine(
        selectorEngine: engine,
      );
    }
  }
}
