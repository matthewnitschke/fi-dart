import 'package:fi/src/utils.dart';

class AddBucketGroupAction {
  final String itemId;
  final String label;

  AddBucketGroupAction({
    String itemId,
    this.label = '',
  }) :
    this.itemId = itemId ?? newUuid();
}

class AddBucketAction {
  final String itemId;
  final String label;
  final String parentId;

  AddBucketAction({
    String itemId,
    this.label = '',
    this.parentId
  }) : 
    this.itemId = itemId ?? newUuid();
}

class SetItemLabelAction {
  final String itemId;
  final String label;

  SetItemLabelAction(this.itemId, this.label);
}