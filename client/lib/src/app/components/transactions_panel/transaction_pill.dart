import 'package:fi/src/app/hooks/dnd-hooks.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'transaction_pill.over_react.g.dart';

mixin TransactionPillProps on UiProps {
  String transactionId;
  double amount;
  String merchant;
  String name;
}

UiFactory<TransactionPillProps> TransactionPill = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final container = useDraggable(
      avatarHandler: TransactionAvatarHandler(),
      onDragStart: (_) => dispatch(SetIsDraggingTransactionAction(true)),
      onDragEnd: (_) => dispatch(SetIsDraggingTransactionAction(false)),
    );

    final isExpanded = useState(false);

    final classNameBuilder = ClassNameBuilder()
      ..add('transaction-pill')
      ..add('transaction-pill__income', props.amount > 0)
      ..add('transaction-pill__expense', props.amount < 0)
      ..add('transaction-pill__expanded', isExpanded.value);

    return (Dom.div()
      ..ref = container
      ..className = classNameBuilder.toClassName()
      ..id = props.transactionId
      ..onClick = ((_) => isExpanded.set(!isExpanded.value))
    )(
      (Dom.div()
        ..ref = container
        ..className = 'transaction-pill__header'
      )(
        (Dom.div()
          ..className = 'transaction-pill__amount'
        )('\$${props.amount.abs()}'),
        (Dom.div()
          ..className = 'transaction-pill__merchant'
        )(props.merchant)
      ),

      isExpanded.value ? (Dom.div()
        ..className = 'transaction-pill__body'
      )(
        props.name
      ) : null
    );
  },
  _$TransactionPillConfig, // ignore: undefined_identifier
);
