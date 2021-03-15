import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'item.sg.dart';

part 'bucket_group.sg.g.dart';

abstract class BucketGroup extends Object implements Item, Built<BucketGroup, BucketGroupBuilder> {
  BuiltList<String> get itemIds;

  BucketGroup._();
  factory BucketGroup([void Function(BucketGroupBuilder) updates]) = _$BucketGroup;
}