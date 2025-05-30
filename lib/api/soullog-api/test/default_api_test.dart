import 'package:test/test.dart';
import 'package:soullog_api/soullog_api.dart';

/// tests for DefaultApi
void main() {
  final instance = SoullogApi().getDefaultApi();

  group(DefaultApi, () {
    // Analyze
    //
    //Future<JsonObject> analyzeAnalyzePost(MultipartFile audio, { BuiltList<JsonObject> personality }) async
    test('test analyzeAnalyzePost', () async {
      // TODO
    });

    // Root
    //
    //Future<JsonObject> rootGet() async
    test('test rootGet', () async {
      // TODO
    });
  });
}
