/// A matcher for a route URL or a network event predicate.
abstract class RouteMatcher {
  const RouteMatcher();

  /// Matches any URL that contains the given [string] or matches the glob pattern.
  factory RouteMatcher.string(String string) = StringRouteMatcher;

  /// Matches any URL that matches the given [regex].
  factory RouteMatcher.regex(RegExp regex) = RegExpRouteMatcher;

  /// Matches any network event (e.g. Request, Response, Uri) that satisfies the [predicate].
  factory RouteMatcher.function(bool Function(dynamic) predicate) =
      FunctionRouteMatcher;

  /// Creates a RouteMatcher from a dynamic value (String, RegExp, or Function).
  /// This is useful for migrating from legacy `RouteMatcher urlOrPredicate`.
  factory RouteMatcher.from(Object value) {
    if (value is RouteMatcher) return value;
    if (value is String) return RouteMatcher.string(value);
    if (value is RegExp) return RouteMatcher.regex(value);
    if (value is Function) {
      return RouteMatcher.function(value as bool Function(dynamic));
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

class FunctionRouteMatcher extends RouteMatcher {
  final bool Function(dynamic) predicate;
  const FunctionRouteMatcher(this.predicate);
}
