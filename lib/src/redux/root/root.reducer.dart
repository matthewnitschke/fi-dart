import 'package:fi/src/models/app_state.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:redux/redux.dart';

class RootReducer {
  RootReducer();

  Reducer<AppState> get reducer => combineReducers([
    TypedReducer<AppState, AddBucketGroupAction>(_onAddBucketGroup),
    TypedReducer<AppState, AddBucketAction>(_onAddBucket),
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
}