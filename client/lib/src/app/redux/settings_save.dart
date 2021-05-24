import 'dart:convert';
import 'dart:html';

import 'package:fi/src/app/models/app_state.sg.dart';
import 'package:fi/src/app/models/serializers.sg.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:redux/redux.dart';

Middleware<AppState> settingsSaveMiddleware(
  Store<AppState> store, 
  dynamic action, 
  void Function(dynamic) next,
) {
  final before = store.state;

  next(action);

  final after = store.state;

  if (_haveSettingsChanged(before, after)) {
    window.localStorage['fi-save'] = json.encode(serializers.serialize(store.state));
    // window.localStorage['fi-save_rootItemIds'] = json.encode(serializers.serialize(store.state.rootItemIds));
    // window.localStorage['fi-save_transactions'] = json.encode(serializers.serialize(store.state.transactions));
  }
}

void loadFromLocalStorage(Store<AppState> store) {
  if (window.localStorage.containsKey('fi-save')) {
    store.dispatch(LoadStateAction(
      window.localStorage['fi-save']
      // encodedItems: window.localStorage['fi-save_items'],
      // encodedRootItemIds: window.localStorage['fi-save_rootItemIds'],
      // encodedTransactions: window.localStorage['fi-save_transactions']
    ));
  }
}

bool _haveSettingsChanged(AppState a, AppState b) {
  if (a.items != b.items) return true;
  if (a.transactions != b.transactions) return true;
  if (a.rootItemIds != b.rootItemIds) return true;

  return false;
}