/// A matcher for a route URL or a network event predicate.
abstract class RouteMatcher {
  const RouteMatcher();

  /// Matches any URL that contains the given [string] or matches the glob pattern.
  factory RouteMatcher.string(String string) = StringRouteMatcher;

  /// Matches any URL that matches the given [regex].
  factory RouteMatcher.regex(RegExp regex) = RegExpRouteMatcher;

  /// Matches any network event (e.g. Request, Response, Uri) that satisfies the [predicate].
  ///
  /// You can use the generic type parameter `<T>` to get type safety and
  /// auto-filtering based on the network event type.
  ///
  /// ```dart
  /// final request = await page.waitForRequest(
  ///   RouteMatcher.function<Request>((req) => req.url.contains('/api') && req.method == 'POST')
  /// );
  /// ```
  static RouteMatcher function<T>(bool Function(T) predicate) =>
      FunctionRouteMatcher<T>(predicate);

  /// Creates a RouteMatcher from a dynamic value (String, RegExp, or Function).
  /// This is useful for migrating from legacy `RouteMatcher urlOrPredicate`.
  factory RouteMatcher.from(Object value) {
    if (value is RouteMatcher) return value;
    if (value is String) return RouteMatcher.string(value);
    if (value is RegExp) return RouteMatcher.regex(value);
    if (value is Function) {
      return RouteMatcher.function<dynamic>(value as bool Function(dynamic));
    }
    throw ArgumentError('Unsupported RouteMatcher value: $value');
  }
}

class StringRouteMatcher extends RouteMatcher {
  final String glob;
  const StringRouteMatcher(this.glob);
}

class RegExpRouteMatcher extends RouteMatcher {
  final RegExp regex;
  const RegExpRouteMatcher(this.regex);
}

class FunctionRouteMatcher<T> extends RouteMatcher {
  final bool Function(T) predicate;
  const FunctionRouteMatcher(this.predicate);

  bool callPredicate(dynamic event) {
    if (event is! T) return false;
    return predicate(event);
  }
}
