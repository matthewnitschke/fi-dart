import 'package:built_collection/built_collection.dart';
import 'package:fi/src/components/app.dart';
import 'package:fi/src/redux/items/items.reducer.dart';
import 'package:fi/src/redux/root/root.reducer.dart';
import 'package:fi/src/redux/settings_save.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

import 'models/app_state.sg.dart';
import 'models/transaction.sg.dart';

class FiModule {

  Store<AppState> _store;

  FiModule() {

    final rootReducer = RootReducer().reducer;
    final itemsReducer = ItemsReducer().reducer;

    _store = Store<AppState>(
      (state, action) {
        final rootState = rootReducer(state, action);
        return rootState.rebuild((b) => b
          ..items = itemsReducer(rootState.items, action).toBuilder()
        );
      },
      initialState: AppState((b) => b
        ..selectedMonth = DateTime.now().toUtc()
        ..transactions = MapBuilder<String, Transaction>({
          'a': Transaction((tb) => tb
            ..date = DateTime.now().toUtc()
            ..merchant = 'Fellow'
            ..amount = -299
          ),
          'b': Transaction((tb) => tb
            ..date = DateTime.now().subtract(Duration(days: 2)).toUtc()
            ..merchant = 'Apple'
            ..amount = -100
          ),
          'c': Transaction((tb) => tb
            ..date = DateTime.now().subtract(Duration(days: 2)).toUtc()
            ..merchant = 'Faith'
            ..amount = 100
          )
        })
      ),
      middleware: [
        settingsSaveMiddleware,
      ],
    );

    loadFromLocalStorage(_store);

    // _store.dispatch(AddBucketAction(label: 'Something', itemId: 'a'));
    // _store.dispatch(SelectItemAction('a'));

  }

  Object content() {
    return (ReduxProvider()
      ..store = _store
    )(App()());
  }
}