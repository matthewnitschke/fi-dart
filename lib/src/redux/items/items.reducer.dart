import 'package:built_collection/built_collection.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/models/bucket_group.sg.dart';
import 'package:fi/src/models/bucket_value.sg.dart';
import 'package:fi/src/models/item.sg.dart';
import 'package:fi/src/redux/items/items.actions.dart';
import 'package:redux/redux.dart';

class ItemsReducer {

  ItemsReducer();

  Reducer<BuiltMap<String, Item>> get reducer => combineReducers([
    TypedReducer<BuiltMap<String, Item>, AddBucketAction>(_onAddBucket),
    TypedReducer<BuiltMap<String, Item>, AddBucketGroupAction>(_onAddBucketGroup),
    TypedReducer<BuiltMap<String, Item>, SetItemLabelAction>(_onSetItemLabel),
  ]);

  BuiltMap<String, Item> _onAddBucket(BuiltMap<String, Item> state, AddBucketAction action) {
    final stateBuilder = state.toBuilder();

    stateBuilder[action.itemId] = Bucket((b) => b
      ..label = action.label
      ..value = StaticBucketValue((bv) => bv
        ..amount = 0
      )
    );

    if (action.parentId != null) {
      if (state.containsKey(action.parentId) && state[action.parentId] is BucketGroup) {
        final group = stateBuilder[action.parentId] as BucketGroup;
        stateBuilder[action.parentId] = group.rebuild((b) => b
          ..itemIds.add(action.itemId)
        );
      } else {
        throw Exception("Provided parentId is not found, or is not a BucketGroup item");
      }
    }

    return stateBuilder.build();
  }

  BuiltMap<String, Item> _onAddBucketGroup(BuiltMap<String, Item> state, AddBucketGroupAction action) {
    return state.rebuild((b) => b
      ..[action.itemId] = BucketGroup((bg) => bg
        ..label = action.label
      )
    );
  }

  BuiltMap<String, Item> _onSetItemLabel(BuiltMap<String, Item> state, SetItemLabelAction action) {
    return state.rebuild((b) => b
      ..[action.itemId] = b[action.itemId].rebuild((ib) => ib
        ..label = action.label
      )
    );
  }
}