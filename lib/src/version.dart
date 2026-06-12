import 'dart:convert';
import 'package:http/http.dart' as http;

const String fallbackPlaywrightVersion = '1.60.0';

/// Fetches the latest playwright-core version from the official NPM registry,
/// falling back to the hardcoded [fallbackPlaywrightVersion] if it fails.
Future<String> getPlaywrightVersion() async {
  try {
    final response = await http.get(
      Uri.parse('https://registry.npmjs.org/playwright-core/latest'),
    );
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
