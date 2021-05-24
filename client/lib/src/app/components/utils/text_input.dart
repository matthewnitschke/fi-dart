import 'package:over_react/over_react.dart';

part 'text_input.over_react.g.dart';

class TextInputProps = UiProps with DomPropsMixin;

UiFactory<TextInputProps> TextInput = uiFunction(
  (props) {
    final classNameBuilder = ClassNameBuilder.fromProps(props)
      ..add('text-input');

    return (Dom.input()
      ..addProps(props)
      ..onFocus = ((e) => e.target.select())
      ..className = classNameBuilder.toClassName()
    )();
  },
  _$TextInputConfig, // ignore: undefined_identifier
);
