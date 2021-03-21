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
  } else {
    throw Exception('Unknown bucket value type ${bucketValue.runtimeType}');
  }
}