import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fi/src/app/models/app_state.sg.dart';
import 'package:fi/src/app/models/borrow.sg.dart';
import 'package:fi/src/app/models/bucket.sg.dart';
import 'package:fi/src/app/models/bucket_group.sg.dart';
import 'package:fi/src/app/models/bucket_value.sg.dart';
import 'package:fi/src/app/models/item.sg.dart';
import 'package:fi/src/app/models/transaction.sg.dart';

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
  Borrow,
])

Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();