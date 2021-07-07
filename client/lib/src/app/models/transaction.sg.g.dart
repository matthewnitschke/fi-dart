// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Transaction> _$transactionSerializer = new _$TransactionSerializer();

class _$TransactionSerializer implements StructuredSerializer<Transaction> {
  @override
  final Iterable<Type> types = const [Transaction, _$Transaction];
  @override
  final String wireName = 'Transaction';

  @override
  Iterable<Object> serialize(Serializers serializers, Transaction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
    ];
    if (object.merchant != null) {
      result
        ..add('merchant')
        ..add(serializers.serialize(object.merchant,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Transaction deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'merchant':
          result.merchant = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Transaction extends Transaction {
  @override
  final double amount;
  @override
  final String merchant;
  @override
  final String name;
  @override
  final DateTime date;

  factory _$Transaction([void Function(TransactionBuilder) updates]) =>
      (new TransactionBuilder()..update(updates)).build();

  _$Transaction._({this.amount, this.merchant, this.name, this.date})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('Transaction', 'amount');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Transaction', 'name');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Transaction', 'date');
    }
  }

  @override
  Transaction rebuild(void Function(TransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionBuilder toBuilder() => new TransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
        amount == other.amount &&
        merchant == other.merchant &&
        name == other.name &&
        date == other.date;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, amount.hashCode), merchant.hashCode), name.hashCode),
        date.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Transaction')
          ..add('amount', amount)
          ..add('merchant', merchant)
          ..add('name', name)
          ..add('date', date))
        .toString();
  }
}

class TransactionBuilder implements Builder<Transaction, TransactionBuilder> {
  _$Transaction _$v;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _merchant;
  String get merchant => _$this._merchant;
  set merchant(String merchant) => _$this._merchant = merchant;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  TransactionBuilder();

  TransactionBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _merchant = _$v.merchant;
      _name = _$v.name;
      _date = _$v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Transaction other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Transaction;
  }

  @override
  void update(void Function(TransactionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Transaction build() {
    final _$result = _$v ??
        new _$Transaction._(
            amount: amount, merchant: merchant, name: name, date: date);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
