import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'item.sg.dart';

part 'bucket_group.sg.g.dart';

abstract class BucketGroup extends Object implements Item, Built<BucketGroup, BucketGroupBuilder> {
  BuiltList<String> get itemIds;

  static Serializer<BucketGroup> get serializer => _$bucketGroupSerializer;

  BucketGroup._();
  factory BucketGroup([void Function(BucketGroupBuilder) updates]) = _$BucketGroup;
}