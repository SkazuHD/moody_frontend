// Openapi Generator last run: : 2025-06-02T17:48:31.142230

import 'package:Soullog/api/soullog-api/lib/src/api.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

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
  // OPEN QUESTION DO WE NEED A SERVICE
  // OR DOES THE COMPONENT ITSELF GETS IT LIKE BELOW?
  final api = SoullogApi().getDefaultApi();

  SoullogApiService() {
    api
        .rootGet()
        .then((value) {
          print(value.data);
        })
        .catchError((error) {
          print("Error: $error");
        });
  }
}
