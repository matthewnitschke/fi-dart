import 'package:fi/src/app/hooks/util.dart';
import 'package:over_react/over_react.dart';
import 'package:fi/src/app/utils.dart';
import 'package:fi/src/utils/extensions.dart';

part 'select.over_react.g.dart';

class SelectOption {
  final String label;
  SelectOption(this.label);
}

class SelectOptionGroup extends SelectOption {
  final Map<String, SelectOption> options;
  SelectOptionGroup(String label, this.options) : super(label);
}


mixin SelectProps on UiProps {
  String selectedOption;

  Map<String, SelectOption> options;

  void Function(String) onOptionSelect;
}

UiFactory<SelectProps> Select = uiFunction(
  (props) {
    final isOpen = useState(false);

    final ref = onOutsideClick(() {
      isOpen.set(false);
    });

    var selectedDisplayValue = 'Select';
    for (var key in props.options.keys) {
      final option = props.options[key];
      if (option is SelectOptionGroup) {
        if (option.options.keys.contains(props.selectedOption)) {
          selectedDisplayValue = option.options[props.selectedOption].label;
        };
      } else if (key == props.selectedOption) {
        selectedDisplayValue = option.label;
      }
    }

    return (Dom.div()
      ..ref = ref
      ..className = 'select ${isOpen.value ? 'open' : ''}'
      ..onClick = ((e) {
        isOpen.set(!isOpen.value);
      })
      ..style = props.style
    )(
      Dom.div()(
        selectedDisplayValue
      ),
      (Dom.div()
        ..className = 'select__arrow'
      )(
        '▾'
      ),

      isOpen.value ? (Dom.div()
        ..className = 'select__dropdown'
      )(
        props.options.mapKV((key, option) {
          if (option is SelectOptionGroup) {
            return (Dom.div()
              ..key = key
            )(
              (_SelectOptionItem()
                ..label = option.label
                ..isDisabled = true
              )(),
              (Dom.div()
                ..style = {'marginLeft': '2rem'}
              )(
                option.options.mapKV((subKey, subOption) {
                  return (_SelectOptionItem()
                    ..key = subKey
                    ..label = subOption.label
                    ..isSelected = props.selectedOption == subKey
                    ..onOptionSelect = (() => props.onOptionSelect(subKey))
                  )();
                })
              )
            );
          }

          return (_SelectOptionItem()
            ..key = key
            ..label = option.label
            ..isSelected = props.selectedOption == key
            ..onOptionSelect = (() => props.onOptionSelect(key))
          )();
        }),
      ) : null
    );
  },
  _$SelectConfig, // ignore: undefined_identifier
);



mixin _SelectOptionItemProps on UiProps {
  String label;
  void Function() onOptionSelect;
  bool isSelected;
  bool isDisabled;
}

UiFactory<_SelectOptionItemProps> _SelectOptionItem = uiFunction(
  (props) {
    final isSelected = props.isSelected ?? false;
    final isDisabled = props.isDisabled ?? false;
    return (Dom.div()
      ..className = 'select__dropdown__option ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}'
      ..onClick = ((_) => !isDisabled ? props.onOptionSelect?.call() : null)
    )(props.label);
  },
  _$_SelectOptionItemConfig, // ignore: undefined_identifier
);
