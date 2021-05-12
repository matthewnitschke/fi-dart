import 'package:built_collection/built_collection.dart';
import 'package:fi/src/components/app.dart';
import 'package:fi/src/models/borrow.sg.dart';
import 'package:fi/src/redux/borrows/borrows.reducer.dart';
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
    final borrowsReducer = BorrowsReducer().reducer;

    _store = Store<AppState>(
      (state, action) {
        final rootState = rootReducer(state, action);
        return rootState.rebuild((b) => b
          ..items = itemsReducer(rootState.items, action).toBuilder()
          ..borrows = borrowsReducer(rootState.borrows, action).toBuilder()
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
        ..borrows = MapBuilder<String, Borrow>({
          'z': Borrow((bb) => bb
            ..amount = 13
            ..fromId = '2f58bb39-e9c9-44ec-aa7e-3435bdb2f417'
            ..toId = '3041dcd2-a3a7-451a-8ac7-0e9d93766270'
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