//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:soullog_api/src/date_serializer.dart';
import 'package:soullog_api/src/model/analyze_response.dart';
import 'package:soullog_api/src/model/contextual_insight.dart';
import 'package:soullog_api/src/model/date.dart';
import 'package:soullog_api/src/model/http_validation_error.dart';
import 'package:soullog_api/src/model/persona.dart';
import 'package:soullog_api/src/model/short_term_state.dart';
import 'package:soullog_api/src/model/validation_error.dart';
import 'package:soullog_api/src/model/validation_error_loc_inner.dart';

part 'serializers.g.dart';

@SerializersFor([
  AnalyzeResponse,
  ContextualInsight,
  HTTPValidationError,
  Persona,
  ShortTermState,
  ValidationError,
  ValidationErrorLocInner,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
        () => MapBuilder<String, JsonObject>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
