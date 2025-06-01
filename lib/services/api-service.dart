// Openapi Generator last run: : 2025-05-30T12:15:50.854513

import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

import 'package:Soullog/api/soullog-api/lib/soullog_api.dart';


// To generate files run: dart run build_runner build --delete-conflicting-outputs
@Openapi(
  additionalProperties:
  DioProperties(pubName: 'soullog_api', pubAuthor: 'Soullog'),
  inputSpec:
  RemoteSpec(path: 'https://moody-app.skazu.net/openapi.json'),
 // typeMappings: {'Pet': 'ExamplePet'},
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'soullog-api',
)
class SoullogApiService {
  // OPEN QUESTION DO WE NEED A SERVICE
  // OR DOES THE COMPONENT ITSELF GETS IT LIKE BELOW?
  final api = SoullogApi().getDefaultApi();

  SoullogApiService(){
    api.rootGet().then(
        (value) {
          print(value.data);
        }
    ).catchError(
        (error) {
          print("Error: $error");
        }
    );
  }

}