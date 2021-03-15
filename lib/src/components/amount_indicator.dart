import 'package:over_react/over_react.dart';

part 'amount_indicator.over_react.g.dart';

mixin AmountIndicatorProps on UiProps {
  double value;
  double max;
}

UiFactory<AmountIndicatorProps> AmountIndicator = uiFunction(
  (props) {
    if (props.value == 0 || props.max == 0) {
      return null;
    }

    final classNameBuilder = ClassNameBuilder()
      ..add('current')
      ..add('max', props.value >= props.max);

    return (Dom.div()
      ..className = 'amount-indicator'
    )(
      (Dom.div()
        ..className = classNameBuilder.toClassName()
        ..style = {'width': '${(props.value / props.max) * 100}%'}
      )()
    );
  },
  _$AmountIndicatorConfig, // ignore: undefined_identifier
);
