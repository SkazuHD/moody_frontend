//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
// ignore_for_file: unused_element
import 'package:soullog_api/src/model/contextual_insight.dart';
import 'package:soullog_api/src/model/short_term_state.dart';

part 'persona.g.dart';

/// Persona
///
/// Properties:
/// * [longTermTraits] - Stable personality traits, values, and preferences.
/// * [shortTermStates] - Recent emotional or situational states.
/// * [contextualInsights] - Commonly referenced people, themes, or objects.
@BuiltValue()
abstract class Persona implements Built<Persona, PersonaBuilder> {
  /// Stable personality traits, values, and preferences.
  @BuiltValueField(wireName: r'long_term_traits')
  BuiltList<String> get longTermTraits;

  /// Recent emotional or situational states.
  @BuiltValueField(wireName: r'short_term_states')
  BuiltList<ShortTermState> get shortTermStates;

  /// Commonly referenced people, themes, or objects.
  @BuiltValueField(wireName: r'contextual_insights')
  BuiltList<ContextualInsight> get contextualInsights;

  Persona._();

  factory Persona([void updates(PersonaBuilder b)]) = _$Persona;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PersonaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Persona> get serializer => _$PersonaSerializer();
}

class _$PersonaSerializer implements PrimitiveSerializer<Persona> {
  @override
  final Iterable<Type> types = const [Persona, _$Persona];

  @override
  final String wireName = r'Persona';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Persona object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'long_term_traits';
    yield serializers.serialize(
      object.longTermTraits,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'short_term_states';
    yield serializers.serialize(
      object.shortTermStates,
      specifiedType: const FullType(BuiltList, [FullType(ShortTermState)]),
    );
    yield r'contextual_insights';
    yield serializers.serialize(
      object.contextualInsights,
      specifiedType: const FullType(BuiltList, [FullType(ContextualInsight)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Persona object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PersonaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'long_term_traits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.longTermTraits.replace(valueDes);
          break;
        case r'short_term_states':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ShortTermState)]),
          ) as BuiltList<ShortTermState>;
          result.shortTermStates.replace(valueDes);
          break;
        case r'contextual_insights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ContextualInsight)]),
          ) as BuiltList<ContextualInsight>;
          result.contextualInsights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Persona deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PersonaBuilder();
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
