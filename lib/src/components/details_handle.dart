import 'package:over_react/over_react.dart';

part 'details_handle.over_react.g.dart';

mixin DetailsHandleProps on UiProps {}

UiFactory<DetailsHandleProps> DetailsHandle = uiFunction(
  (props) {
    return (Dom.div()
      ..className = 'details-handle'
    )(
      (Dom.i()
        ..className = 'far fa-circle'
        // ..className = 'fas fa-asterisk'
      )()
    );
  },
  _$DetailsHandleConfig, // ignore: undefined_identifier
);
