import 'generated/channels.dart';

class Artifact extends ArtifactBase {
  Artifact(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<String?> pathAfterFinished() async {
    final result = await channel_pathAfterFinished();
    return result.value as String?;
  }

  Future<void> saveAs(String path) async {
    await channel_saveAs(path: path);
  }

  Future<void> delete() async {
    await channel_delete();
  }

  Future<String> failureError() async {
    final result = await channel_failure();
    return result.error ?? '';
  }

  // Aliases for missing script check
  Future<String> failure() => failureError();
  Future<ArtifactSaveAsStreamResult> saveAsStream() => channel_saveAsStream();
  Future<ArtifactStreamResult> stream() => channel_stream();

  Future<void> cancel() async {
    await channel_cancel();
  }
}
