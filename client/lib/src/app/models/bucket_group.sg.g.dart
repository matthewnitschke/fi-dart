// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_group.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BucketGroup> _$bucketGroupSerializer = new _$BucketGroupSerializer();

class _$BucketGroupSerializer implements StructuredSerializer<BucketGroup> {
  @override
  final Iterable<Type> types = const [BucketGroup, _$BucketGroup];
  @override
  final String wireName = 'BucketGroup';

  @override
  Iterable<Object> serialize(Serializers serializers, BucketGroup object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'itemIds',
      serializers.serialize(object.itemIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BucketGroup deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BucketGroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'itemIds':
          result.itemIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BucketGroup extends BucketGroup {
  @override
  final BuiltList<String> itemIds;
  @override
  final String label;

  factory _$BucketGroup([void Function(BucketGroupBuilder) updates]) =>
      (new BucketGroupBuilder()..update(updates)).build();

  _$BucketGroup._({this.itemIds, this.label}) : super._() {
    if (itemIds == null) {
      throw new BuiltValueNullFieldError('BucketGroup', 'itemIds');
    }
    if (label == null) {
      throw new BuiltValueNullFieldError('BucketGroup', 'label');
    }
  }

  @override
  BucketGroup rebuild(void Function(BucketGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BucketGroupBuilder toBuilder() => new BucketGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BucketGroup &&
        itemIds == other.itemIds &&
        label == other.label;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, itemIds.hashCode), label.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BucketGroup')
          ..add('itemIds', itemIds)
          ..add('label', label))
        .toString();
  }
}

class BucketGroupBuilder
    implements Builder<BucketGroup, BucketGroupBuilder>, ItemBuilder {
  _$BucketGroup _$v;

  ListBuilder<String> _itemIds;
  ListBuilder<String> get itemIds =>
      _$this._itemIds ??= new ListBuilder<String>();
  set itemIds(ListBuilder<String> itemIds) => _$this._itemIds = itemIds;

  String _label;
  String get label => _$this._label;
  set label(String label) => _$this._label = label;

  BucketGroupBuilder();

  BucketGroupBuilder get _$this {
    if (_$v != null) {
      _itemIds = _$v.itemIds?.toBuilder();
      _label = _$v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant BucketGroup other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BucketGroup;
  }

  @override
  void update(void Function(BucketGroupBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BucketGroup build() {
    _$BucketGroup _$result;
    try {
      _$result =
          _$v ?? new _$BucketGroup._(itemIds: itemIds.build(), label: label);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'itemIds';
        itemIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BucketGroup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
