// Openapi Generator last run: : 2025-06-03T20:21:49.017054
import 'package:Soullog/api/soullog-api/lib/soullog_api.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/record.dart';

// To generate files run: dart run build_runner build --delete-conflicting-outputs
@Openapi(
  additionalProperties: DioProperties(pubName: 'soullog_api', pubAuthor: 'Soullog'),
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
    if (recording.filePath == null || recording.filePath!.isEmpty) {
      return Future.error("No audio file path provided for analysis.");
    }
    final store = await SharedPreferences.getInstance();
    final String personality = store.getString('personality') ?? "";

    var file = await MultipartFile.fromFile(recording!.filePath);
    var result = await _api.analyzeAudio(
      audio: file,
      personality: personality,
      cancelToken: CancelToken(),
      headers: {'Content-Type': 'multipart/form-data'},
    );
    if (result.statusCode == 200) {
      var responseData = result.data;
      store.setString('personality', responseData?.personality.toString() ?? '');
      return Future.value(responseData);
    } else {
      return Future.error('Failed to analyze recording: ${result.statusMessage}');
    }
  }
}
