import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:playwright_dart/src/infrastructure/driver_downloader.dart';
import 'package:test/test.dart';

void main() {
  group('fetchNodeVersion', () {
    test('returns node version from github script on success', () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString() ==
            'https://registry.npmjs.org/playwright-core/1.2.3') {
          return http.Response(jsonEncode({'gitHead': 'mockGitHead123'}), 200);
        } else if (request.url.toString() ==
            'https://raw.githubusercontent.com/microsoft/playwright/mockGitHead123/utils/build/build-playwright-driver.sh') {
          return http.Response(
            'some bash code\nNODE_VERSION="18.15.0"\nmore code',
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      final version = await fetchNodeVersion('1.2.3', client: mockClient);
      expect(version, '18.15.0');
    });

    test('returns fallback if npm registry fails', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Error', 500);
      });

      final version = await fetchNodeVersion('1.2.3', client: mockClient);
      expect(version, '20.14.0');
    });

    test('returns fallback if gitHead is missing', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({'otherKey': 'value'}), 200);
      });

      final version = await fetchNodeVersion('1.2.3', client: mockClient);
      expect(version, '20.14.0');
    });

    test('returns fallback if script fetch fails', () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString().contains('npmjs')) {
          return http.Response(jsonEncode({'gitHead': 'mockGitHead123'}), 200);
        } else {
          return http.Response('Error', 500);
        }
      });

      final version = await fetchNodeVersion('1.2.3', client: mockClient);
      expect(version, '20.14.0');
    });

    test('returns fallback if script does not contain NODE_VERSION', () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString().contains('npmjs')) {
          return http.Response(jsonEncode({'gitHead': 'mockGitHead123'}), 200);
        } else {
          return http.Response('some script without node version', 200);
        }
      });

      final version = await fetchNodeVersion('1.2.3', client: mockClient);
      expect(version, '20.14.0');
    });
  });

  group('ensureBrowsersInstalled', () {
    test('skips if already installed', () async {
      final dir = Directory.systemTemp.createTempSync(
        'playwright_test_installed',
      );
      try {
        final markerPath = '${dir.path}/.browsers-installed';
        File(markerPath).writeAsStringSync('done');

        var calledProcess = false;
        await ensureBrowsersInstalled(
          driverDirOverride: dir.path,
          processRunSync: (exe, args) {
            calledProcess = true;
            return ProcessResult(0, 0, '', '');
          },
        );

        expect(calledProcess, isFalse);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });

    test('calls install command if not installed', () async {
      final dir = Directory.systemTemp.createTempSync(
        'playwright_test_not_installed',
      );
      try {
        var calledProcess = false;
        List<String>? runArgs;

        await ensureBrowsersInstalled(
          driverDirOverride: dir.path,
          processRunSync: (exe, args) {
            if (args.contains('install')) {
              calledProcess = true;
              runArgs = args;
            }
            return ProcessResult(0, 0, '', '');
          },
        );

        expect(calledProcess, isTrue);
        expect(runArgs?.contains('install'), isTrue);
        expect(File('${dir.path}/.browsers-installed').existsSync(), isTrue);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });
  });
}
