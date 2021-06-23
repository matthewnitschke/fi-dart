import 'package:built_value/built_value.dart';

part 'bank_account.sg.g.dart';

abstract class BankAccount implements Built<BankAccount, BankAccountBuilder> {
  factory BankAccount([void Function(BankAccountBuilder) updates]) = _$BankAccount;
  BankAccount._();
}