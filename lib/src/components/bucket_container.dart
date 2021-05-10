import 'package:fi/src/components/bucket_amount_indicator.dart';
import 'package:fi/src/components/details_handle.dart';
import 'package:fi/src/components/item_layout.dart';
import 'package:fi/src/hooks/dnd-hooks.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/redux/root/root.actions.dart';
import 'package:fi/src/redux/selectors.dart';
import 'package:fi/src/utils.dart';
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
      ..headerContent = (() => Dom.div()('\$$bucketAmount'))
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
