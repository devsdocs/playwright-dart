import '../generated/channels.dart';

/// Interface for Artifact
abstract interface class Artifact {
  Future<String?> pathAfterFinished();
  Future<void> saveAs(String path);
  Future<void> delete();
  Future<String> failureError();
  Future<String> failure();
  Future<ArtifactSaveAsStreamResult> saveAsStream();
  Future<ArtifactStreamResult> stream();
  Future<void> cancel();
}

class ArtifactImpl extends ArtifactBase implements Artifact {
  ArtifactImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<String?> pathAfterFinished() async {
    final result = await channel.pathAfterFinished();
    return result.value as String?;
  }

  @override
  Future<void> saveAs(String path) async {
    await channel.saveAs(path: path);
  }

  @override
  Future<void> delete() async {
    await channel.delete();
  }

  @override
  Future<String> failureError() async {
    final result = await channel.failure();
    return result.error ?? '';
  }

  // Aliases for missing script check
  @override
  Future<String> failure() => failureError();
  @override
  Future<ArtifactSaveAsStreamResult> saveAsStream() => channel.saveAsStream();
  @override
  Future<ArtifactStreamResult> stream() => channel.stream();

  @override
  Future<void> cancel() async {
    await channel.cancel();
  }
}
