import 'package:fi/src/app/components/transactions_panel/transaction_list.dart';
import 'package:fi/src/app/components/utils/panel.dart';
import 'package:fi/src/app/hooks/dnd-hooks.dart';
import 'package:fi/src/app/redux/items/items.actions.dart';
import 'package:fi/src/app/utils.dart';
import 'package:fi/src/app/redux/selectors.dart';
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
      ..className = 'h100'
    )(
      (TransactionList()
        ..className = 'scroll'
        ..transactionIds = transactions
      )()
    );
  },
  _$TransactionsPanelConfig, // ignore: undefined_identifier
);