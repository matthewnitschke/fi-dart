import 'dart:convert';
import 'dart:html';

import 'package:fi/src/app/fi-client.dart';
import 'package:fi/src/app/models/app_state.sg.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/serializers.sg.dart';
import 'package:fi/src/app/models/transaction.sg.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:redux/redux.dart';

import 'package:built_collection/built_collection.dart';

Middleware<AppState> settingsSaveMiddleware(
  Store<AppState> store, 
  dynamic action, 
  void Function(dynamic) next,
) {
  final before = store.state;

  next(action);

  final after = store.state;

  if (_haveSettingsChanged(before, after)) {
    final serializedStore = json.encode(serializers.serialize(store.state));
    window.localStorage['fi-save'] = serializedStore;
    FiClient.updateBudget(store.state.selectedMonth, serializedStore);
  }
}

Future<void> loadFromServer(Store<AppState> store) async {
  final now = DateTime.now();
  BuiltMap<String, Transaction> transactions;
  AppState appState;
  
  await Future.wait([
    FiClient.getTransactions(
      DateTime(now.year, now.month, 1),
      DateTime(now.year, now.month+1, 0),
    ).then((resp) => transactions = resp),
    FiClient.getBudget(
      store.state.selectedMonth,
    ).then((resp) => appState = resp)
  ]);

  // on the off chance that transactionIds get borked, dont add phantom ones within items
  final filteredItems = appState?.items?.map((itemId, item) {
    if (item is Bucket) {
      return MapEntry(
        itemId, item.rebuild((b) => b
          ..transactions = item.transactions
            .where((transactionId) {
              return transactions.keys.contains(transactionId);
            }).toBuiltList().toBuilder()
        ),
      );
    }
    return MapEntry(itemId, item);
  });

  store.dispatch(LoadStateAction(
    items: filteredItems ?? appState.items,
    rootItemIds: appState?.rootItemIds ?? store.state.rootItemIds,
    borrows: appState?.borrows ?? store.state.borrows,
    transactions: transactions,
    ignoredTransactions: appState?.ignoredTransactions ?? store.state.ignoredTransactions
  ));
}

bool _haveSettingsChanged(AppState a, AppState b) {
  if (a.items != b.items) return true;
  if (a.transactions != b.transactions) return true;
  if (a.ignoredTransactions != b.ignoredTransactions) return true;
  if (a.borrows != b.borrows) return true;
  if (a.rootItemIds != b.rootItemIds) return true;

  return false;
}