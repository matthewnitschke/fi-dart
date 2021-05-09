import 'package:over_react/over_react.dart';

import 'card.dart';

part 'panel.over_react.g.dart';

mixin PanelProps on UiProps {
  String header;
}

UiFactory<PanelProps> Panel = uiFunction(
  (props) {
    return (Dom.div()
      ..className = 'panel'
    )(
      (Dom.div()
        ..className = 'panel__header'
      )(props.header),
      Card()(props.children)
    );
  },
  _$PanelConfig, // ignore: undefined_identifier
);
