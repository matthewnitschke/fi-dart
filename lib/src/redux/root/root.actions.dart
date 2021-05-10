class LoadStateAction {

  // final String encodedItems;
  // final String encodedRootItemIds;
  // final String encodedTransactions;

  final String encodedState;

  LoadStateAction(this.encodedState);
}

class SelectItemAction {
  final String itemId;
  
  SelectItemAction(this.itemId);
}