import '../generated/channels.dart';

/// Web-first assertions for an [APIResponse].
///
/// Obtain via [APIResponseAssertions]:
/// ```dart
/// final response = await apiRequestContext.get('https://example.com/api');
/// final assertions = APIResponseAssertions(response);
/// await assertions.toBeOK();
/// ```
class APIResponseAssertions {
  final APIResponse _response;
  final bool _isNot;

  APIResponseAssertions(this._response, [this._isNot = false]);

  /// Returns the negated assertions object.
  APIResponseAssertions get not => APIResponseAssertions(_response, !_isNot);

  /// Checks that the response has a successful status code (2xx).
  Future<void> toBeOK() async {
    final ok = _response.status >= 200 && _response.status <= 299;
    if (_isNot) {
      if (ok) {
        throw AssertionError(
          'Expected response not to be OK, but status was ${_response.status}',
        );
      }
    } else {
      if (!ok) {
        throw AssertionError(
          'Expected response to be OK, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has the expected status code.
  Future<void> toHaveStatus(int expected) async {
    if (_isNot) {
      if (_response.status == expected) {
        throw AssertionError(
          'Expected response not to have status $expected, but it did',
        );
      }
    } else {
      if (_response.status != expected) {
        throw AssertionError(
          'Expected response to have status $expected, but was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has a status code in the expected range.
  Future<void> toHaveStatusInRange(int min, int max) async {
    final inRange = _response.status >= min && _response.status <= max;
    if (_isNot) {
      if (inRange) {
        throw AssertionError(
          'Expected response status not to be in range [$min, $max], but was ${_response.status}',
        );
      }
    } else {
      if (!inRange) {
        throw AssertionError(
          'Expected response status to be in range [$min, $max], but was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has the expected status text.
  Future<void> toHaveStatusText(String expected) async {
    if (_isNot) {
      if (_response.statusText == expected) {
        throw AssertionError(
          'Expected response not to have status text "$expected", but it did',
        );
      }
    } else {
      if (_response.statusText != expected) {
        throw AssertionError(
          'Expected response to have status text "$expected", but was "${_response.statusText}"',
        );
      }
    }
  }

  /// Checks that the response has the expected URL.
  Future<void> toHaveURL(Pattern expected) async {
    final matches = expected is RegExp
        ? expected.hasMatch(_response.url)
        : _response.url.contains(expected as String);
    if (_isNot) {
      if (matches) {
        throw AssertionError(
          'Expected response not to have URL matching "$expected", but was "${_response.url}"',
        );
      }
    } else {
      if (!matches) {
        throw AssertionError(
          'Expected response to have URL matching "$expected", but was "${_response.url}"',
        );
      }
    }
  }

  /// Checks that the response has the expected header.
  Future<void> toHaveHeader(String name, String? value) async {
    final headerName = name.toLowerCase();
    final headerValue = _response.headers
        .firstWhere(
          (h) => h.name.toLowerCase() == headerName,
          orElse: () => NameValue(name: '', value: ''),
        )
        .value;

    if (value == null) {
      // Just check existence
      final exists = headerValue.isNotEmpty;
      if (_isNot) {
        if (exists) {
          throw AssertionError(
            'Expected response not to have header "$name", but it did',
          );
        }
      } else {
        if (!exists) {
          throw AssertionError(
            'Expected response to have header "$name", but it did not',
          );
        }
      }
    } else {
      // Check value
      if (_isNot) {
        if (headerValue == value) {
          throw AssertionError(
            'Expected response header "$name" not to be "$value", but it was',
          );
        }
      } else {
        if (headerValue != value) {
          throw AssertionError(
            'Expected response header "$name" to be "$value", but was "$headerValue"',
          );
        }
      }
    }
  }

  /// Checks that the response is successful (status code 2xx or 3xx).
  Future<void> toBeSuccessful() async {
    final successful =
        (_response.status >= 200 && _response.status <= 299) ||
        (_response.status >= 300 && _response.status <= 399);
    if (_isNot) {
      if (successful) {
        throw AssertionError(
          'Expected response not to be successful, but status was ${_response.status}',
        );
      }
    } else {
      if (!successful) {
        throw AssertionError(
          'Expected response to be successful, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response is a client error (status code 4xx).
  Future<void> toBeClientError() async {
    final clientError =
        _response.status >= 400 && _response.status <= 499;
    if (_isNot) {
      if (clientError) {
        throw AssertionError(
          'Expected response not to be a client error, but status was ${_response.status}',
        );
      }
    } else {
      if (!clientError) {
        throw AssertionError(
          'Expected response to be a client error, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response is a server error (status code 5xx).
  Future<void> toBeServerError() async {
    final serverError =
        _response.status >= 500 && _response.status <= 599;
    if (_isNot) {
      if (serverError) {
        throw AssertionError(
          'Expected response not to be a server error, but status was ${_response.status}',
        );
      }
    } else {
      if (!serverError) {
        throw AssertionError(
          'Expected response to be a server error, but status was ${_response.status}',
        );
      }
    }
  }
}
