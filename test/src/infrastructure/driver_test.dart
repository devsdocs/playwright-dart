import 'dart:async';
import 'dart:io';
import 'package:playwright_dart/src/infrastructure/driver.dart';
import 'package:test/test.dart';

class MockProcess implements Process {
  @override
  int get pid => 12345;

  @override
  Future<int> get exitCode => Future.value(0);

  @override
  Stream<List<int>> get stdout => const Stream.empty();

  @override
  Stream<List<int>> get stderr => const Stream.empty();

  @override
  IOSink get stdin => throw UnimplementedError();

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) => true;
}

void main() {
  group('Driver', () {
    final originalProcessStart = Driver.processStart;
    final originalGetDriverPath = Driver.getDriverPath;

    tearDown(() {
      Driver.processStart = originalProcessStart;
      Driver.getDriverPath = originalGetDriverPath;
    });

    test(
      'run() should launch driver using provided node path and cli path',
      () async {
        String? launchedExecutable;
        List<String>? launchedArgs;

        Driver.getDriverPath = () async => '/mock/driver/path';
        Driver.processStart = (executable, args) async {
          launchedExecutable = executable;
          launchedArgs = args;
          return MockProcess();
        };

        final process = await Driver.run();

        expect(process.pid, 12345);

        final isWindows = Platform.isWindows;
        final expectedNode = isWindows
            ? '/mock/driver/path\\node.exe'
            : '/mock/driver/path/node';
        final expectedCli = isWindows
            ? '/mock/driver/path\\package\\cli.js'
            : '/mock/driver/path/package/cli.js';

        expect(launchedExecutable, expectedNode);
        expect(launchedArgs, [expectedCli, 'run-driver']);
      },
    );
  });
}
