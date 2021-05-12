import 'package:fi/src/components/bucket_container.dart';
import 'package:fi/src/components/details_panel/bucket_details_panel.dart';
import 'package:fi/src/components/bucket_group_container.dart';
import 'package:fi/src/components/month_selector.dart';
import 'package:fi/src/components/root_new_button.dart';
import 'package:fi/src/components/transactions_panel/transactions_panel.dart';
import 'package:fi/src/components/utils/sortable_card.dart';
import 'package:fi/src/models/bucket_group.sg.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:collection/collection.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction(
  (props) {
    final rootItemIds = useEqualitySelector(
      (state) => state.rootItemIds
    );

    final selectedItemId = useAppSelector(
      (state) => state.selectedItemId
    );

    final rootItemBucketGroupIds = useAppSelector<List<String>>(
      (state) => state.rootItemIds
        .where((itemId) => state.items[itemId] is BucketGroup)
        .toList(),
      (a, b) => ListEquality().equals(a, b)
    );

    return (Dom.div()
      ..className = 'main-content'
    )(
      (Dom.div()
        ..className = 'header'
      )(MonthSelector()()),
      // TODO: Fix this weirdness
      Dom.div()(),
      Dom.div()(),
      Dom.div()(),
      Dom.div()(),
      (Dom.div()
        ..className = 'lhp'
      )(
        TransactionsPanel()()
      ),
      (Dom.div()..className = 'body')(
        rootItemIds.map((itemId) {
          return (SortableCard()
            ..key = itemId
            ..className = 'item-layout__card'
          )(
            rootItemBucketGroupIds.contains(itemId) ? 
              (BucketGroupContainer()
                ..itemId = itemId
              )() :
              (BucketContainer()
                ..itemId = itemId
              )()
          );
        }),
        RootNewButton()()
      ),
      (Dom.div()
        ..className = 'rhp'
      )(
        selectedItemId != null ? (BucketDetailsPanel()
          ..itemId = selectedItemId
        )() : null
      ),
    );
  },
  _$AppConfig, // ignore: undefined_identifier
);
