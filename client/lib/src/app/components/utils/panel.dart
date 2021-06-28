import 'package:over_react/over_react.dart';

import 'card.dart';

part 'panel.over_react.g.dart';

mixin PanelProps on UiProps {
  String header;
  ReactElement Function() headerRightContent;
}

UiFactory<PanelProps> Panel = uiForwardRef(
  (props, ref) {
    return (Card()
      ..className = (ClassNameBuilder.fromProps(props)
        ..add('panel')
      ).toClassName()
      ..ref = ref
    )(
      (Dom.div()
        ..className = 'panel__header'
      )(
        props.header,
        props.headerRightContent?.call()
      ),
      props.children
    );
  },
  _$PanelConfig, // ignore: undefined_identifier
);
