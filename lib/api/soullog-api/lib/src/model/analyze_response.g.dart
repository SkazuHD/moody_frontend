// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_happy =
    const AnalyzeResponseMoodEnum._('happy');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_sad =
    const AnalyzeResponseMoodEnum._('sad');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_calm =
    const AnalyzeResponseMoodEnum._('calm');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_fearful =
    const AnalyzeResponseMoodEnum._('fearful');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_angry =
    const AnalyzeResponseMoodEnum._('angry');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_disgust =
    const AnalyzeResponseMoodEnum._('disgust');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_neutral =
    const AnalyzeResponseMoodEnum._('neutral');
const AnalyzeResponseMoodEnum _$analyzeResponseMoodEnum_suprised =
    const AnalyzeResponseMoodEnum._('suprised');

AnalyzeResponseMoodEnum _$analyzeResponseMoodEnumValueOf(String name) {
  switch (name) {
    case 'happy':
      return _$analyzeResponseMoodEnum_happy;
    case 'sad':
      return _$analyzeResponseMoodEnum_sad;
    case 'calm':
      return _$analyzeResponseMoodEnum_calm;
    case 'fearful':
      return _$analyzeResponseMoodEnum_fearful;
    case 'angry':
      return _$analyzeResponseMoodEnum_angry;
    case 'disgust':
      return _$analyzeResponseMoodEnum_disgust;
    case 'neutral':
      return _$analyzeResponseMoodEnum_neutral;
    case 'suprised':
      return _$analyzeResponseMoodEnum_suprised;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AnalyzeResponseMoodEnum> _$analyzeResponseMoodEnumValues =
    BuiltSet<AnalyzeResponseMoodEnum>(const <AnalyzeResponseMoodEnum>[
      _$analyzeResponseMoodEnum_happy,
      _$analyzeResponseMoodEnum_sad,
      _$analyzeResponseMoodEnum_calm,
      _$analyzeResponseMoodEnum_fearful,
      _$analyzeResponseMoodEnum_angry,
      _$analyzeResponseMoodEnum_disgust,
      _$analyzeResponseMoodEnum_neutral,
      _$analyzeResponseMoodEnum_suprised,
    ]);

Serializer<AnalyzeResponseMoodEnum> _$analyzeResponseMoodEnumSerializer =
    _$AnalyzeResponseMoodEnumSerializer();

class _$AnalyzeResponseMoodEnumSerializer
    implements PrimitiveSerializer<AnalyzeResponseMoodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'happy': 'happy',
    'sad': 'sad',
    'calm': 'calm',
    'fearful': 'fearful',
    'angry': 'angry',
    'disgust': 'disgust',
    'neutral': 'neutral',
    'suprised': 'suprised',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'happy': 'happy',
    'sad': 'sad',
    'calm': 'calm',
    'fearful': 'fearful',
    'angry': 'angry',
    'disgust': 'disgust',
    'neutral': 'neutral',
    'suprised': 'suprised',
  };

  @override
  final Iterable<Type> types = const <Type>[AnalyzeResponseMoodEnum];
  @override
  final String wireName = 'AnalyzeResponseMoodEnum';

  @override
  Object serialize(
    Serializers serializers,
    AnalyzeResponseMoodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AnalyzeResponseMoodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AnalyzeResponseMoodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AnalyzeResponse extends AnalyzeResponse {
  @override
  final AnalyzeResponseMoodEnum mood;
  @override
  final BuiltList<JsonObject?> recommendations;
  @override
  final String quote;
  @override
  final Persona personality;

  factory _$AnalyzeResponse([void Function(AnalyzeResponseBuilder)? updates]) =>
      (AnalyzeResponseBuilder()..update(updates))._build();

  _$AnalyzeResponse._({
    required this.mood,
    required this.recommendations,
    required this.quote,
    required this.personality,
  }) : super._();
  @override
  AnalyzeResponse rebuild(void Function(AnalyzeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnalyzeResponseBuilder toBuilder() => AnalyzeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnalyzeResponse &&
        mood == other.mood &&
        recommendations == other.recommendations &&
        quote == other.quote &&
        personality == other.personality;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mood.hashCode);
    _$hash = $jc(_$hash, recommendations.hashCode);
    _$hash = $jc(_$hash, quote.hashCode);
    _$hash = $jc(_$hash, personality.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnalyzeResponse')
          ..add('mood', mood)
          ..add('recommendations', recommendations)
          ..add('quote', quote)
          ..add('personality', personality))
        .toString();
  }
}

class AnalyzeResponseBuilder
    implements Builder<AnalyzeResponse, AnalyzeResponseBuilder> {
  _$AnalyzeResponse? _$v;

  AnalyzeResponseMoodEnum? _mood;
  AnalyzeResponseMoodEnum? get mood => _$this._mood;
  set mood(AnalyzeResponseMoodEnum? mood) => _$this._mood = mood;

  ListBuilder<JsonObject?>? _recommendations;
  ListBuilder<JsonObject?> get recommendations =>
      _$this._recommendations ??= ListBuilder<JsonObject?>();
  set recommendations(ListBuilder<JsonObject?>? recommendations) =>
      _$this._recommendations = recommendations;

  String? _quote;
  String? get quote => _$this._quote;
  set quote(String? quote) => _$this._quote = quote;

  PersonaBuilder? _personality;
  PersonaBuilder get personality => _$this._personality ??= PersonaBuilder();
  set personality(PersonaBuilder? personality) =>
      _$this._personality = personality;

  AnalyzeResponseBuilder() {
    AnalyzeResponse._defaults(this);
  }

  AnalyzeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mood = $v.mood;
      _recommendations = $v.recommendations.toBuilder();
      _quote = $v.quote;
      _personality = $v.personality.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnalyzeResponse other) {
    _$v = other as _$AnalyzeResponse;
  }

  @override
  void update(void Function(AnalyzeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnalyzeResponse build() => _build();

  _$AnalyzeResponse _build() {
    _$AnalyzeResponse _$result;
    try {
      _$result =
          _$v ??
          _$AnalyzeResponse._(
            mood: BuiltValueNullFieldError.checkNotNull(
              mood,
              r'AnalyzeResponse',
              'mood',
            ),
            recommendations: recommendations.build(),
            quote: BuiltValueNullFieldError.checkNotNull(
              quote,
              r'AnalyzeResponse',
              'quote',
            ),
            personality: personality.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recommendations';
        recommendations.build();

        _$failedField = 'personality';
        personality.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AnalyzeResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
