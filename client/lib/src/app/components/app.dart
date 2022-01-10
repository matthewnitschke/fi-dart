import 'package:fi/src/app/components/app_bar.dart';
import 'package:fi/src/app/components/bucket_list.dart';
import 'package:fi/src/app/components/details_panel/bucket_details_panel.dart';
import 'package:fi/src/app/components/month_selector.dart';
import 'package:fi/src/app/components/transactions_panel/ignore_transaction_dropzone.dart';
import 'package:fi/src/app/components/transactions_panel/transactions_panel.dart';
import 'package:fi/src/app/redux/root/root.actions.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction(
  (props) {
    final selectedItemId = useAppSelector((state) => state.selectedItemId);
    final dispatch = useDispatch();

    if (selectedItemId != null) {
      return Dom.div()(
        (AppBar()
          ..onBackClick = (() => dispatch(SelectItemAction(null)))
        )(),
        (BucketDetailsPanel()..itemId = selectedItemId)()
      );
    }

    return (Dom.div()
      ..className = 'body'
    )(
      IgnoreTransactionDropzone()(),
      MonthSelector()(),
      BucketList()(),
    );

    // return (_DesktopLayout()
    //   ..selectedItemId = selectedItemId
    // )();
  },
  _$AppConfig, // ignore: undefined_identifier
);


mixin _DesktopLayoutProps on UiProps {
  String selectedItemId;
}

UiFactory<_DesktopLayoutProps> _DesktopLayout = uiFunction(
  (props) {
    return Fragment()(
      IgnoreTransactionDropzone()(),
      (Dom.div()
        ..className = 'lhp card card__scrollable'
      )(TransactionsPanel()()),
      (Dom.div()
        ..className = 'header'
      )(MonthSelector()()),
      (Dom.div()
        ..className = 'body'
      )(BucketList()()),
      (Dom.div()
        ..className = 'rhp'
      )(
        props.selectedItemId != null
          ? (BucketDetailsPanel()..itemId = props.selectedItemId)()
          : null
      ),
    );
  },
  _$_DesktopLayoutConfig, // ignore: undefined_identifier
);

// <div class="app">
//   <div class="lhp card card__scrollable">
//     <h2>Transactions</h2>
//     <div class="card__inner-scroll" data-fill="z">
//       ss
//     </div>
//   </div>
//   <div class="header">This is a header</div>
//   <div class="body" data-fill="body"></div>
//   <div class="rhp card card__scrollable">
//       <div class="card__inner-scroll" data-fill="two">
        
//       </div>
//   </div>
// </div>