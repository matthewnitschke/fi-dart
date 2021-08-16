import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fi/src/app/models/borrow.sg.dart';
import 'package:fi/src/app/models/item.sg.dart';
import 'package:fi/src/app/models/transaction.sg.dart';

part 'app_state.sg.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  DateTime get selectedMonth;

  @nullable
  @BuiltValueField(serialize: false)
  bool get isDraggingTransaction;

  @nullable
  String get selectedItemId;

  BuiltMap<String, Item> get items;
  
  BuiltList<String> get rootItemIds;

  @nullable
  @BuiltValueField(serialize: false)
  BuiltMap<String, Transaction> get transactions;

  BuiltSet<String> get ignoredTransactions;

  BuiltMap<String, Borrow> get borrows;

  static Serializer<AppState> get serializer => _$appStateSerializer;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}