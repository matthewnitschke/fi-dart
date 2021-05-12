import 'package:fi/src/utils.dart';

class AddBorrowAction {
  final String borrowId;

  final String fromId;
  final String toId;
  final double amount;

  AddBorrowAction(
    this.fromId,
    this.toId,
    this.amount,
  ) : borrowId = newUuid();
}