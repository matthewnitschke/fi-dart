import 'package:over_react/over_react.dart';

import 'package:fi/src/utils/extensions.dart';

part 'tabs.over_react.g.dart';

mixin TabsProps on UiProps {
  Map<String, String> tabs;

  String selectedKey;

  void Function(String) onTabClick;
}

UiFactory<TabsProps> Tabs = uiFunction(
  (props) {
    return (Dom.div()
      ..className = 'tabs'
    )(
      (Dom.div()
        ..className ='tabs__header'
      )(
        props.tabs.mapKV((key, tabLabel) {
          return (Dom.div()
            ..key = key
            ..className = 'tab-item ${props.selectedKey == key ? 'selected' : ''}'
            ..onClick = ((_) => props.onTabClick(key))
          )(
            tabLabel
          );
        }),
      ),

      (Dom.div()
        ..className = 'tabs__body'
      )(props.children)
    );
  },
  _$TabsConfig, // ignore: undefined_identifier
);
