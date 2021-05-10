import 'package:fi/src/hooks/dnd-hooks.dart';
import 'package:over_react/over_react.dart';

part 'transaction_pill.over_react.g.dart';

mixin TransactionPillProps on UiProps {
  String transactionId;
  double amount;
  String merchant;
}

UiFactory<TransactionPillProps> TransactionPill = uiFunction(
  (props) {
    final container = useDraggable();

    final classNameBuilder = ClassNameBuilder()
      ..add('transaction-pill')
      ..add('transaction-pill__income', props.amount > 0)
      ..add('transaction-pill__expence', props.amount < 0);

    return (Dom.div()
      ..ref = container
      ..className = classNameBuilder.toClassName()
      ..id = props.transactionId
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
