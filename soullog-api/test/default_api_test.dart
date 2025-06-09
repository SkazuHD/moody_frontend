import 'package:test/test.dart';
import 'package:soullog_api/soullog_api.dart';

/// tests for DefaultApi
void main() {
  final instance = SoullogApi().getDefaultApi();

  group(DefaultApi, () {
    // Analyze audio diary entry
    //
    // Transcribe audio, detect mood, and update user persona based on the transcript.
    //
    //Future<AnalyzeResponse> analyzeAudio(MultipartFile audio, { String personality }) async
    test('test analyzeAudio', () async {
      // TODO
    });

    // Root
    //
    //Future<BuiltMap<String, JsonObject>> rootGet() async
    test('test rootGet', () async {
      // TODO
    });
  });
}
