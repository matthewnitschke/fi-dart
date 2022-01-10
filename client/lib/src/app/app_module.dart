import 'package:built_collection/built_collection.dart';
import 'package:fi/src/app/components/app.dart';
import 'package:fi/src/app/redux/borrows/borrows.reducer.dart';
import 'package:fi/src/app/redux/items/items.reducer.dart';
import 'package:fi/src/app/redux/root/root.reducer.dart';
import 'package:fi/src/app/redux/settings_save.dart';
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
          ..borrows = borrowsReducer(rootState.borrows, action).toBuilder());
      },
      initialState: AppState((b) => b
        ..selectedMonth = DateTime.now().toUtc()
        ..transactions = MapBuilder<String, Transaction>()),
      middleware: [
        settingsSaveMiddleware,
      ],
    );

    loadFromServer(_store);
  }

  Object content() {
    return (ReduxProvider()..store = _store)(App()());
  }
}
