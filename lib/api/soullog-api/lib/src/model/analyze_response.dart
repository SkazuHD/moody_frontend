//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
// ignore_for_file: unused_element
import 'package:soullog_api/src/model/persona.dart';

part 'analyze_response.g.dart';

/// AnalyzeResponse
///
/// Properties:
/// * [mood]
/// * [transcription] - Transcription of the diary entry.
/// * [recommendations]
/// * [quote]
/// * [personality]
@BuiltValue()
abstract class AnalyzeResponse implements Built<AnalyzeResponse, AnalyzeResponseBuilder> {
  @BuiltValueField(wireName: r'mood')
  AnalyzeResponseMoodEnum get mood;
  // enum moodEnum {  happy,  sad,  calm,  fearful,  angry,  disgust,  neutral,  suprised,  };

  /// Transcription of the diary entry.
  @BuiltValueField(wireName: r'transcription')
  String get transcription;

  @BuiltValueField(wireName: r'recommendations')
  BuiltList<JsonObject?> get recommendations;

  @BuiltValueField(wireName: r'quote')
  String get quote;

  @BuiltValueField(wireName: r'personality')
  Persona get personality;

  AnalyzeResponse._();

  factory AnalyzeResponse([void updates(AnalyzeResponseBuilder b)]) = _$AnalyzeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnalyzeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnalyzeResponse> get serializer => _$AnalyzeResponseSerializer();
}

class _$AnalyzeResponseSerializer implements PrimitiveSerializer<AnalyzeResponse> {
  @override
  final Iterable<Type> types = const [AnalyzeResponse, _$AnalyzeResponse];

  @override
  final String wireName = r'AnalyzeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnalyzeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mood';
    yield serializers.serialize(
      object.mood,
      specifiedType: const FullType(AnalyzeResponseMoodEnum),
    );
    yield r'transcription';
    yield serializers.serialize(
      object.transcription,
      specifiedType: const FullType(String),
    );
    yield r'recommendations';
    yield serializers.serialize(
      object.recommendations,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'quote';
    yield serializers.serialize(
      object.quote,
      specifiedType: const FullType(String),
    );
    yield r'personality';
    yield serializers.serialize(
      object.personality,
      specifiedType: const FullType(Persona),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AnalyzeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnalyzeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mood':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AnalyzeResponseMoodEnum),
          ) as AnalyzeResponseMoodEnum;
          result.mood = valueDes;
          break;
        case r'transcription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transcription = valueDes;
          break;
        case r'recommendations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.recommendations.replace(valueDes);
          break;
        case r'quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quote = valueDes;
          break;
        case r'personality':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Persona),
          ) as Persona;
          result.personality.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnalyzeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnalyzeResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class AnalyzeResponseMoodEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'happy')
  static const AnalyzeResponseMoodEnum happy = _$analyzeResponseMoodEnum_happy;
  @BuiltValueEnumConst(wireName: r'sad')
  static const AnalyzeResponseMoodEnum sad = _$analyzeResponseMoodEnum_sad;
  @BuiltValueEnumConst(wireName: r'calm')
  static const AnalyzeResponseMoodEnum calm = _$analyzeResponseMoodEnum_calm;
  @BuiltValueEnumConst(wireName: r'fearful')
  static const AnalyzeResponseMoodEnum fearful = _$analyzeResponseMoodEnum_fearful;
  @BuiltValueEnumConst(wireName: r'angry')
  static const AnalyzeResponseMoodEnum angry = _$analyzeResponseMoodEnum_angry;
  @BuiltValueEnumConst(wireName: r'disgust')
  static const AnalyzeResponseMoodEnum disgust = _$analyzeResponseMoodEnum_disgust;
  @BuiltValueEnumConst(wireName: r'neutral')
  static const AnalyzeResponseMoodEnum neutral = _$analyzeResponseMoodEnum_neutral;
  @BuiltValueEnumConst(wireName: r'suprised')
  static const AnalyzeResponseMoodEnum suprised = _$analyzeResponseMoodEnum_suprised;

  static Serializer<AnalyzeResponseMoodEnum> get serializer => _$analyzeResponseMoodEnumSerializer;

  const AnalyzeResponseMoodEnum._(String name) : super(name);

  static BuiltSet<AnalyzeResponseMoodEnum> get values => _$analyzeResponseMoodEnumValues;
  static AnalyzeResponseMoodEnum valueOf(String name) => _$analyzeResponseMoodEnumValueOf(name);
}
