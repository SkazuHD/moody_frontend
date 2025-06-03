//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contextual_insight.g.dart';

/// ContextualInsight
///
/// Properties:
/// * [insight] - A person, event, or topic frequently mentioned.
/// * [lastMentioned] - Number of diary entries since last mention.
@BuiltValue()
abstract class ContextualInsight
    implements Built<ContextualInsight, ContextualInsightBuilder> {
  /// A person, event, or topic frequently mentioned.
  @BuiltValueField(wireName: r'insight')
  String get insight;

  /// Number of diary entries since last mention.
  @BuiltValueField(wireName: r'last_mentioned')
  int get lastMentioned;

  ContextualInsight._();

  factory ContextualInsight([void updates(ContextualInsightBuilder b)]) =
      _$ContextualInsight;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContextualInsightBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContextualInsight> get serializer =>
      _$ContextualInsightSerializer();
}

class _$ContextualInsightSerializer
    implements PrimitiveSerializer<ContextualInsight> {
  @override
  final Iterable<Type> types = const [ContextualInsight, _$ContextualInsight];

  @override
  final String wireName = r'ContextualInsight';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContextualInsight object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'insight';
    yield serializers.serialize(
      object.insight,
      specifiedType: const FullType(String),
    );
    yield r'last_mentioned';
    yield serializers.serialize(
      object.lastMentioned,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ContextualInsight object, {
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
    required ContextualInsightBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'insight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.insight = valueDes;
          break;
        case r'last_mentioned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastMentioned = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContextualInsight deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContextualInsightBuilder();
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
