import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'bucket_value.sg.g.dart';

abstract class BucketValue {}

abstract class StaticBucketValue extends BucketValue implements Built<StaticBucketValue, StaticBucketValueBuilder> {
  int get amount;

  static void _initializeBuilder(StaticBucketValueBuilder b) => b
    ..amount = 0;

  StaticBucketValue._();
  factory StaticBucketValue([void Function(StaticBucketValueBuilder) updates]) = _$StaticBucketValue;
}

abstract class IncomeBucketValue extends BucketValue implements Built<IncomeBucketValue, IncomeBucketValueBuilder> {
  int get amount;

  static void _initializeBuilder(IncomeBucketValueBuilder b) => b
    ..amount = 0;

  IncomeBucketValue._();
  factory IncomeBucketValue([void Function(IncomeBucketValueBuilder) updates]) = _$IncomeBucketValue;
}

abstract class TableBucketValue extends BucketValue implements Built<TableBucketValue, TableBucketValueBuilder> {
  BuiltList<MapEntry<String, double>> get entries;

  static void _initializeBuilder(TableBucketValueBuilder b) => b
    ..entries = ListBuilder<MapEntry<String, double>>();

  TableBucketValue._();
  factory TableBucketValue([void Function(TableBucketValueBuilder) updates]) = _$TableBucketValue;
}

abstract class ExtraBucketValue extends BucketValue implements Built<ExtraBucketValue, ExtraBucketValueBuilder> {
  ExtraBucketValue._();
  factory ExtraBucketValue([void Function(ExtraBucketValueBuilder) updates]) = _$ExtraBucketValue;
}