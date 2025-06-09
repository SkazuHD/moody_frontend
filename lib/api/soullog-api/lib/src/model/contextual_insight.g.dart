// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contextual_insight.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContextualInsight extends ContextualInsight {
  @override
  final String insight;
  @override
  final int lastMentioned;

  factory _$ContextualInsight([
    void Function(ContextualInsightBuilder)? updates,
  ]) =>
      (ContextualInsightBuilder()..update(updates))._build();

  _$ContextualInsight._({required this.insight, required this.lastMentioned})
      : super._();
  @override
  ContextualInsight rebuild(void Function(ContextualInsightBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContextualInsightBuilder toBuilder() =>
      ContextualInsightBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContextualInsight &&
        insight == other.insight &&
        lastMentioned == other.lastMentioned;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, insight.hashCode);
    _$hash = $jc(_$hash, lastMentioned.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContextualInsight')
          ..add('insight', insight)
          ..add('lastMentioned', lastMentioned))
        .toString();
  }
}

class ContextualInsightBuilder
    implements Builder<ContextualInsight, ContextualInsightBuilder> {
  _$ContextualInsight? _$v;

  String? _insight;
  String? get insight => _$this._insight;
  set insight(String? insight) => _$this._insight = insight;

  int? _lastMentioned;
  int? get lastMentioned => _$this._lastMentioned;
  set lastMentioned(int? lastMentioned) =>
      _$this._lastMentioned = lastMentioned;

  ContextualInsightBuilder() {
    ContextualInsight._defaults(this);
  }

  ContextualInsightBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _insight = $v.insight;
      _lastMentioned = $v.lastMentioned;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContextualInsight other) {
    _$v = other as _$ContextualInsight;
  }

  @override
  void update(void Function(ContextualInsightBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContextualInsight build() => _build();

  _$ContextualInsight _build() {
    final _$result = _$v ??
        _$ContextualInsight._(
          insight: BuiltValueNullFieldError.checkNotNull(
            insight,
            r'ContextualInsight',
            'insight',
          ),
          lastMentioned: BuiltValueNullFieldError.checkNotNull(
            lastMentioned,
            r'ContextualInsight',
            'lastMentioned',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
