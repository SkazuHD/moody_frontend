// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_term_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShortTermState extends ShortTermState {
  @override
  final String state;
  @override
  final int lastMentioned;

  factory _$ShortTermState([void Function(ShortTermStateBuilder)? updates]) =>
      (ShortTermStateBuilder()..update(updates))._build();

  _$ShortTermState._({required this.state, required this.lastMentioned})
    : super._();
  @override
  ShortTermState rebuild(void Function(ShortTermStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShortTermStateBuilder toBuilder() => ShortTermStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShortTermState &&
        state == other.state &&
        lastMentioned == other.lastMentioned;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, lastMentioned.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShortTermState')
          ..add('state', state)
          ..add('lastMentioned', lastMentioned))
        .toString();
  }
}

class ShortTermStateBuilder
    implements Builder<ShortTermState, ShortTermStateBuilder> {
  _$ShortTermState? _$v;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  int? _lastMentioned;
  int? get lastMentioned => _$this._lastMentioned;
  set lastMentioned(int? lastMentioned) =>
      _$this._lastMentioned = lastMentioned;

  ShortTermStateBuilder() {
    ShortTermState._defaults(this);
  }

  ShortTermStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _lastMentioned = $v.lastMentioned;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShortTermState other) {
    _$v = other as _$ShortTermState;
  }

  @override
  void update(void Function(ShortTermStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShortTermState build() => _build();

  _$ShortTermState _build() {
    final _$result =
        _$v ??
        _$ShortTermState._(
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'ShortTermState',
            'state',
          ),
          lastMentioned: BuiltValueNullFieldError.checkNotNull(
            lastMentioned,
            r'ShortTermState',
            'lastMentioned',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
