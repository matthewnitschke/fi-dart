import 'package:built_value/built_value.dart';

part 'bucket_value.sg.g.dart';

abstract class BucketValue {}

abstract class StaticBucketValue extends BucketValue implements Built<StaticBucketValue, StaticBucketValueBuilder> {
  StaticBucketValue._();
  factory StaticBucketValue([void Function(StaticBucketValueBuilder) updates]) = _$StaticBucketValue;
}