import 'package:fi/src/app/hooks/dnd-hooks.dart';
import 'package:fi/src/app/redux/items/items.actions.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'ignore_transaction_dropzone.over_react.g.dart';

mixin IgnoreTransactionDropzoneProps on UiProps {}

UiFactory<IgnoreTransactionDropzoneProps> IgnoreTransactionDropzone = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final ref = useDropzone(
      acceptor: TransactionAcceptor(),
      onDrop: (dropEvent) {
        final transactionId = dropEvent.draggableElement.id;
        dispatch(UnallocateTransactionAction(transactionId));
        dispatch(IgnoreTransactionAction(transactionId));
      },
    );

    final isDragging = useAppSelector((state) => state.isDraggingTransaction) ?? false;

    return (Dom.div()
      ..ref = ref
      ..style = {
        'visibility': isDragging ? 'initial': 'hidden',
        'position': 'fixed',
        'top': '1rem',
        'left': '1rem',
        'display': 'flex',
        'alignItems': 'center',
        'justifyContent': 'center',
        'width': '10rem',
        'height': '6rem',
        'backgroundColor': 'lightgrey',
        'border': 'solid 3px grey',
      }
    )('Ignore');
  },
  _$IgnoreTransactionDropzoneConfig, // ignore: undefined_identifier
);
