import 'dart:convert';

import 'package:fi/src/models/app_state.sg.dart';
import 'package:fi/src/models/serializers.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/redux/root/root.actions.dart';
import 'package:redux/redux.dart';

class RootReducer {
  RootReducer();

  Reducer<AppState> get reducer => combineReducers([
    TypedReducer<AppState, LoadStateAction>(_onLoadState),
    TypedReducer<AppState, AddBucketGroupAction>(_onAddBucketGroup),
    TypedReducer<AppState, AddBucketAction>(_onAddBucket),
    TypedReducer<AppState, DeleteItemAction>(_onDeleteItem),
    TypedReducer<AppState, SelectItemAction>(_onSelectItem),
  ]);

  AppState _onLoadState(AppState state, LoadStateAction action) {
    return serializers.deserializeWith(AppState.serializer, json.decode(action.encodedState));
  }

  AppState _onAddBucketGroup(AppState state, AddBucketGroupAction action) {
    return state.rebuild((b) => b
      ..rootItemIds.add(action.itemId)
    );
  }

  AppState _onAddBucket(AppState state, AddBucketAction action) {
    if (action.parentId == null) {
      return state.rebuild((b) => b
        ..rootItemIds.add(action.itemId)
      );
    }

    return state;
  }

  AppState _onDeleteItem(AppState state, DeleteItemAction action) {
    final stateBuilder = state.toBuilder();

    stateBuilder.items.remove(action.itemId);

    if (state.rootItemIds.contains(action.itemId)) {
      stateBuilder.rootItemIds.remove(action.itemId);
    }

    if (state.selectedItemId == action.itemId) {
      stateBuilder.selectedItemId = null;
    }

    return stateBuilder.build();
  }

  AppState _onSelectItem(AppState state, SelectItemAction action) {
    var itemId = action.itemId;

    // if we are trying to select the same item, toggle it off
    if (state.selectedItemId == itemId) {
      itemId = null;
    }

    return state.rebuild((b) => b
      ..selectedItemId = action.itemId
    );
  }
}