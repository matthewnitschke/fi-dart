import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'app_state.sg.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltMap<String, Item> get items;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}

abstract class Item  {
  String label;
}

abstract class BucketGroup implements Built<BucketGroup, BucketGroupBuilder> {

  BuiltList<Item> get items;

  BucketGroup._();
  factory BucketGroup([void Function(BucketGroupBuilder) updates]) = _$BucketGroup;
}

abstract class Bucket with Item implements Built<Bucket, BucketBuilder> {

  BucketValue get value;  

  Bucket._();
  factory Bucket([void Function(BucketBuilder) updates]) = _$Bucket;
}

abstract class BucketValue {}

abstract class StaticBucketValue extends BucketValue implements Built<StaticBucketValue, StaticBucketValueBuilder> {
  StaticBucketValue._();
  factory StaticBucketValue([void Function(StaticBucketValueBuilder) updates]) = _$StaticBucketValue;
}