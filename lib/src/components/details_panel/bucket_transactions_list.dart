import 'package:fi/src/components/transactions_panel/transaction_list.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';

part 'bucket_transactions_list.over_react.g.dart';

mixin BucketTransactionsListProps on UiProps {
  String itemId;
}

UiFactory<BucketTransactionsListProps> BucketTransactionsList = uiFunction(
  (props) {
    final transactionIds = useAppSelector((state) => (state.items[props.itemId] as Bucket).transactions);
    return (TransactionList()
      ..transactionIds = transactionIds.toList()
    )();
  },
  _$BucketTransactionsListConfig, // ignore: undefined_identifier
);
