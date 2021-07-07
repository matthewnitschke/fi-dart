import 'dart:convert';
import 'dart:html';

import 'package:fi/src/app/fi-client.dart';
import 'package:fi/src/app/models/app_state.sg.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/serializers.sg.dart';
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
    window.localStorage['fi-save'] = json.encode(serializers.serialize(store.state));
  }
}

Future<void> loadFromLocalStorage(Store<AppState> store) async {
  if (window.localStorage.containsKey('fi-save')) {
    final settings = serializers.deserializeWith(
      AppState.serializer,
      json.decode(window.localStorage['fi-save']),
    );

    final now = DateTime.now();
    final transactions = await FiClient.getTransactions(
      DateTime(now.year, now.month, 1),
      DateTime(now.year, now.month+1, 0),
    );


    // on the off chance that transactionIds get borked, dont add phantom ones within items
    final filteredItems = settings.items.map((itemId, item) {
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
      items: filteredItems,
      rootItemIds: settings.rootItemIds,
      borrows: settings.borrows,
      transactions: transactions
    ));
  }
}

bool _haveSettingsChanged(AppState a, AppState b) {
  if (a.items != b.items) return true;
  if (a.transactions != b.transactions) return true;
  if (a.borrows != b.borrows) return true;
  if (a.rootItemIds != b.rootItemIds) return true;

  return false;
}