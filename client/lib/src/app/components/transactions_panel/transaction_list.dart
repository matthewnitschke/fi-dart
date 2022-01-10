import 'package:fi/src/app/components/transactions_panel/transaction_pill.dart';
import 'package:fi/src/app/models/transaction.sg.dart';
import 'package:fi/src/app/utils.dart';
import 'package:intl/intl.dart';
import 'package:over_react/over_react.dart';

part 'transaction_list.over_react.g.dart';

final dateFormatter = DateFormat.MMMd();

mixin TransactionListProps on UiProps {
  List<String> transactionIds;
}

UiFactory<TransactionListProps> TransactionList = uiFunction(
  (props) {
    final transactions = useAppSelector((state) {
      return props.transactionIds
        .where((transactionId) => !state.ignoredTransactions.contains(transactionId))
        .map((transactionId) {
        return MapEntry(transactionId, state.transactions[transactionId]);
      });
    });

    final groupedTransacitons = transactions.fold<Map<String, List<MapEntry<String, Transaction>>>>(
      <String, List<MapEntry<String, Transaction>>>{}, 
      (acc, entry) {
        final dateStr = dateFormatter.format(entry.value.date);
        acc[dateStr] ??= <MapEntry<String, Transaction>>[];
        acc[dateStr].add(entry);
        return acc;
      },
    );

    final sortedDates = groupedTransacitons.keys.toList();

    sortedDates.sort((a, b) {
      final aDate = dateFormatter.parse(a);
      final bDate = dateFormatter.parse(b);
      return aDate.compareTo(bDate);
    });

    return (Dom.div()
      ..className = ClassNameBuilder.fromProps(props).toClassName()
    )(
      sortedDates.map((dateStr) {
        return (Dom.div()
          ..key = dateStr
          ..style = {
            'marginBottom': '1.5rem',
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.div()
            ..style = {
              'marginBottom': '.3rem',
              'fontSize': '.8rem'
            }
          )(dateStr),
          groupedTransacitons[dateStr].map((entry) {
            return (TransactionPill()
              ..key = entry.key
              ..transactionId = entry.key
              ..merchant = entry.value.merchant
              ..name = entry.value.name
              ..amount = entry.value.amount
            )();
          })
        );
      })
    );
    
  },
  _$TransactionListConfig, // ignore: undefined_identifier
);
