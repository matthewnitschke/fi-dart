import 'package:fi/src/models/app_state.sg.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/models/bucket_value.sg.dart';

int bucketAmountSelector(AppState state, String bucketId) {
  if (state.items.containsKey(bucketId) && state.items[bucketId] is! Bucket) {
    throw Exception("itemId: $bucketId is not a Bucket type, cannot calculate amount");
  }

  final bucketValue = (state.items[bucketId] as Bucket).value;
  if (bucketValue is StaticBucketValue) {
    return bucketValue.amount;
  } else if (bucketValue is IncomeBucketValue) {
    return bucketValue.amount;
  } else if (bucketValue is TableBucketValue) {
    return bucketValue.entries.fold<double>(0.0, (acc, entry) => acc + entry.value).toInt();
  } else if (bucketValue is ExtraBucketValue) {

    final income = state.items.keys.fold<double>(0.0, (acc, itemId) {
      final item = state.items[itemId];
      if (item is Bucket && item.value is IncomeBucketValue) {
        acc += (item.value as IncomeBucketValue).amount;
      }
      return acc;
    });

    final expense = state.items.keys.fold<double>(0.0, (acc, itemId) {
      final item = state.items[itemId];
      if (item is Bucket && item.value is! IncomeBucketValue && item.value is! ExtraBucketValue) {
        acc += bucketAmountSelector(state, itemId);
      }
      return acc;
    });


    return (income - expense).toInt();
  } else {
    throw Exception('Unknown bucket value type ${bucketValue.runtimeType}');
  }
}