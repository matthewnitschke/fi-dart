import 'package:over_react/over_react.dart';

part 'card.over_react.g.dart';

mixin CardProps on UiProps {}

UiFactory<CardProps> Card = uiFunction(
  (props) {
    final classNameBuilder = ClassNameBuilder()
      ..add('card')
      ..addFromProps(props);

    return (Dom.div()
      ..className = classNameBuilder.toClassName()
    )(
      props.children
    );
  },
  _$CardConfig, // ignore: undefined_identifier
);
