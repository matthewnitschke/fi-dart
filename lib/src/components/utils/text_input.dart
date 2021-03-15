import 'package:over_react/over_react.dart';

part 'text_input.over_react.g.dart';

class TextInputProps = UiProps with DomPropsMixin;

UiFactory<TextInputProps> TextInput = uiFunction(
  (props) {
    return (Dom.input()
      ..addProps(props)
      ..onFocus = ((e) => e.target.select())
      ..className = 'text-input ${props.className}'
    )();
  },
  _$TextInputConfig, // ignore: undefined_identifier
);
