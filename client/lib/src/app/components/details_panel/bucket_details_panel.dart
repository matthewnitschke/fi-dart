
import 'package:fi/src/app/components/bucket_amount_indicator.dart';
import 'package:fi/src/app/components/details_panel/bucket_borrow_list.dart';
import 'package:fi/src/app/components/details_panel/bucket_transactions_list.dart';
import 'package:fi/src/app/components/details_panel/bucket_value_editor.dart';
import 'package:fi/src/app/components/utils/panel.dart';
import 'package:fi/src/app/components/utils/tabs.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/bucket_value.sg.dart';
import 'package:fi/src/app/redux/items/items.actions.dart';
import 'package:fi/src/app/redux/selectors.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'bucket_details_panel.over_react.g.dart';

mixin BucketDetailsPanelProps on UiProps {
  String itemId;
}

UiFactory<BucketDetailsPanelProps> BucketDetailsPanel = uiFunction(
  (props) {
    final dispatch = useDispatch();
    final item = useAppSelector(
      (state) => state.items[props.itemId] as Bucket
    );

    final bucketValue = useAppSelector(
      (state) => bucketAmountSelector(state, props.itemId)
    );

    final transactionsSum = useAppSelector(
      (state) => bucketTransactionsSum(state, props.itemId)
    );

    final selectedTab = useState('details');

    final header = item.label?.isEmpty == true ? 'Label' : item.label;
    return (Panel()
      ..header = header
      ..headerRightContent = (() => Dom.div()('\$${transactionsSum.toStringAsFixed(2)} / \$${bucketValue.toStringAsFixed(2)}'))
    )(
      (BucketAmountIndicator()
        ..itemId = props.itemId
        ..size = BucketAmountIndicatorSize.LARGE
      )(),

      (Tabs()
        ..tabs = {
          'details': 'Details',
          'transactions': 'Transactions',
          if (item.value is! IncomeBucketValue) 'borrows': 'Borrows'
        }
        ..selectedKey = selectedTab.value
        ..onTabClick = ((key) => selectedTab.set(key))
      )(
        selectedTab.value == 'details' ? Fragment()(
          (BucketValueEditor()
            ..value = item.value
            ..onValueChange = ((newValue) => dispatch(SetBucketValueAction(props.itemId, newValue)))
          )(),
          (Dom.div()
            ..style = {
              'marginTop': '1rem',
              'textAlign': 'right'
            }
          )(
            (Dom.button()
              ..className = 'icon-button'
              ..onClick = ((_) => dispatch(DeleteItemAction(props.itemId)))
            )(
              (Dom.i()
                ..className = 'far fa-trash-alt'
              )()
            )
          ),
        ) : null,

        selectedTab.value == 'transactions' ? (BucketTransactionsList()..itemId = props.itemId)() : null,

        selectedTab.value == 'borrows' ? (BucketBorrowList()..itemId = props.itemId)() : null,
      ),



    );
  },
  _$BucketDetailsPanelConfig, // ignore: undefined_identifier
);
