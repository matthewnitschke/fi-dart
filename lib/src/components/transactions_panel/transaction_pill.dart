import 'package:over_react/over_react.dart';

part 'transaction_pill.over_react.g.dart';

mixin TransactionPillProps on UiProps {
  double amount;
  String merchant;
}

UiFactory<TransactionPillProps> TransactionPill = uiFunction(
  (props) {
    final classNameBuilder = ClassNameBuilder()
      ..add('transaction-pill')
      ..add('transaction-pill__income', props.amount > 0)
      ..add('transaction-pill__expence', props.amount < 0);

    return (Dom.div()
      ..className = classNameBuilder.toClassName()
    )(
      (Dom.div()
        ..className = 'transaction-pill__amount'
      )('\$${props.amount.abs()}'),
      (Dom.div()
        ..className = 'transaction-pill__merchant'
      )(props.merchant)
    );
  },
  _$TransactionPillConfig, // ignore: undefined_identifier
);
