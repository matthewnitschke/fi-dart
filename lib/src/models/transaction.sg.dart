import 'package:built_value/built_value.dart';

part 'transaction.sg.g.dart';

abstract class Transaction implements Built<Transaction, TransactionBuilder> {
  double get amount;
  String get merchant;
  DateTime get date;

  factory Transaction([void Function(TransactionBuilder) updates]) = _$Transaction;
  Transaction._();
}