import 'package:over_react/over_react.dart';

part 'button.over_react.g.dart';

enum ButtonSkin {
  add,
  close,
  link,
  none
}

mixin ButtonProps on UiProps {
  ButtonSkin skin;
}

UiFactory<ButtonProps> Button = uiFunction(
  (props) {

    dynamic buttonContent;
    if (props.skin == ButtonSkin.add) {
      buttonContent = '＋';
    } else if (props.skin == ButtonSkin.close) {
      buttonContent = '✕';
    } else {
      buttonContent = props.children;
    }

    final skin = props.skin ?? ButtonSkin.none;
    String skinClass = skin.toString().substring("ButtonSkin.".length);

    return (Dom.div()
      ..className = 'button skin-${skinClass} ${props.className}'
      ..onClick = props.onClick
    )(buttonContent);
  },
  _$ButtonConfig, // ignore: undefined_identifier
);
