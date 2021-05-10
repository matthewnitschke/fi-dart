import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fi/src/models/app_state.sg.dart';
import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/models/bucket_group.sg.dart';
import 'package:fi/src/models/bucket_value.sg.dart';
import 'package:fi/src/models/item.sg.dart';
import 'package:fi/src/models/transaction.sg.dart';

part 'serializers.sg.g.dart';

@SerializersFor([
  AppState,
  BuiltMap,
  BuiltList,
  BucketGroup,
  IncomeBucketValue,
  StaticBucketValue,
  TableBucketValue,
  TableBucketValueEntry,
  ExtraBucketValue,
  Bucket,
  Transaction,
])
Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();