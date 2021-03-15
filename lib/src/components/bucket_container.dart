import 'package:fi/src/components/amount_indicator.dart';
import 'package:fi/src/components/utils/drag_handle.dart';
import 'package:fi/src/components/utils/text_input.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
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

    return (Dom.div()
      ..className = 'bucket-container'
    )(
      (Dom.div()
        ..className = 'bucket-container__content-line'
      )(
        DragHandle()(),
        (TextInput()
          ..value = bucket.label
          ..placeholder = 'Label'
          ..onChange = ((e) => dispatch(SetItemLabelAction(props.itemId, e.target.value as String)))
        )()
      ),

      (AmountIndicator()
        ..value = 50
        ..max = 100
      )()
    );
  },
  _$BucketContainerConfig, // ignore: undefined_identifier
);
