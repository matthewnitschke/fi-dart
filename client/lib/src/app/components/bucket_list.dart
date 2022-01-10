import 'package:fi/src/app/components/bucket_container.dart';
import 'package:fi/src/app/components/bucket_group_container.dart';
import 'package:fi/src/app/components/root_new_button.dart';
import 'package:fi/src/app/components/utils/sortable_card.dart';
import 'package:fi/src/app/models/bucket_group.sg.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:collection/collection.dart';

part 'bucket_list.over_react.g.dart';

mixin BucketListProps on UiProps {}

UiFactory<BucketListProps> BucketList = uiFunction(
  (props) {
    final rootItemIds = useEqualitySelector((state) => state.rootItemIds);
    final rootItemBucketGroupIds = useAppSelector<List<String>>(
        (state) => state.rootItemIds
            .where((itemId) => state.items[itemId] is BucketGroup)
            .toList(),
        (a, b) => ListEquality().equals(a, b));
        
    return Fragment()(
      rootItemIds.map((itemId) {
        return (SortableCard()
            ..key = itemId
            ..className = 'item-layout__card'
          )(
            rootItemBucketGroupIds.contains(itemId) ? (BucketGroupContainer()..itemId = itemId)() : (BucketContainer()..itemId = itemId)()
          );
      }), 
      RootNewButton()()
    );
  },
  _$BucketListConfig, // ignore: undefined_identifier
);
