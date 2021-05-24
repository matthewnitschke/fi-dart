import 'package:fi/src/app/redux/selectors.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';

part 'bucket_amount_indicator.over_react.g.dart';

enum BucketAmountIndicatorSize {
  DEFAULT,
  LARGE,
}

mixin BucketAmountIndicatorProps on UiProps {
  String itemId;

  BucketAmountIndicatorSize size;
}

UiFactory<BucketAmountIndicatorProps> BucketAmountIndicator = uiFunction(
  (props) {
    final size = props.size ?? BucketAmountIndicatorSize.DEFAULT;

    final bucketAmount = useAppSelector((state) => bucketAmountSelector(state, props.itemId));
    final transactionsSum = useAppSelector((state) => bucketTransactionsSum(state, props.itemId));

    final width = transactionsSum == 0 && bucketAmount == 0 ? 0 : (transactionsSum / bucketAmount) * 100;
    return (Dom.div()
      ..className = (ClassNameBuilder()
        ..add('amount-indicator')
        ..add('amount-indicator__large', size == BucketAmountIndicatorSize.LARGE)
      ).toClassName()
    )(
      (Dom.div()
        ..className = (ClassNameBuilder()
          ..add('current')
          ..add('max', transactionsSum > bucketAmount)
        ).toClassName()
        ..style = {'width': '$width%'}
      )()
    );
  },
  _$BucketAmountIndicatorConfig, // ignore: undefined_identifier
);
