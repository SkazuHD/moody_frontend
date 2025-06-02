// Openapi Generator last run: : 2025-06-02T17:48:31.142230
import 'package:Soullog/api/soullog-api/lib/soullog_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

import '../data/models/record.dart';

// To generate files run: dart run build_runner build --delete-conflicting-outputs
@Openapi(
  additionalProperties: DioProperties(
    pubName: 'soullog_api',
    pubAuthor: 'Soullog',
  ),
  inputSpec: RemoteSpec(path: 'https://moody-app.skazu.net/openapi.json'),
  // typeMappings: {'Pet': 'ExamplePet'},
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'lib/api/soullog-api',
)
class SoullogApiService {
  static final SoullogApiService _instance = SoullogApiService._internal();

  late final SoullogApi _soullogApi;
  late final DefaultApi _api;
  late final Serializers _serializers;
  late final Dio _dio;

  factory SoullogApiService() {
    return _instance;
  }

  SoullogApiService._internal() {
    _soullogApi = SoullogApi();
    _api = _soullogApi.getDefaultApi();
    _serializers = _soullogApi.serializers;
    _dio = _soullogApi.dio;
  }

  Future<AnalyzeResponse> analyzeRecording(Recording recording) async {
    if (recording.filePath.isEmpty) {
      return Future.error("No audio file path provided for analysis.");
    }

    var personalityBuilder = ListBuilder<JsonObject>();
    var file = await MultipartFile.fromFile(recording.filePath);
    var result = await _api.analyzeAnalyzePost(
      audio: file,
      personality: personalityBuilder.build(),
      cancelToken: CancelToken(),
      headers: {'Content-Type': 'multipart/form-data'},
    );
    if (result.statusCode == 200) {
      var responseData = result.data;
      return Future.value(responseData);
    } else {
      return Future.error(
        'Failed to analyze recording: ${result.statusMessage}',
      );
    }
  }
}
