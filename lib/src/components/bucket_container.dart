import 'package:fi/src/components/amount_indicator.dart';
import 'package:fi/src/components/item_layout.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
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
      ..className = 'bucket-container'
      ..label = bucket.label
      ..onLabelChange = ((newLabel) => dispatch(SetItemLabelAction(props.itemId, newLabel)))
      ..headerContent = (() => Dom.div()('\$$bucketAmount'))
    )(
      (AmountIndicator()
        ..value = 50
        ..max = 100
      )()
    );
  },
  _$BucketContainerConfig, // ignore: undefined_identifier
);
