import 'package:fi/src/components/utils/button.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'root_new_button.over_react.g.dart';

mixin RootNewButtonProps on UiProps {}

UiFactory<RootNewButtonProps> RootNewButton = uiFunction(
  (props) {
    final dispatch = useDispatch();
    
    return (Dom.div()
      ..className = 'root-new-button'
    )(
      (Button()
        ..skin = ButtonSkin.link
        ..onClick = ((_) => dispatch(AddBucketGroupAction()))
      )('Add Group'),

      (Button()
        ..skin = ButtonSkin.link
        ..onClick = ((_) => dispatch(AddBucketAction()))
      )('Add Bucket'),
    );
  },
  _$RootNewButtonConfig, // ignore: undefined_identifier
);
