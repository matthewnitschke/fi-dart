import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account.sg.g.dart';

abstract class Account implements Built<Account, AccountBuilder> {
  factory Account([void Function(AccountBuilder) updates]) = _$Account;
  Account._();

  String get email;
  
  String get plaidAccessToken;

  static Serializer<Account> get serializer => _$accountSerializer;
}