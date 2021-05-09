import 'package:fi/src/models/app_state.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/redux/root/root.actions.dart';
import 'package:redux/redux.dart';

class RootReducer {
  RootReducer();

  Reducer<AppState> get reducer => combineReducers([
    TypedReducer<AppState, AddBucketGroupAction>(_onAddBucketGroup),
    TypedReducer<AppState, AddBucketAction>(_onAddBucket),
    TypedReducer<AppState, SelectItemAction>(_onSelectItem),
  ]);

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