import 'playwright.dart';
import 'generated/channels.dart';

Future<void> sharedRouteFromHAR(
  dynamic contextOrPage,
  String harPath, {
  String? url,
  bool notFoundFallback = false,
}) async {
  final connection = contextOrPage.connection;
  final playwright =
      connection.objects.values.firstWhere((e) => e is PlaywrightBase)
          as Playwright;

  final harId = await playwright.utils.harOpen(harPath);

  print('HAR opened with id: $harId');

  await contextOrPage.route(url ?? '**/*', (route) async {
    final request = route.request;
    print('Received request: ${request.method} ${request.url}');
    try {
      final postData = request.postData;

      print('Handling request: ${request.method} ${request.url}');

      final result = await playwright.utils.harLookup(
        harId,
        request.url,
        request.method,
        request.headers.entries
            .map<NameValue>((e) => NameValue(name: e.key, value: e.value.toString()))
            .toList(),
        request.isNavigationRequest,
        postData: postData,
      );

      print('HAR lookup result: action=${result.action}, status=${result.status}');

      if (result.action == LocalUtilsHarLookupResultActionEnum.redirect) {
        await route.continueRoute(url: result.redirectURL, isFallback: true);
        return;
      }

      if (result.action == LocalUtilsHarLookupResultActionEnum.fulfill) {
        await route.fulfill(
          status: result.status,
          headers: result.headers?.fold<Map<String, String>>({}, (m, h) {
            m[h.name] = h.value;
            return m;
          }),
          body: result.body,
          isBase64: result.body != null ? true : null,
        );
        return;
      }

      if (result.action == LocalUtilsHarLookupResultActionEnum.error) {
        await route.abort();
        return;
      }

      if (result.action == LocalUtilsHarLookupResultActionEnum.noentry) {
        if (notFoundFallback) {
          await route.continueRoute(isFallback: true);
        } else {
          await route.abort();
        }
      }
    } catch (e, st) {
      print('Error in sharedRouteFromHAR: $e\n$st');
      await route.abort();
    }
  });
}
