@TestOn('vm')
library;

import 'dart:io';
import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  group('PlaywrightConfig', () {
    test('should load config from YAML file', () async {
      final configFile = File('test/playwright.config.yaml');
      expect(await configFile.exists(), isTrue);

      final content = await configFile.readAsString();
      final config = PlaywrightConfig.fromYaml(content);

      expect(config.launchOptions?.headless, isTrue);
      expect(config.launchOptions?.channel, 'chrome');
      expect(config.launchOptions?.timeout, 30000);
      expect(config.contextOptions?.viewport?.width, 1280);
      expect(config.contextOptions?.viewport?.height, 720);
      expect(config.contextOptions?.userAgent, 'Test User Agent');
      expect(config.contextOptions?.locale, 'en-US');
      expect(config.test.testDir, 'test');
      expect(config.outputDir, 'test-results');
      expect(config.fullyParallel, isFalse);
      expect(config.workers, 1);
    });

    test('should load config from JSON file', () async {
      final configFile = File('test/playwright.config.json');
      expect(await configFile.exists(), isTrue);

      final content = await configFile.readAsString();
      final config = PlaywrightConfig.fromJson(content);

      expect(config.launchOptions?.headless, isTrue);
      expect(config.launchOptions?.channel, 'chrome');
      expect(config.launchOptions?.timeout, 30000);
      expect(config.contextOptions?.viewport?.width, 1280);
      expect(config.contextOptions?.viewport?.height, 720);
      expect(config.contextOptions?.userAgent, 'Test User Agent');
      expect(config.contextOptions?.locale, 'en-US');
      expect(config.test.testDir, 'test');
      expect(config.outputDir, 'test-results');
      expect(config.fullyParallel, isFalse);
      expect(config.workers, 1);
    });

    test('should create config programmatically', () {
      final config = definePlaywrightConfig(
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

      expect(config.launchOptions?.headless, isTrue);
      expect(config.launchOptions?.channel, 'chrome');
      expect(config.launchOptions?.timeout, 30000);
      expect(config.contextOptions?.viewport?.width, 1280);
      expect(config.contextOptions?.viewport?.height, 720);
      expect(config.contextOptions?.userAgent, 'Custom User Agent');
      expect(config.contextOptions?.locale, 'en-US');
      expect(config.timeout.defaultTimeout, 30000);
      expect(config.retry.retries, 2);
      expect(config.outputDir, 'test-results');
      expect(config.workers, 4);
    });

    test('should convert config to map', () {
      final config = definePlaywrightConfig(
        launchOptions: LaunchOptions(headless: true, timeout: 30000),
        timeout: TimeoutConfig(defaultTimeout: 30000),
        workers: 4,
      );

      final map = config.toMap();

      expect(map['launchOptions'], isNotNull);
      expect(map['launchOptions']['headless'], isTrue);
      expect(map['workers'], 4);
    });

    test('should handle empty YAML config', () {
      final config = PlaywrightConfig.fromYaml('');

      expect(config.launchOptions, isNull);
      expect(config.contextOptions, isNull);
      expect(config.workers, isNull);
      expect(config.test.testDir, isNull);
    });

    test('should handle empty JSON config', () {
      final config = PlaywrightConfig.fromJson('{}');

      expect(config.launchOptions, isNull);
      expect(config.contextOptions, isNull);
      expect(config.workers, isNull);
      expect(config.test.testDir, isNull);
    });

    test('load() should return default config if no file exists', () async {
      final dir = Directory.systemTemp.createTempSync('playwright_config_test');
      try {
        final config = await PlaywrightConfig.load(cwd: dir.path);
        expect(config.workers, isNull);
        expect(config.outputDir, isNull);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });

    test('load() should prioritize yaml over json', () async {
      final dir = Directory.systemTemp.createTempSync(
        'playwright_config_test_yaml',
      );
      try {
        final yamlFile = File('${dir.path}/playwright.config.yaml');
        yamlFile.writeAsStringSync('workers: 5\n');

        final jsonFile = File('${dir.path}/playwright.config.json');
        jsonFile.writeAsStringSync('{"workers": 3}');

        final config = await PlaywrightConfig.load(cwd: dir.path);
        expect(config.workers, 5);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });

    test('load() should read json if yaml does not exist', () async {
      final dir = Directory.systemTemp.createTempSync(
        'playwright_config_test_json',
      );
      try {
        final jsonFile = File('${dir.path}/playwright.config.json');
        jsonFile.writeAsStringSync('{"workers": 10}');

        final config = await PlaywrightConfig.load(cwd: dir.path);
        expect(config.workers, 10);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });
  });
}
