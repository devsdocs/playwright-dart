import '../core/playwright.dart';
import '../generated/channels.dart';
import '../utils/logger.dart';

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

  final harId = await (playwright as PlaywrightImpl).utils.harOpen(harPath);

  Logger.debug('HAR opened with id: $harId', name: 'playwright.har');

  await contextOrPage.route(url ?? '**/*', (route) async {
    final request = route.request;
    Logger.debug('Received request: ${request.method} ${request.url}', name: 'playwright.har');
    try {
      final postData = request.postData;

      Logger.debug('Handling request: ${request.method} ${request.url}', name: 'playwright.har');

      final result = await (playwright).utils.harLookup(
        harId,
        request.url,
        request.method,
        request.headers.entries
            .map<NameValue>(
              (e) => NameValue(name: e.key, value: e.value.toString()),
            )
            .toList(),
        request.isNavigationRequest,
        postData: postData,
      );

      Logger.debug(
        'HAR lookup result: action=${result.action}, status=${result.status}',
        name: 'playwright.har',
      );

      if (result.action == LocalUtilsHarLookupResultActionEnum.redirect) {
        await route.continueRoute(url: result.redirectURL, isFallback: true);
        return;
      }

      if (result.action == LocalUtilsHarLookupResultActionEnum.fulfill) {
        await route.fulfill(
          status: result.status,
          headers: result.headers,
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
      Logger.error('Error in sharedRouteFromHAR', e, st);
      await route.abort();
    }
  });
}
