import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bucket_value.sg.g.dart';

abstract class BucketValue {
  String get name;
}

abstract class StaticBucketValue implements BucketValue, Built<StaticBucketValue, StaticBucketValueBuilder> {
  double get amount;

  static void _initializeBuilder(StaticBucketValueBuilder b) => b
    ..amount = 0
    ..name = 'static';

  static Serializer<StaticBucketValue> get serializer => _$staticBucketValueSerializer;

  StaticBucketValue._();
  factory StaticBucketValue([void Function(StaticBucketValueBuilder) updates]) = _$StaticBucketValue;
}

abstract class IncomeBucketValue implements BucketValue, Built<IncomeBucketValue, IncomeBucketValueBuilder> {
  double get amount;

  static void _initializeBuilder(IncomeBucketValueBuilder b) => b
    ..amount = 0
    ..name = 'income';

  static Serializer<IncomeBucketValue> get serializer => _$incomeBucketValueSerializer;

  IncomeBucketValue._();
  factory IncomeBucketValue([void Function(IncomeBucketValueBuilder) updates]) = _$IncomeBucketValue;
}

abstract class TableBucketValue implements BucketValue, Built<TableBucketValue, TableBucketValueBuilder> {
  BuiltList<TableBucketValueEntry> get entries;

  static void _initializeBuilder(TableBucketValueBuilder b) => b
    ..name = 'table';

  static Serializer<TableBucketValue> get serializer => _$tableBucketValueSerializer;

  TableBucketValue._();
  factory TableBucketValue([void Function(TableBucketValueBuilder) updates]) = _$TableBucketValue;
}

abstract class TableBucketValueEntry implements Built<TableBucketValueEntry, TableBucketValueEntryBuilder> {
  String get name;

  double get amount;

  static void _initializeBuilder(TableBucketValueEntryBuilder b) => b
    ..name = ''
    ..amount = 0;

  static Serializer<TableBucketValueEntry> get serializer => _$tableBucketValueEntrySerializer;

  factory TableBucketValueEntry([void Function(TableBucketValueEntryBuilder) updates]) = _$TableBucketValueEntry;
  TableBucketValueEntry._();
}

abstract class ExtraBucketValue implements BucketValue, Built<ExtraBucketValue, ExtraBucketValueBuilder> {
  static void _initializeBuilder(ExtraBucketValueBuilder b) => b
    ..name = 'extra';

  static Serializer<ExtraBucketValue> get serializer => _$extraBucketValueSerializer;

  ExtraBucketValue._();
  factory ExtraBucketValue([void Function(ExtraBucketValueBuilder) updates]) = _$ExtraBucketValue;
}