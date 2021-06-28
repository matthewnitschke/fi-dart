import 'package:built_collection/built_collection.dart';
import 'package:fi/src/app/models/borrow.sg.dart';
import 'package:fi/src/app/models/item.sg.dart';
import 'package:fi/src/app/models/transaction.sg.dart';

class LoadStateAction {
  final BuiltMap<String, Item> items;
  final BuiltList<String> rootItemIds;
  final BuiltMap<String, Borrow> borrows;
  final BuiltMap<String, Transaction> transactions;

  LoadStateAction({
    this.items,
    this.rootItemIds,
    this.borrows,
    this.transactions,
  });
}

class SelectItemAction {
  final String itemId;
  
  SelectItemAction(this.itemId);
}