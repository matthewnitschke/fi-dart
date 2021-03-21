import 'package:built_value/built_value.dart';
import 'package:fi/src/models/item.sg.dart';

import 'bucket_value.sg.dart';

part 'bucket.sg.g.dart';

abstract class Bucket extends Object implements Item, Built<Bucket, BucketBuilder> {

  BucketValue get value;

  Bucket._();
  factory Bucket([void Function(BucketBuilder) updates]) = _$Bucket;
}