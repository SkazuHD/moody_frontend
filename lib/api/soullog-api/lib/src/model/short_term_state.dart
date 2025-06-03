//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'short_term_state.g.dart';

/// ShortTermState
///
/// Properties:
/// * [state] - A time-sensitive feeling or event.
/// * [lastMentioned] - Number of diary entries since last mention.
@BuiltValue()
abstract class ShortTermState
    implements Built<ShortTermState, ShortTermStateBuilder> {
  /// A time-sensitive feeling or event.
  @BuiltValueField(wireName: r'state')
  String get state;

  /// Number of diary entries since last mention.
  @BuiltValueField(wireName: r'last_mentioned')
  int get lastMentioned;

  ShortTermState._();

  factory ShortTermState([void updates(ShortTermStateBuilder b)]) =
      _$ShortTermState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShortTermStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ShortTermState> get serializer =>
      _$ShortTermStateSerializer();
}

class _$ShortTermStateSerializer
    implements PrimitiveSerializer<ShortTermState> {
  @override
  final Iterable<Type> types = const [ShortTermState, _$ShortTermState];

  @override
  final String wireName = r'ShortTermState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ShortTermState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'state';
    yield serializers.serialize(
      object.state,
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
    ShortTermState object, {
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
    required ShortTermStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
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
  ShortTermState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShortTermStateBuilder();
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
