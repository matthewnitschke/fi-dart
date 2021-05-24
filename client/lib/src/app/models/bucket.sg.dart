import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fi/src/app/models/item.sg.dart';

import 'bucket_value.sg.dart';

part 'bucket.sg.g.dart';

abstract class Bucket extends Object implements Item, Built<Bucket, BucketBuilder> {

  BucketValue get value;

  BuiltList<String> get transactions;

  static Serializer<Bucket> get serializer => _$bucketSerializer;

  Bucket._();
  factory Bucket([void Function(BucketBuilder) updates]) = _$Bucket;
}