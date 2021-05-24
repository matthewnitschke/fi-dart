import 'package:fi/src/app/hooks/util.dart';
import 'package:over_react/over_react.dart';
import 'package:fi/src/app/utils.dart';

part 'select.over_react.g.dart';

mixin SelectProps on UiProps {
  String selectedOption;

  Map<String, String> options;

  void Function(String) onOptionSelect;
}

UiFactory<SelectProps> Select = uiFunction(
  (props) {
    final isOpen = useState(false);

    final ref = onOutsideClick(() {
      isOpen.set(false);
    });

    final selectedValue = props.options.containsKey(props.selectedOption) ? props.options[props.selectedOption] : 'Select';

    return (Dom.div()
      ..ref = ref
      ..className = 'select ${isOpen.value ? 'open' : ''}'
      ..onClick = ((e) {
        isOpen.set(!isOpen.value);
      })
      ..style = props.style
    )(
      Dom.div()(
        selectedValue
      ),
      (Dom.div()
        ..className = 'select__arrow'
      )(
        '▾'
      ),

      isOpen.value ? (Dom.div()
        ..className = 'select__dropdown'
      )(
        props.options.mapKV((key, label) {
          return (Dom.div()
            ..key = key
            ..className = 'select__dropdown__option ${props.selectedOption == key ? 'selected' : ''}'
            ..onClick = ((_) => props.onOptionSelect(key))
          )(label);
        }),
      ) : null
    );
  },
  _$SelectConfig, // ignore: undefined_identifier
);
