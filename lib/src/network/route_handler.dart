import 'dart:async';

import '../generated/channels.dart';
import 'route.dart';

typedef RouteHandlerCallback = Future<void> Function(Route route);

class RouteHandlerEntry {
  final String url;
  final RouteHandlerCallback handler;

  RouteHandlerEntry(this.url, this.handler);
}

/// Tracks route handlers and dispatches incoming routes to matching handlers.
class RouteManager {
  final List<RouteHandlerEntry> _routes = [];

  List<RouteHandlerEntry> get routes => List.unmodifiable(_routes);

  bool get isEmpty => _routes.isEmpty;

  void add(String url, RouteHandlerCallback handler) {
    _routes.insert(0, RouteHandlerEntry(url, handler));
  }

  void remove(String url, [RouteHandlerCallback? handler]) {
    _routes.removeWhere(
      (r) => r.url == url && (handler == null || identical(r.handler, handler)),
    );
  }

  void clear() => _routes.clear();

  List<BrowserContextSetNetworkInterceptionPatternsPatternsItems>
  prepareContextPatterns() {
    return _preparePatterns(
      BrowserContextSetNetworkInterceptionPatternsPatternsItems.fromJson,
    );
  }

  List<PageSetNetworkInterceptionPatternsPatternsItems> preparePagePatterns() {
    return _preparePatterns(
      PageSetNetworkInterceptionPatternsPatternsItems.fromJson,
    );
  }

  List<T> _preparePatterns<T>(T Function(Map<String, dynamic>) fromJson) {
    if (_routes.isEmpty) return [];
    for (final route in _routes) {
      if (route.url == '**/*' || route.url == '*') {
        return [
          fromJson({'glob': '**/*'}),
        ];
      }
    }
    return _routes.map((r) => fromJson({'glob': r.url})).toList();
  }

  Future<void> handleRoute(Route route, String requestUrl) async {
    for (final entry in _routes) {
      if (_matches(entry.url, requestUrl)) {
        await entry.handler(route);
        return;
      }
    }
    try {
      await route.continueRoute();
    } catch (_) {}
  }

  bool _matches(String pattern, String url) {
    if (pattern == '**/*' || pattern == '*') return true;
    if (pattern.contains('*')) {
      // Escape regex special chars first, then expand glob wildcards.
      // Use a placeholder for ** to avoid the single-* replacement clobbering it.
      final regexPattern = pattern
          .replaceAllMapped(RegExp(r'[.+?^${}()|[\]\\]'), (m) => '\\${m[0]}')
          .replaceAll('**', '\x00') // placeholder
          .replaceAll('*', '[^/]*')
          .replaceAll('\x00', '.*'); // expand ** → .*
      return RegExp('^$regexPattern\$').hasMatch(url);
    }
    return url == pattern || url.contains(pattern);
  }
}

/// Attaches a single route-event listener and forwards events to [manager].
class RouteListener {
  final RouteManager manager;
  StreamSubscription<Route>? _subscription;

  RouteListener(this.manager);

  void attach(Stream<Route> routeStream) {
    _subscription ??= routeStream.listen((route) async {
      await manager.handleRoute(route, route.request.url);
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}
