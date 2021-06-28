import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction.sg.g.dart';

abstract class Transaction implements Built<Transaction, TransactionBuilder> {
  double get amount;

  @nullable
  String get merchant;

  DateTime get date;

  static Serializer<Transaction> get serializer => _$transactionSerializer;

  factory Transaction([void Function(TransactionBuilder) updates]) = _$Transaction;
  Transaction._();
}