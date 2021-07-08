import 'package:fi/src/app/components/bucket_amount_indicator.dart';
import 'package:fi/src/app/components/details_handle.dart';
import 'package:fi/src/app/components/item_layout.dart';
import 'package:fi/src/app/hooks/dnd-hooks.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/redux/items/items.actions.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:fi/src/app/redux/selectors.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'bucket_container.over_react.g.dart';

mixin BucketContainerProps on UiProps {
  String itemId;
}

UiFactory<BucketContainerProps> BucketContainer = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final ref = useDropzone(
      acceptor: TransactionAcceptor(),
      onDrop: (dropEvent) {
        final transactionId = dropEvent.draggableElement.id;
        dispatch(AllocateTransactionAction(props.itemId, transactionId));
      },
    );

    final selectedItemId = useAppSelector((store) => store.selectedItemId);
    
    final bucket = useEqualitySelector(
      (state) {
        final item = state.items[props.itemId];

        if (item is Bucket) {
          return item;
        } else {
          throw Exception("ItemId is not a bucket");
        }
      },
    );

    final bucketAmount = useEqualitySelector((state) => bucketAmountSelector(state, props.itemId));

    return (ItemLayout()
      ..ref = ref
      ..className = 'bucket-container'
      ..label = bucket.label
      ..onLabelChange = ((newLabel) => dispatch(SetItemLabelAction(props.itemId, newLabel)))
      ..headerContent = (() => Dom.div()('\$${bucketAmount.toStringAsFixed(0)}'))
      ..onLabelFocus = ((_) => dispatch(SelectItemAction(props.itemId)))
      ..onReorderUp = (() => dispatch(ReorderItemAction(props.itemId, -1)))
      ..onReorderDown = (() => dispatch(ReorderItemAction(props.itemId, 1)))
      ..rightContent = (() => (DetailsHandle()
        ..onClick = ((_) => dispatch(SelectItemAction(props.itemId)))
        ..isSelected = selectedItemId == props.itemId
      )())
    )(
      (BucketAmountIndicator()
        ..itemId = props.itemId
      )()
    );
  },
  _$BucketContainerConfig, // ignore: undefined_identifier
);
