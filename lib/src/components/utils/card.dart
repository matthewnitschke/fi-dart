import 'package:over_react/over_react.dart';

part 'card.over_react.g.dart';

mixin CardProps on UiProps {}

UiFactory<CardProps> Card = uiForwardRef(
  (props, ref) {
    final classNameBuilder = ClassNameBuilder()
      ..add('card')
      ..addFromProps(props);

    return (Dom.div()
      ..className = classNameBuilder.toClassName()
      ..ref = ref
    )(
      props.children
    );
  },
  _$CardConfig, // ignore: undefined_identifier
);
