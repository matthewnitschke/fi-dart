import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:fi/src/models/borrow.sg.dart';
import 'package:fi/src/redux/borrows/borrows.actions.dart';
import 'package:redux/redux.dart';

class BorrowsReducer {

  BorrowsReducer();

  Reducer<BuiltMap<String, Borrow>> get reducer => combineReducers([
    TypedReducer<BuiltMap<String, Borrow>, AddBorrowAction>(_onAddBorrow),
  ]);

  BuiltMap<String, Borrow> _onAddBorrow(BuiltMap<String, Borrow> state, AddBorrowAction action) {
    return state.rebuild((b) => b
      ..[action.borrowId] = Borrow((bb) => bb
        ..fromId = action.fromId
        ..toId = action.toId
        ..amount = action.amount
      )
    );
  }
}