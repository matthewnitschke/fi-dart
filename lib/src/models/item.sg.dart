
import 'package:built_value/built_value.dart';

part 'item.sg.g.dart';

@BuiltValue(instantiable: false)
abstract class Item extends Object {
  String get label;

  Item rebuild(void Function(ItemBuilder) updates);
  ItemBuilder toBuilder();
}