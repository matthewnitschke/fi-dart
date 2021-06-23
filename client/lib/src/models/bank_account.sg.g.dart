// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BankAccount extends BankAccount {
  factory _$BankAccount([void Function(BankAccountBuilder) updates]) =>
      (new BankAccountBuilder()..update(updates)).build();

  _$BankAccount._() : super._();

  @override
  BankAccount rebuild(void Function(BankAccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountBuilder toBuilder() => new BankAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccount;
  }

  @override
  int get hashCode {
    return 40755993;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('BankAccount').toString();
  }
}

class BankAccountBuilder implements Builder<BankAccount, BankAccountBuilder> {
  _$BankAccount _$v;

  BankAccountBuilder();

  @override
  void replace(BankAccount other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BankAccount;
  }

  @override
  void update(void Function(BankAccountBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BankAccount build() {
    final _$result = _$v ?? new _$BankAccount._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
