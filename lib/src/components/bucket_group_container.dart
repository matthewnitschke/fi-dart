import 'package:fi/src/components/bucket_container.dart';
import 'package:fi/src/components/utils/button.dart';
import 'package:fi/src/components/utils/text_input.dart';
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

    return (Dom.div()
      ..className = 'bucket-group-container'
    )(
      Dom.div()(
        (TextInput()
          ..value = bucketGroup.label
          ..className = 'group-label-input'
          ..placeholder = 'Group Label'
          ..onChange = ((e) => dispatch(SetItemLabelAction(props.itemId, e.target.value as String)))
        )()
      ),

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
