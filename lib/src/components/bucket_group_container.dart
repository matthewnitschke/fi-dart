import 'package:fi/src/components/bucket_container.dart';
import 'package:fi/src/components/item_layout.dart';
import 'package:fi/src/components/utils/button.dart';
import 'package:fi/src/models/bucket_group.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'bucket_group_container.over_react.g.dart';

mixin BucketGroupContainerProps on UiProps {
  String itemId;
}

UiFactory<BucketGroupContainerProps> BucketGroupContainer = uiFunction(
  (props) {
    final dispatch = useDispatch();
    final bucketGroup = useEqualitySelector(
      (state) {
        final item = state.items[props.itemId];

        if (item is BucketGroup) {
          return item;
        } else {
          throw Exception("ItemId is not a bucket group");
        }
      },
    );

    return (ItemLayout()
      ..className = 'bucket-group-container'
      ..label = bucketGroup.label
      ..onLabelChange = ((newLabel) => dispatch(SetItemLabelAction(props.itemId, newLabel)))
    )(
      bucketGroup.itemIds.map((childItemId) {
        return (BucketContainer()
          ..key = childItemId
          ..itemId = childItemId
        )();
      }),

      (Button()
        ..skin = ButtonSkin.link
        ..className = 'add-item-button'
        ..onClick = ((_) => dispatch(AddBucketAction(parentId: props.itemId)))
      )('Add Item')
    );
  },
  _$BucketGroupContainerConfig, // ignore: undefined_identifier
);
