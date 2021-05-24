import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/bucket_group.sg.dart';
import 'package:fi/src/app/models/bucket_value.sg.dart';
import 'package:fi/src/app/redux/borrows/borrows.actions.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'bucket_borrow_list.over_react.g.dart';

mixin BucketBorrowListProps on UiProps {
  String itemId;
}

UiFactory<BucketBorrowListProps> BucketBorrowList = uiFunction(
  (props) {
    final dispatch = useDispatch();
    
    final items = useAppSelector((state) => state.items);
    final rootItemIds = useAppSelector((state) => state.rootItemIds);

    final additions = useAppSelector(
      (state) {
        return state.borrows.values.where((borrow) => borrow.toId == props.itemId);
      },
    );

    final subtractions = useAppSelector(
      (state) => state.borrows.values.where((borrow) => borrow.fromId == props.itemId)
    );

    final selectedBorrowBucket = useState(items.keys.first);
    final borrowAmount = useState('');
    void _resetBorrowInput() {
      selectedBorrowBucket.set(items.keys.first);
      borrowAmount.set('');
    }
    useEffect(_resetBorrowInput, [props.itemId]);

    return Dom.div()(
      Dom.h3()('Additions'),
      additions.map((b) => Dom.div()('+ \$${b.amount} from ${items[b.fromId].label}')),

      Dom.h3()('Subtractions'),
      subtractions.map((b) => Dom.div()('- \$${b.amount} from ${items[b.toId].label}')),

      Dom.h3()('Borrow From'),
      (Dom.select()
         ..value = selectedBorrowBucket.value
        ..onChange = ((e) => selectedBorrowBucket.set(e.target.value))
      )(
        rootItemIds.fold<List<ReactElement>>(<ReactElement>[], (acc, itemId) {
          final item = items[itemId];

          ReactElement _renderOption(String itemId) {
            return (Dom.option()
              ..key = itemId
              ..value = itemId
            )(items[itemId].label);
          }

          if (item is BucketGroup) {
            final subItemIds = item.itemIds.where(
              (subItemId) {
                final item = items[subItemId];
                if (subItemId == props.itemId) return false; 
                if (item is! Bucket) return false;
                if ((item as Bucket).value is IncomeBucketValue) return false;
                return true;
              }
            );

            if (subItemIds.isNotEmpty) {
              acc.add(
                (Dom.optgroup()
                  ..label = items[itemId].label
                )(
                  subItemIds.map(
                    (subItemId) => _renderOption(subItemId),
                  )
                )
              );
            }

          } else if ((item as Bucket).value is! IncomeBucketValue && itemId != props.itemId) {
            acc.add(_renderOption(itemId));
          }

          return acc;
        })
      ),
      (Dom.input()
        ..placeholder = 'Amount'
        ..value = borrowAmount.value
        ..onChange = ((e) => borrowAmount.set(e.target.value))
      )(),
      (Dom.button()
        ..onClick = ((_) {
          dispatch(AddBorrowAction(
            selectedBorrowBucket.value,
            props.itemId,
            double.parse(borrowAmount.value)
          ));
          _resetBorrowInput();
        })
      )('Borrow'),
    );
  },
  _$BucketBorrowListConfig, // ignore: undefined_identifier
);
