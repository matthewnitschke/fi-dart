
import 'package:fi/src/components/details_panel/bucket_value_editor.dart';
import 'package:fi/src/components/utils/panel.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'bucket_details_panel.over_react.g.dart';

mixin BucketDetailsPanelProps on UiProps {
  String itemId;
}

UiFactory<BucketDetailsPanelProps> BucketDetailsPanel = uiFunction(
  (props) {
    final dispatch = useDispatch();
    final item = useEqualitySelector(
      (state) => state.items[props.itemId] as Bucket
    );
    
    return (Panel()
      ..header = item.label
    )(
      (BucketValueEditor()
        ..value = item.value
        ..onValueChange = ((newValue) => dispatch(SetBucketValueAction(props.itemId, newValue)))
      )(),
    );
  },
  _$BucketDetailsPanelConfig, // ignore: undefined_identifier
);
