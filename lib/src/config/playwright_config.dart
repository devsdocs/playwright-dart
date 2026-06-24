import 'dart:io';
import 'dart:convert';
import 'package:yaml/yaml.dart';
import '../generated/channels.dart';

/// Configuration options for Playwright Dart.
///
/// This is a Dart-native feature that provides centralized configuration
/// similar to playwright.config.ts in the Node.js version.
/// Uses pre-existing ContextOptions and LaunchOptions from the protocol.
class PlaywrightConfig {
  /// Browser launch options (uses pre-existing LaunchOptions).
  final LaunchOptions? launchOptions;

  /// Context options (uses pre-existing ContextOptions).
  final ContextOptions? contextOptions;

  /// Test configuration.
  final TestConfig test;

  /// Timeout configurations.
  final TimeoutConfig timeout;

  /// Retry configuration.
  final RetryConfig retry;

  /// Output directory for artifacts (screenshots, videos, traces, etc.).
  final String? outputDir;

  /// Whether to run tests in parallel.
  final bool? fullyParallel;

  /// Maximum number of parallel workers.
  final int? workers;

  /// Whether to forbid running only specific tests (test.only).
  final bool? forbidOnly;

  const PlaywrightConfig({
    this.launchOptions,
    this.contextOptions,
    this.test = const TestConfig(),
    this.timeout = const TimeoutConfig(),
    this.retry = const RetryConfig(),
    this.outputDir,
    this.fullyParallel,
    this.workers,
    this.forbidOnly,
  });

  /// Creates a PlaywrightConfig from a YAML file.
  factory PlaywrightConfig.fromYaml(String yamlContent) {
    final yamlDoc = loadYaml(yamlContent);
    final yamlMap = _yamlToMap(yamlDoc);
    if (yamlMap == null) {
      return const PlaywrightConfig();
    }
    return PlaywrightConfig.fromMap(yamlMap);
  }

  /// Creates a PlaywrightConfig from a JSON string.
  factory PlaywrightConfig.fromJson(String jsonContent) {
    final jsonMap = jsonDecode(jsonContent) as Map<String, dynamic>;
    return PlaywrightConfig.fromMap(jsonMap);
  }

  /// Creates a PlaywrightConfig from a map.
  factory PlaywrightConfig.fromMap(Map<String, dynamic> map) {
    return PlaywrightConfig(
      launchOptions: map['launchOptions'] != null
          ? LaunchOptions.fromJson(map['launchOptions'] as Map<String, dynamic>)
          : null,
      contextOptions: map['contextOptions'] != null
          ? ContextOptions.fromJson(
              map['contextOptions'] as Map<String, dynamic>,
            )
          : null,
      test: map['test'] != null
          ? TestConfig.fromMap(map['test'] as Map<String, dynamic>)
          : const TestConfig(),
      timeout: map['timeout'] != null
          ? TimeoutConfig.fromMap(map['timeout'] as Map<String, dynamic>)
          : const TimeoutConfig(),
      retry: map['retry'] != null
          ? RetryConfig.fromMap(map['retry'] as Map<String, dynamic>)
          : const RetryConfig(),
      outputDir: map['outputDir'] as String?,
      fullyParallel: map['fullyParallel'] as bool?,
      workers: map['workers'] as int?,
      forbidOnly: map['forbidOnly'] as bool?,
    );
  }

  /// Merges this config with another config.
  PlaywrightConfig merge(PlaywrightConfig other) {
    return PlaywrightConfig(
      launchOptions: other.launchOptions ?? launchOptions,
      contextOptions: other.contextOptions ?? contextOptions,
      test: test.merge(other.test),
      timeout: timeout.merge(other.timeout),
      retry: retry.merge(other.retry),
      outputDir: other.outputDir ?? outputDir,
      fullyParallel: other.fullyParallel ?? fullyParallel,
      workers: other.workers ?? workers,
      forbidOnly: other.forbidOnly ?? forbidOnly,
    );
  }

  /// Validates the configuration.
  List<String> validate() {
    final errors = <String>[];

    errors.addAll(test.validate());
    errors.addAll(timeout.validate());
    errors.addAll(retry.validate());

    if (workers != null && workers! < 1) {
      errors.add('workers must be at least 1');
    }

    if (outputDir != null && outputDir!.isEmpty) {
      errors.add('outputDir cannot be empty');
    }

    return errors;
  }

  /// Converts YamlMap/YamlList to regular Map/List.
  static dynamic _yamlToMap(dynamic yaml) {
    if (yaml is YamlMap) {
      final result = <String, dynamic>{};
      for (final key in yaml.keys) {
        result[key.toString()] = _yamlToMap(yaml[key]);
      }
      return result;
    } else if (yaml is YamlList) {
      return yaml.map((e) => _yamlToMap(e)).toList();
    } else if (yaml is List) {
      return yaml.map((e) => _yamlToMap(e)).toList();
    } else if (yaml is Map) {
      final result = <String, dynamic>{};
      yaml.forEach((key, value) {
        result[key.toString()] = _yamlToMap(value);
      });
      return result;
    }
    return yaml;
  }

  /// Loads configuration from the default locations.
  ///
  /// Searches for:
  /// 1. playwright.config.yaml in the current directory
  /// 2. playwright.config.json in the current directory
  /// 3. Returns default config if not found
  static Future<PlaywrightConfig> load() async {
    final currentDir = Directory.current.path;

    // Try playwright.config.yaml
    final yamlConfig = File('$currentDir/playwright.config.yaml');
    if (await yamlConfig.exists()) {
      final content = await yamlConfig.readAsString();
      return PlaywrightConfig.fromYaml(content);
    }

    // Try playwright.config.json
    final jsonConfig = File('$currentDir/playwright.config.json');
    if (await jsonConfig.exists()) {
      final content = await jsonConfig.readAsString();
      return PlaywrightConfig.fromJson(content);
    }

    // Return default config
    return const PlaywrightConfig();
  }

  /// Converts config to a map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'launchOptions': launchOptions?.toJson(),
      'contextOptions': contextOptions?.toJson(),
      'test': test.toMap(),
      'timeout': timeout.toMap(),
      'retry': retry.toMap(),
      'outputDir': outputDir,
      'fullyParallel': fullyParallel,
      'workers': workers,
      'forbidOnly': forbidOnly,
    };
  }

  /// Converts a value to double, handling int to double conversion.
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return null;
  }
}

/// Test configuration.
class TestConfig {
  /// Directory containing test files.
  final String? testDir;

  /// Pattern to match test files.
  final String? testMatch;

  /// Test timeout in milliseconds.
  final double? timeout;

  /// Expect timeout in milliseconds.
  final double? expectTimeout;

  const TestConfig({
    this.testDir,
    this.testMatch,
    this.timeout,
    this.expectTimeout,
  });

  Map<String, dynamic> toMap() {
    return {
      'testDir': testDir,
      'testMatch': testMatch,
      'timeout': timeout,
      'expectTimeout': expectTimeout,
    };
  }

  factory TestConfig.fromMap(Map<String, dynamic> map) {
    return TestConfig(
      testDir: map['testDir'] as String?,
      testMatch: map['testMatch'] as String?,
      timeout: PlaywrightConfig._toDouble(map['timeout']),
      expectTimeout: PlaywrightConfig._toDouble(map['expectTimeout']),
    );
  }

  TestConfig merge(TestConfig other) {
    return TestConfig(
      testDir: other.testDir ?? testDir,
      testMatch: other.testMatch ?? testMatch,
      timeout: other.timeout ?? timeout,
      expectTimeout: other.expectTimeout ?? expectTimeout,
    );
  }

  List<String> validate() {
    final errors = <String>[];
    if (timeout != null && timeout! < 0) {
      errors.add('timeout cannot be negative');
    }
    if (expectTimeout != null && expectTimeout! < 0) {
      errors.add('expectTimeout cannot be negative');
    }
    return errors;
  }
}

/// Timeout configuration.
class TimeoutConfig {
  /// Default timeout in milliseconds.
  final double? defaultTimeout;

  /// Navigation timeout in milliseconds.
  final double? navigationTimeout;

  /// Action timeout in milliseconds.
  final double? actionTimeout;

  const TimeoutConfig({
    this.defaultTimeout,
    this.navigationTimeout,
    this.actionTimeout,
  });

  Map<String, dynamic> toMap() {
    return {
      'defaultTimeout': defaultTimeout,
      'navigationTimeout': navigationTimeout,
      'actionTimeout': actionTimeout,
    };
  }

  factory TimeoutConfig.fromMap(Map<String, dynamic> map) {
    return TimeoutConfig(
      defaultTimeout: PlaywrightConfig._toDouble(map['defaultTimeout']),
      navigationTimeout: PlaywrightConfig._toDouble(map['navigationTimeout']),
      actionTimeout: PlaywrightConfig._toDouble(map['actionTimeout']),
    );
  }

  TimeoutConfig merge(TimeoutConfig other) {
    return TimeoutConfig(
      defaultTimeout: other.defaultTimeout ?? defaultTimeout,
      navigationTimeout: other.navigationTimeout ?? navigationTimeout,
      actionTimeout: other.actionTimeout ?? actionTimeout,
    );
  }

  List<String> validate() {
    final errors = <String>[];
    if (defaultTimeout != null && defaultTimeout! < 0) {
      errors.add('defaultTimeout cannot be negative');
    }
    if (navigationTimeout != null && navigationTimeout! < 0) {
      errors.add('navigationTimeout cannot be negative');
    }
    if (actionTimeout != null && actionTimeout! < 0) {
      errors.add('actionTimeout cannot be negative');
    }
    return errors;
  }
}

/// Retry configuration.
class RetryConfig {
  /// Number of retries for failed tests.
  final int? retries;

  const RetryConfig({this.retries});

  Map<String, dynamic> toMap() {
    return {'retries': retries};
  }

  factory RetryConfig.fromMap(Map<String, dynamic> map) {
    return RetryConfig(retries: map['retries'] as int?);
  }

  RetryConfig merge(RetryConfig other) {
    return RetryConfig(retries: other.retries ?? retries);
  }

  List<String> validate() {
    final errors = <String>[];
    if (retries != null && retries! < 0) {
      errors.add('retries cannot be negative');
    }
    return errors;
  }
}

/// Helper function to define Playwright configuration.
///
/// Usage:
/// ```dart
/// final config = definePlaywrightConfig(
///   launchOptions: LaunchOptions(timeout: 30000, headless: true),
///   contextOptions: ContextOptions(viewport: ContextOptionsViewport(width: 1280, height: 720)),
///   timeout: TimeoutConfig(defaultTimeout: 30000),
/// );
/// ```
PlaywrightConfig definePlaywrightConfig({
  LaunchOptions? launchOptions,
  ContextOptions? contextOptions,
  TestConfig? test,
  TimeoutConfig? timeout,
  RetryConfig? retry,
  String? outputDir,
  bool? fullyParallel,
  int? workers,
  bool? forbidOnly,
}) {
  return PlaywrightConfig(
    launchOptions: launchOptions,
    contextOptions: contextOptions,
    test: test ?? const TestConfig(),
    timeout: timeout ?? const TimeoutConfig(),
    retry: retry ?? const RetryConfig(),
    outputDir: outputDir,
    fullyParallel: fullyParallel,
    workers: workers,
    forbidOnly: forbidOnly,
  );
}
