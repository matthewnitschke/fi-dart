import 'package:over_react/over_react.dart';

part 'app_bar.over_react.g.dart';

mixin AppBarProps on UiProps {
  void Function() onBackClick;
}

UiFactory<AppBarProps> AppBar = uiFunction(
  (props) {
    return Dom.div()(
      (Dom.i()
        ..className = 'fas fa-chevron-left'
        ..onClick = ((_) => props.onBackClick())
      )()
    );
  },
  _$AppBarConfig, // ignore: undefined_identifier
);
