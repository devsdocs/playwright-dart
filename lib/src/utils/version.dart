import 'dart:convert';
import 'package:http/http.dart' as http;

const String fallbackPlaywrightVersion = '1.61.0';

/// Fetches the latest playwright-core version from the official NPM registry,
/// falling back to the hardcoded [fallbackPlaywrightVersion] if it fails.
Future<String> getPlaywrightVersion({http.Client? client}) async {
  try {
    final uri = Uri.parse('https://registry.npmjs.org/playwright-core/latest');
    final response = await (client != null ? client.get(uri) : http.get(uri));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final version = json['version'];
      if (version != null && version is String) {
        return version;
      }
    }
  } catch (_) {
    // Ignore network or parsing errors and use the fallback
  }
  return fallbackPlaywrightVersion;
}
