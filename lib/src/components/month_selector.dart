import 'package:fi/src/components/utils/button.dart';
import 'package:fi/src/utils.dart';
import 'package:intl/intl.dart';
import 'package:over_react/over_react.dart';

part 'month_selector.over_react.g.dart';

mixin MonthSelectorProps on UiProps {}

UiFactory<MonthSelectorProps> MonthSelector = uiFunction(
  (props) {
    final selectedMonth = useEqualitySelector((state) => state.selectedMonth);

    return (Dom.div()
      ..className = 'month-selector'
    )(
      (Dom.div()
        ..className = 'month-selector__label'
      )(
        (Dom.div()
          ..className = 'month'
        )(
          DateFormat.MMMM().format(selectedMonth),
        ),

        (Dom.div()
          ..className = 'year'
        )(
          DateFormat.y().format(selectedMonth)
        )
      ),

      (Dom.div()
        ..className = 'month-selector__arrows'
      )(
        (Button()
          ..skin = ButtonSkin.link
        )('<'),
        (Button()
          ..skin = ButtonSkin.link
        )('>')
      )
    );
  },
  _$MonthSelectorConfig, // ignore: undefined_identifier
);
