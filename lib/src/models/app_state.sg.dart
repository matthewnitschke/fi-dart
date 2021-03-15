import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:fi/src/models/item.sg.dart';

part 'app_state.sg.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  DateTime get selectedMonth;

  BuiltMap<String, Item> get items;
  
  BuiltList<String> get rootItemIds;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}