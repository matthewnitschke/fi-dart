import 'package:fi/src/components/utils/drag_handle.dart';
import 'package:fi/src/components/utils/text_input.dart';
import 'package:over_react/over_react.dart';

part 'item_layout.over_react.g.dart';

mixin ItemLayoutProps on UiProps {
  String label;
  ReactElement Function() headerContent;
  ReactElement Function() rightContent;

  void Function(String label) onLabelChange;
  void Function(SyntheticMouseEvent) onLabelFocus;
}

UiFactory<ItemLayoutProps> ItemLayout = uiForwardRef(
  (props, ref) {
    final classNameBuilder = ClassNameBuilder.fromProps(props)
      ..add('item-layout');

    return (Dom.div()
      ..ref = ref
      ..className = classNameBuilder.toClassName()
    )(
      (Dom.div()
        ..className = 'item-layout__header'
      )(
        DragHandle()(),

        (TextInput()
          ..className = 'item-layout__label-input'
          ..value = props.label
          ..placeholder = 'Label'
          ..onChange = ((e) => props.onLabelChange(e.target.value))
          ..onClick = props.onLabelFocus
        )(),

        props.headerContent?.call(),

        props.rightContent?.call(),
      ),

      (Dom.div()
        ..className = 'item-layout__content'
      )(props.children)
    );
  },
  _$ItemLayoutConfig, // ignore: undefined_identifier
);
