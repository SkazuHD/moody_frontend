// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_response_fast_checkin.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_happy =
    const AnalyzeResponseFastCheckinMoodEnum._('happy');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_sad =
    const AnalyzeResponseFastCheckinMoodEnum._('sad');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_calm =
    const AnalyzeResponseFastCheckinMoodEnum._('calm');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_fearful =
    const AnalyzeResponseFastCheckinMoodEnum._('fearful');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_angry =
    const AnalyzeResponseFastCheckinMoodEnum._('angry');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_disgust =
    const AnalyzeResponseFastCheckinMoodEnum._('disgust');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_neutral =
    const AnalyzeResponseFastCheckinMoodEnum._('neutral');
const AnalyzeResponseFastCheckinMoodEnum
    _$analyzeResponseFastCheckinMoodEnum_surprised =
    const AnalyzeResponseFastCheckinMoodEnum._('surprised');

AnalyzeResponseFastCheckinMoodEnum _$analyzeResponseFastCheckinMoodEnumValueOf(
    String name) {
  switch (name) {
    case 'happy':
      return _$analyzeResponseFastCheckinMoodEnum_happy;
    case 'sad':
      return _$analyzeResponseFastCheckinMoodEnum_sad;
    case 'calm':
      return _$analyzeResponseFastCheckinMoodEnum_calm;
    case 'fearful':
      return _$analyzeResponseFastCheckinMoodEnum_fearful;
    case 'angry':
      return _$analyzeResponseFastCheckinMoodEnum_angry;
    case 'disgust':
      return _$analyzeResponseFastCheckinMoodEnum_disgust;
    case 'neutral':
      return _$analyzeResponseFastCheckinMoodEnum_neutral;
    case 'surprised':
      return _$analyzeResponseFastCheckinMoodEnum_surprised;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AnalyzeResponseFastCheckinMoodEnum>
    _$analyzeResponseFastCheckinMoodEnumValues = BuiltSet<
        AnalyzeResponseFastCheckinMoodEnum>(const <AnalyzeResponseFastCheckinMoodEnum>[
  _$analyzeResponseFastCheckinMoodEnum_happy,
  _$analyzeResponseFastCheckinMoodEnum_sad,
  _$analyzeResponseFastCheckinMoodEnum_calm,
  _$analyzeResponseFastCheckinMoodEnum_fearful,
  _$analyzeResponseFastCheckinMoodEnum_angry,
  _$analyzeResponseFastCheckinMoodEnum_disgust,
  _$analyzeResponseFastCheckinMoodEnum_neutral,
  _$analyzeResponseFastCheckinMoodEnum_surprised,
]);

Serializer<AnalyzeResponseFastCheckinMoodEnum>
    _$analyzeResponseFastCheckinMoodEnumSerializer =
    _$AnalyzeResponseFastCheckinMoodEnumSerializer();

class _$AnalyzeResponseFastCheckinMoodEnumSerializer
    implements PrimitiveSerializer<AnalyzeResponseFastCheckinMoodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'happy': 'happy',
    'sad': 'sad',
    'calm': 'calm',
    'fearful': 'fearful',
    'angry': 'angry',
    'disgust': 'disgust',
    'neutral': 'neutral',
    'surprised': 'surprised',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'happy': 'happy',
    'sad': 'sad',
    'calm': 'calm',
    'fearful': 'fearful',
    'angry': 'angry',
    'disgust': 'disgust',
    'neutral': 'neutral',
    'surprised': 'surprised',
  };

  @override
  final Iterable<Type> types = const <Type>[AnalyzeResponseFastCheckinMoodEnum];
  @override
  final String wireName = 'AnalyzeResponseFastCheckinMoodEnum';

  @override
  Object serialize(
          Serializers serializers, AnalyzeResponseFastCheckinMoodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AnalyzeResponseFastCheckinMoodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AnalyzeResponseFastCheckinMoodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AnalyzeResponseFastCheckin extends AnalyzeResponseFastCheckin {
  @override
  final AnalyzeResponseFastCheckinMoodEnum mood;
  @override
  final BuiltList<String> recommendations;
  @override
  final String quote;

  factory _$AnalyzeResponseFastCheckin(
          [void Function(AnalyzeResponseFastCheckinBuilder)? updates]) =>
      (AnalyzeResponseFastCheckinBuilder()..update(updates))._build();

  _$AnalyzeResponseFastCheckin._(
      {required this.mood, required this.recommendations, required this.quote})
      : super._();
  @override
  AnalyzeResponseFastCheckin rebuild(
          void Function(AnalyzeResponseFastCheckinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnalyzeResponseFastCheckinBuilder toBuilder() =>
      AnalyzeResponseFastCheckinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnalyzeResponseFastCheckin &&
        mood == other.mood &&
        recommendations == other.recommendations &&
        quote == other.quote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mood.hashCode);
    _$hash = $jc(_$hash, recommendations.hashCode);
    _$hash = $jc(_$hash, quote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnalyzeResponseFastCheckin')
          ..add('mood', mood)
          ..add('recommendations', recommendations)
          ..add('quote', quote))
        .toString();
  }
}

class AnalyzeResponseFastCheckinBuilder
    implements
        Builder<AnalyzeResponseFastCheckin, AnalyzeResponseFastCheckinBuilder> {
  _$AnalyzeResponseFastCheckin? _$v;

  AnalyzeResponseFastCheckinMoodEnum? _mood;
  AnalyzeResponseFastCheckinMoodEnum? get mood => _$this._mood;
  set mood(AnalyzeResponseFastCheckinMoodEnum? mood) => _$this._mood = mood;

  ListBuilder<String>? _recommendations;
  ListBuilder<String> get recommendations =>
      _$this._recommendations ??= ListBuilder<String>();
  set recommendations(ListBuilder<String>? recommendations) =>
      _$this._recommendations = recommendations;

  String? _quote;
  String? get quote => _$this._quote;
  set quote(String? quote) => _$this._quote = quote;

  AnalyzeResponseFastCheckinBuilder() {
    AnalyzeResponseFastCheckin._defaults(this);
  }

  AnalyzeResponseFastCheckinBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mood = $v.mood;
      _recommendations = $v.recommendations.toBuilder();
      _quote = $v.quote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnalyzeResponseFastCheckin other) {
    _$v = other as _$AnalyzeResponseFastCheckin;
  }

  @override
  void update(void Function(AnalyzeResponseFastCheckinBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnalyzeResponseFastCheckin build() => _build();

  _$AnalyzeResponseFastCheckin _build() {
    _$AnalyzeResponseFastCheckin _$result;
    try {
      _$result = _$v ??
          _$AnalyzeResponseFastCheckin._(
            mood: BuiltValueNullFieldError.checkNotNull(
                mood, r'AnalyzeResponseFastCheckin', 'mood'),
            recommendations: recommendations.build(),
            quote: BuiltValueNullFieldError.checkNotNull(
                quote, r'AnalyzeResponseFastCheckin', 'quote'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recommendations';
        recommendations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AnalyzeResponseFastCheckin', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
