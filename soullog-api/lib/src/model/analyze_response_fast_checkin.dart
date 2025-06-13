//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'analyze_response_fast_checkin.g.dart';

/// AnalyzeResponseFastCheckin
///
/// Properties:
/// * [mood]
/// * [recommendations] - Suggestions for improving mood or well-being.
/// * [quote] - A random quote related to the mood.
@BuiltValue()
abstract class AnalyzeResponseFastCheckin
    implements
        Built<AnalyzeResponseFastCheckin, AnalyzeResponseFastCheckinBuilder> {
  @BuiltValueField(wireName: r'mood')
  AnalyzeResponseFastCheckinMoodEnum get mood;
  // enum moodEnum {  happy,  sad,  calm,  fearful,  angry,  disgust,  neutral,  surprised,  };

  /// Suggestions for improving mood or well-being.
  @BuiltValueField(wireName: r'recommendations')
  BuiltList<String> get recommendations;

  /// A random quote related to the mood.
  @BuiltValueField(wireName: r'quote')
  String get quote;

  AnalyzeResponseFastCheckin._();

  factory AnalyzeResponseFastCheckin(
          [void updates(AnalyzeResponseFastCheckinBuilder b)]) =
      _$AnalyzeResponseFastCheckin;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnalyzeResponseFastCheckinBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnalyzeResponseFastCheckin> get serializer =>
      _$AnalyzeResponseFastCheckinSerializer();
}

class _$AnalyzeResponseFastCheckinSerializer
    implements PrimitiveSerializer<AnalyzeResponseFastCheckin> {
  @override
  final Iterable<Type> types = const [
    AnalyzeResponseFastCheckin,
    _$AnalyzeResponseFastCheckin
  ];

  @override
  final String wireName = r'AnalyzeResponseFastCheckin';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnalyzeResponseFastCheckin object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mood';
    yield serializers.serialize(
      object.mood,
      specifiedType: const FullType(AnalyzeResponseFastCheckinMoodEnum),
    );
    yield r'recommendations';
    yield serializers.serialize(
      object.recommendations,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'quote';
    yield serializers.serialize(
      object.quote,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AnalyzeResponseFastCheckin object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnalyzeResponseFastCheckinBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mood':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AnalyzeResponseFastCheckinMoodEnum),
          ) as AnalyzeResponseFastCheckinMoodEnum;
          result.mood = valueDes;
          break;
        case r'recommendations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.recommendations.replace(valueDes);
          break;
        case r'quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnalyzeResponseFastCheckin deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnalyzeResponseFastCheckinBuilder();
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

class AnalyzeResponseFastCheckinMoodEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'happy')
  static const AnalyzeResponseFastCheckinMoodEnum happy =
      _$analyzeResponseFastCheckinMoodEnum_happy;
  @BuiltValueEnumConst(wireName: r'sad')
  static const AnalyzeResponseFastCheckinMoodEnum sad =
      _$analyzeResponseFastCheckinMoodEnum_sad;
  @BuiltValueEnumConst(wireName: r'calm')
  static const AnalyzeResponseFastCheckinMoodEnum calm =
      _$analyzeResponseFastCheckinMoodEnum_calm;
  @BuiltValueEnumConst(wireName: r'fearful')
  static const AnalyzeResponseFastCheckinMoodEnum fearful =
      _$analyzeResponseFastCheckinMoodEnum_fearful;
  @BuiltValueEnumConst(wireName: r'angry')
  static const AnalyzeResponseFastCheckinMoodEnum angry =
      _$analyzeResponseFastCheckinMoodEnum_angry;
  @BuiltValueEnumConst(wireName: r'disgust')
  static const AnalyzeResponseFastCheckinMoodEnum disgust =
      _$analyzeResponseFastCheckinMoodEnum_disgust;
  @BuiltValueEnumConst(wireName: r'neutral')
  static const AnalyzeResponseFastCheckinMoodEnum neutral =
      _$analyzeResponseFastCheckinMoodEnum_neutral;
  @BuiltValueEnumConst(wireName: r'surprised')
  static const AnalyzeResponseFastCheckinMoodEnum surprised =
      _$analyzeResponseFastCheckinMoodEnum_surprised;

  static Serializer<AnalyzeResponseFastCheckinMoodEnum> get serializer =>
      _$analyzeResponseFastCheckinMoodEnumSerializer;

  const AnalyzeResponseFastCheckinMoodEnum._(String name) : super(name);

  static BuiltSet<AnalyzeResponseFastCheckinMoodEnum> get values =>
      _$analyzeResponseFastCheckinMoodEnumValues;
  static AnalyzeResponseFastCheckinMoodEnum valueOf(String name) =>
      _$analyzeResponseFastCheckinMoodEnumValueOf(name);
}
