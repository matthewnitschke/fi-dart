import 'package:fi/src/app/utils.dart';

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