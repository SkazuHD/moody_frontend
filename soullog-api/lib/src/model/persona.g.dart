// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Persona extends Persona {
  @override
  final BuiltList<String> longTermTraits;
  @override
  final BuiltList<ShortTermState> shortTermStates;
  @override
  final BuiltList<ContextualInsight> contextualInsights;

  factory _$Persona([void Function(PersonaBuilder)? updates]) =>
      (PersonaBuilder()..update(updates))._build();

  _$Persona._(
      {required this.longTermTraits,
      required this.shortTermStates,
      required this.contextualInsights})
      : super._();
  @override
  Persona rebuild(void Function(PersonaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PersonaBuilder toBuilder() => PersonaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Persona &&
        longTermTraits == other.longTermTraits &&
        shortTermStates == other.shortTermStates &&
        contextualInsights == other.contextualInsights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, longTermTraits.hashCode);
    _$hash = $jc(_$hash, shortTermStates.hashCode);
    _$hash = $jc(_$hash, contextualInsights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Persona')
          ..add('longTermTraits', longTermTraits)
          ..add('shortTermStates', shortTermStates)
          ..add('contextualInsights', contextualInsights))
        .toString();
  }
}

class PersonaBuilder implements Builder<Persona, PersonaBuilder> {
  _$Persona? _$v;

  ListBuilder<String>? _longTermTraits;
  ListBuilder<String> get longTermTraits =>
      _$this._longTermTraits ??= ListBuilder<String>();
  set longTermTraits(ListBuilder<String>? longTermTraits) =>
      _$this._longTermTraits = longTermTraits;

  ListBuilder<ShortTermState>? _shortTermStates;
  ListBuilder<ShortTermState> get shortTermStates =>
      _$this._shortTermStates ??= ListBuilder<ShortTermState>();
  set shortTermStates(ListBuilder<ShortTermState>? shortTermStates) =>
      _$this._shortTermStates = shortTermStates;

  ListBuilder<ContextualInsight>? _contextualInsights;
  ListBuilder<ContextualInsight> get contextualInsights =>
      _$this._contextualInsights ??= ListBuilder<ContextualInsight>();
  set contextualInsights(ListBuilder<ContextualInsight>? contextualInsights) =>
      _$this._contextualInsights = contextualInsights;

  PersonaBuilder() {
    Persona._defaults(this);
  }

  PersonaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _longTermTraits = $v.longTermTraits.toBuilder();
      _shortTermStates = $v.shortTermStates.toBuilder();
      _contextualInsights = $v.contextualInsights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Persona other) {
    _$v = other as _$Persona;
  }

  @override
  void update(void Function(PersonaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Persona build() => _build();

  _$Persona _build() {
    _$Persona _$result;
    try {
      _$result = _$v ??
          _$Persona._(
            longTermTraits: longTermTraits.build(),
            shortTermStates: shortTermStates.build(),
            contextualInsights: contextualInsights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'longTermTraits';
        longTermTraits.build();
        _$failedField = 'shortTermStates';
        shortTermStates.build();
        _$failedField = 'contextualInsights';
        contextualInsights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Persona', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
