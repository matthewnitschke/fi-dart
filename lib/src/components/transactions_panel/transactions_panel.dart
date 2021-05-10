import 'package:fi/src/components/transactions_panel/transaction_list.dart';
import 'package:fi/src/components/utils/panel.dart';
import 'package:fi/src/hooks/dnd-hooks.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/utils.dart';
import 'package:fi/src/redux/selectors.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'transactions_panel.over_react.g.dart';

mixin TransactionsPanelProps on UiProps {}

UiFactory<TransactionsPanelProps> TransactionsPanel = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final ref = useDropzone(
      onDrop: (e) {
        dispatch(UnallocateTransactionAction(e.draggableElement.id));
      }
    );

    final transactions = useAppSelector(
      unallocatedTransactionsSelector
    );

    return (Panel()
      ..header = 'Transactions'
      ..ref = ref
    )(
      (TransactionList()
        ..transactionIds = transactions
      )()
    );
  },
  _$TransactionsPanelConfig, // ignore: undefined_identifier
);