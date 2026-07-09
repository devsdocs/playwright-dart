import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getAllProtocolYml(String version) async {
  final cacheFile = File('.protocol_cache/$version/files.json');
  if (cacheFile.existsSync()) {
    return jsonDecode(cacheFile.readAsStringSync());
  }

  final response = await HttpClient().getUrl(
    Uri.parse(
      'https://api.github.com/repos/microsoft/playwright/contents/packages/protocol/spec?ref=v$version',
    ),
  );
  final request = await response.close();
  final body = await request.transform(const Utf8Decoder()).join();
  if (request.statusCode != 200) {
    print('Failed to fetch protocol specs from GitHub: $body');
    exit(1);
  }

  final files = jsonDecode(body);
  cacheFile.writeAsStringSync(body);
  return files;
}
