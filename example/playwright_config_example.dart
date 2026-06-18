import 'package:playwright_dart/playwright_dart.dart';

/// Example demonstrating PlaywrightConfig with YAML and JSON parsing.
void main() async {
  // Example 1: Load config from YAML string
  final yamlConfig = '''
launchOptions:
  headless: true
  channel: chrome
  timeout: 30000
contextOptions:
  viewport:
    width: 1280
    height: 720
  userAgent: "Custom User Agent"
  locale: "en-US"
test:
  testDir: "tests"
  timeout: 60000
timeout:
  defaultTimeout: 30000
  actionTimeout: 10000
retry:
  retries: 2
outputDir: "test-results"
fullyParallel: true
workers: 4
''';

  final configFromYaml = PlaywrightConfig.fromYaml(yamlConfig);
  print('Config loaded from YAML:');
  print('  Headless: ${configFromYaml.launchOptions?.headless}');
  print('  Viewport: ${configFromYaml.contextOptions?.viewport}');
  print('  Workers: ${configFromYaml.workers}');

  // Example 2: Load config from JSON string
  final jsonConfig = '''
{
  "launchOptions": {
    "headless": true,
    "channel": "chrome",
    "timeout": 30000
  },
  "contextOptions": {
    "viewport": {
      "width": 1280,
      "height": 720
    },
    "userAgent": "Custom User Agent",
    "locale": "en-US"
  },
  "test": {
    "testDir": "tests",
    "timeout": 60000
  },
  "timeout": {
    "defaultTimeout": 30000,
    "actionTimeout": 10000
  },
  "retry": {
    "retries": 2
  },
  "outputDir": "test-results",
  "fullyParallel": true,
  "workers": 4
}
''';

  final configFromJson = PlaywrightConfig.fromJson(jsonConfig);
  print('Config loaded from JSON:');
  print('  Headless: ${configFromJson.launchOptions?.headless}');
  print('  Workers: ${configFromJson.workers}');

  // Example 3: Load config from file on disk (YAML or JSON)
  final config = await PlaywrightConfig.load();
  print('Config loaded from disk: ${config.toMap()}');

  // Example 4: Define config programmatically using pre-existing protocol objects
  final programmaticConfig = definePlaywrightConfig(
    launchOptions: LaunchOptions(
      headless: true,
      channel: 'chrome',
      timeout: 30000,
    ),
    contextOptions: ContextOptions(
      viewport: ContextOptionsViewport(width: 1280, height: 720),
      userAgent: 'Custom User Agent',
      locale: 'en-US',
    ),
    timeout: TimeoutConfig(defaultTimeout: 30000),
    retry: RetryConfig(retries: 2),
    outputDir: 'test-results',
    workers: 4,
  );

  print('Programmatic config: ${programmaticConfig.toMap()}');
}
