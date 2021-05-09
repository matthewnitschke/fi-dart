import 'package:built_collection/built_collection.dart';
import 'package:fi/src/components/app.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/models/bucket_value.sg.dart';
import 'package:fi/src/models/item.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/redux/items/items.reducer.dart';
import 'package:fi/src/redux/root/root.actions.dart';
import 'package:fi/src/redux/root/root.reducer.dart';
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
        ..selectedMonth = DateTime.now()
        ..transactions = MapBuilder<String, Transaction>({
          'a': Transaction((tb) => tb
            ..date = DateTime.now()
            ..merchant = 'Fellow'
            ..amount = -299
          ),
          'b': Transaction((tb) => tb
            ..date = DateTime.now().subtract(Duration(days: 2))
            ..merchant = 'Apple'
            ..amount = -100
          ),
          'c': Transaction((tb) => tb
            ..date = DateTime.now().subtract(Duration(days: 2))
            ..merchant = 'Faith'
            ..amount = 100
          )
        })
      ),
      middleware: [],
    );

    // _store.dispatch(AddBucketAction(label: 'Something', itemId: 'a'));
    // _store.dispatch(SelectItemAction('a'));

  }

  Object content() {
    return (ReduxProvider()
      ..store = _store
    )(App()());
  }
}