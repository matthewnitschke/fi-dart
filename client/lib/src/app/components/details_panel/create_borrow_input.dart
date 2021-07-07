import 'package:fi/src/app/components/utils/select.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/bucket_group.sg.dart';
import 'package:fi/src/app/models/bucket_value.sg.dart';
import 'package:fi/src/app/redux/borrows/borrows.actions.dart';
import 'package:fi/src/app/redux/selectors.dart';
import 'package:fi/src/app/utils.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'create_borrow_input.over_react.g.dart';

mixin CreateBorrowInputProps on UiProps {
  String itemId;
}

UiFactory<CreateBorrowInputProps> CreateBorrowInput = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final items = useAppSelector((state) => state.items);
    final rootItemIds = useAppSelector((state) => state.rootItemIds);

    final selectedBorrowBucket = useState<String>(null);
    final borrowAmount = useState('');
    void _resetBorrowInput() {
      selectedBorrowBucket.set(null);
      borrowAmount.set('');
    }
    useEffect(_resetBorrowInput, [props.itemId]);

    final itemAmount = useEqualitySelector((state) => bucketAmountSelector(state, props.itemId));
    final itemTransactionSum = useAppSelector(
      (state) => bucketTransactionsSum(state, props.itemId)
    );

    final selectedBucketOptions = rootItemIds.fold<Map<String, SelectOption>>(<String, SelectOption>{}, (acc, itemId) {
      final item = items[itemId];

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
          acc[itemId] = SelectOptionGroup(
            items[itemId].label,
            Map.fromIterable(
              subItemIds,
              key: (subItemId) => subItemId,
              value: (subItemId) => SelectOption(items[subItemId].label),
            )
          );
        }

      } else if ((item as Bucket).value is! IncomeBucketValue && itemId != props.itemId) {
        acc[itemId] = SelectOption(items[itemId].label);
      }

      return acc;
    });

    return Dom.div()(
      (Select()
        ..onOptionSelect = ((value) => selectedBorrowBucket.set(value))
          ..options = selectedBucketOptions
          ..selectedOption = selectedBorrowBucket.value
          ..style = {'marginBottom': '.5rem'}
      )(),
      (Dom.div()
        ..style = {'display': 'flex', 'marginBottom': '.5rem'}
      )(
        (Dom.input()
          ..className = 'text-input__amount'
          ..type = 'number'
          ..placeholder = 'Amount'
          ..value = borrowAmount.value
          ..onChange = ((e) => borrowAmount.set(e.target.value))
        )(),
        (Dom.button()
          ..className = 'form-button'
          ..onClick = ((_) {
            borrowAmount.set((itemTransactionSum - itemAmount).toString());
          })
          ..style = {'marginLeft': '.5rem'}
          ..disabled = itemTransactionSum <= itemAmount
      )('Difference')
      ),
      (Dom.button()
        ..className = 'form-button form-button__primary'
        ..disabled = selectedBorrowBucket.value == null
        ..onClick = ((_) {
          if (selectedBorrowBucket.value != null) {
            dispatch(AddBorrowAction(
              selectedBorrowBucket.value,
              props.itemId,
              double.parse(borrowAmount.value)
            ));
            _resetBorrowInput();
          }
        })
      )('Borrow'),
    );
  },
  _$CreateBorrowInputConfig, // ignore: undefined_identifier
);
