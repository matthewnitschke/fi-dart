import 'package:fi/src/app/components/details_panel/create_borrow_input.dart';
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
    final additionIds = useAppSelector(
      (state) => state.borrows.keys.where(
        (borrowId) => state.borrows[borrowId].toId == props.itemId
      )
    );

    final subtractionIds = useAppSelector(
      (state) => state.borrows.keys.where(
        (borrowId) => state.borrows[borrowId].fromId == props.itemId
      )
    );

    final itemBorrows = useAppSelector((state) => state.borrows.keys.where(
      (borrowId) => [state.borrows[borrowId].toId, state.borrows[borrowId].fromId].contains(props.itemId)
    ));

    return Dom.div()(
      Dom.h3()('Borrows'),
      itemBorrows.map((id) => (BorrowEntry()
        ..borrowId = id
        ..itemId = props.itemId
      )()),
      // additionIds.map((id) => (BorrowEntry()
      //   ..borrowId = id
      //   ..itemId = props.itemId
      // )()),

      // Dom.h3()('Subtractions'),
      // subtractionIds.map((id) => (BorrowEntry()
      //   ..borrowId = id
      //   ..itemId = props.itemId
      // )()),

      Dom.h3()('Borrow From'),
      (CreateBorrowInput()..itemId = props.itemId)()
    );
  },
  _$BucketBorrowListConfig, // ignore: undefined_identifier
);


mixin BorrowEntryProps on UiProps {
  String borrowId;
  String itemId;
}

UiFactory<BorrowEntryProps> BorrowEntry = uiFunction(
  (props) {
    final dispatch = useDispatch();

    final borrow = useAppSelector((state) => state.borrows[props.borrowId]);
    final items = useAppSelector((state) => state.items);
    
    final isAddition = borrow.toId == props.itemId;

    return (Dom.div())(
      (Dom.span()
        ..style = {'color': isAddition? 'var(--green)' : 'var(--red)'}
      )('\$${borrow.amount}'),
      ' from ${items[isAddition ? borrow.fromId : borrow.toId].label} ',
      (Dom.i()
        ..className = 'far fa-trash-alt'
        ..onClick = ((_) => dispatch(DeleteBorrowAction(props.borrowId)))
      )(),
    );
  },
  _$BorrowEntryConfig, // ignore: undefined_identifier
);
