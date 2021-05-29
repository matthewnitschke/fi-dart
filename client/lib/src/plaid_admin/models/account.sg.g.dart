// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Account> _$accountSerializer = new _$AccountSerializer();

class _$AccountSerializer implements StructuredSerializer<Account> {
  @override
  final Iterable<Type> types = const [Account, _$Account];
  @override
  final String wireName = 'Account';

  @override
  Iterable<Object> serialize(Serializers serializers, Account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'plaidAccessToken',
      serializers.serialize(object.plaidAccessToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Account deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plaidAccessToken':
          result.plaidAccessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Account extends Account {
  @override
  final String email;
  @override
  final String plaidAccessToken;

  factory _$Account([void Function(AccountBuilder) updates]) =>
      (new AccountBuilder()..update(updates)).build();

  _$Account._({this.email, this.plaidAccessToken}) : super._() {
    if (email == null) {
      throw new BuiltValueNullFieldError('Account', 'email');
    }
    if (plaidAccessToken == null) {
      throw new BuiltValueNullFieldError('Account', 'plaidAccessToken');
    }
  }

  @override
  Account rebuild(void Function(AccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBuilder toBuilder() => new AccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Account &&
        email == other.email &&
        plaidAccessToken == other.plaidAccessToken;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, email.hashCode), plaidAccessToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Account')
          ..add('email', email)
          ..add('plaidAccessToken', plaidAccessToken))
        .toString();
  }
}

class AccountBuilder implements Builder<Account, AccountBuilder> {
  _$Account _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _plaidAccessToken;
  String get plaidAccessToken => _$this._plaidAccessToken;
  set plaidAccessToken(String plaidAccessToken) =>
      _$this._plaidAccessToken = plaidAccessToken;

  AccountBuilder();

  AccountBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _plaidAccessToken = _$v.plaidAccessToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Account other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Account;
  }

  @override
  void update(void Function(AccountBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Account build() {
    final _$result = _$v ??
        new _$Account._(email: email, plaidAccessToken: plaidAccessToken);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
