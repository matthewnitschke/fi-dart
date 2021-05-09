import 'package:built_collection/built_collection.dart';
import 'package:fi/src/components/transactions_panel/transaction_list.dart';
import 'package:fi/src/components/transactions_panel/transaction_pill.dart';
import 'package:fi/src/components/utils/panel.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';

part 'transactions_panel.over_react.g.dart';

mixin TransactionsPanelProps on UiProps {}

UiFactory<TransactionsPanelProps> TransactionsPanel = uiFunction(
  (props) {
    final transactions = useAppSelector(
      (state) => state.transactions
    );
    return (Panel()
      ..header = 'Transactions'
    )(
      (TransactionList()
        ..transactionIds = transactions.keys.toList()
      )()
    );
  },
  _$TransactionsPanelConfig, // ignore: undefined_identifier
);