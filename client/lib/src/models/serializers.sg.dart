import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fi/src/models/account.sg.dart';

part 'serializers.sg.g.dart';

@SerializersFor([Account])
Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
