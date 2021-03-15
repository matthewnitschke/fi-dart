import 'package:fi/src/components/app.dart';
import 'package:fi/src/redux/items/items.reducer.dart';
import 'package:fi/src/redux/root/root.reducer.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

import 'models/app_state.sg.dart';

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
      ),
      middleware: [],
    );

  }

  Object content() {
    return (ReduxProvider()
      ..store = _store
    )(App()());
  }
}