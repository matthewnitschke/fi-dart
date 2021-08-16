// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(Item)])),
      'rootItemIds',
      serializers.serialize(object.rootItemIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'ignoredTransactions',
      serializers.serialize(object.ignoredTransactions,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(String)])),
      'borrows',
      serializers.serialize(object.borrows,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(Borrow)])),
    ];
    if (object.selectedMonth != null) {
      result
        ..add('selectedMonth')
        ..add(serializers.serialize(object.selectedMonth,
            specifiedType: const FullType(DateTime)));
    }
    if (object.selectedItemId != null) {
      result
        ..add('selectedItemId')
        ..add(serializers.serialize(object.selectedItemId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'selectedMonth':
          result.selectedMonth = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'selectedItemId':
          result.selectedItemId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(Item)])));
          break;
        case 'rootItemIds':
          result.rootItemIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'ignoredTransactions':
          result.ignoredTransactions.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(String)]))
              as BuiltSet<Object>);
          break;
        case 'borrows':
          result.borrows.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(Borrow)])));
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final DateTime selectedMonth;
  @override
  final bool isDraggingTransaction;
  @override
  final String selectedItemId;
  @override
  final BuiltMap<String, Item> items;
  @override
  final BuiltList<String> rootItemIds;
  @override
  final BuiltMap<String, Transaction> transactions;
  @override
  final BuiltSet<String> ignoredTransactions;
  @override
  final BuiltMap<String, Borrow> borrows;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.selectedMonth,
      this.isDraggingTransaction,
      this.selectedItemId,
      this.items,
      this.rootItemIds,
      this.transactions,
      this.ignoredTransactions,
      this.borrows})
      : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('AppState', 'items');
    }
    if (rootItemIds == null) {
      throw new BuiltValueNullFieldError('AppState', 'rootItemIds');
    }
    if (ignoredTransactions == null) {
      throw new BuiltValueNullFieldError('AppState', 'ignoredTransactions');
    }
    if (borrows == null) {
      throw new BuiltValueNullFieldError('AppState', 'borrows');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        selectedMonth == other.selectedMonth &&
        isDraggingTransaction == other.isDraggingTransaction &&
        selectedItemId == other.selectedItemId &&
        items == other.items &&
        rootItemIds == other.rootItemIds &&
        transactions == other.transactions &&
        ignoredTransactions == other.ignoredTransactions &&
        borrows == other.borrows;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, selectedMonth.hashCode),
                                isDraggingTransaction.hashCode),
                            selectedItemId.hashCode),
                        items.hashCode),
                    rootItemIds.hashCode),
                transactions.hashCode),
            ignoredTransactions.hashCode),
        borrows.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('selectedMonth', selectedMonth)
          ..add('isDraggingTransaction', isDraggingTransaction)
          ..add('selectedItemId', selectedItemId)
          ..add('items', items)
          ..add('rootItemIds', rootItemIds)
          ..add('transactions', transactions)
          ..add('ignoredTransactions', ignoredTransactions)
          ..add('borrows', borrows))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  DateTime _selectedMonth;
  DateTime get selectedMonth => _$this._selectedMonth;
  set selectedMonth(DateTime selectedMonth) =>
      _$this._selectedMonth = selectedMonth;

  bool _isDraggingTransaction;
  bool get isDraggingTransaction => _$this._isDraggingTransaction;
  set isDraggingTransaction(bool isDraggingTransaction) =>
      _$this._isDraggingTransaction = isDraggingTransaction;

  String _selectedItemId;
  String get selectedItemId => _$this._selectedItemId;
  set selectedItemId(String selectedItemId) =>
      _$this._selectedItemId = selectedItemId;

  MapBuilder<String, Item> _items;
  MapBuilder<String, Item> get items =>
      _$this._items ??= new MapBuilder<String, Item>();
  set items(MapBuilder<String, Item> items) => _$this._items = items;

  ListBuilder<String> _rootItemIds;
  ListBuilder<String> get rootItemIds =>
      _$this._rootItemIds ??= new ListBuilder<String>();
  set rootItemIds(ListBuilder<String> rootItemIds) =>
      _$this._rootItemIds = rootItemIds;

  MapBuilder<String, Transaction> _transactions;
  MapBuilder<String, Transaction> get transactions =>
      _$this._transactions ??= new MapBuilder<String, Transaction>();
  set transactions(MapBuilder<String, Transaction> transactions) =>
      _$this._transactions = transactions;

  SetBuilder<String> _ignoredTransactions;
  SetBuilder<String> get ignoredTransactions =>
      _$this._ignoredTransactions ??= new SetBuilder<String>();
  set ignoredTransactions(SetBuilder<String> ignoredTransactions) =>
      _$this._ignoredTransactions = ignoredTransactions;

  MapBuilder<String, Borrow> _borrows;
  MapBuilder<String, Borrow> get borrows =>
      _$this._borrows ??= new MapBuilder<String, Borrow>();
  set borrows(MapBuilder<String, Borrow> borrows) => _$this._borrows = borrows;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _selectedMonth = _$v.selectedMonth;
      _isDraggingTransaction = _$v.isDraggingTransaction;
      _selectedItemId = _$v.selectedItemId;
      _items = _$v.items?.toBuilder();
      _rootItemIds = _$v.rootItemIds?.toBuilder();
      _transactions = _$v.transactions?.toBuilder();
      _ignoredTransactions = _$v.ignoredTransactions?.toBuilder();
      _borrows = _$v.borrows?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              selectedMonth: selectedMonth,
              isDraggingTransaction: isDraggingTransaction,
              selectedItemId: selectedItemId,
              items: items.build(),
              rootItemIds: rootItemIds.build(),
              transactions: _transactions?.build(),
              ignoredTransactions: ignoredTransactions.build(),
              borrows: borrows.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'rootItemIds';
        rootItemIds.build();
        _$failedField = 'transactions';
        _transactions?.build();
        _$failedField = 'ignoredTransactions';
        ignoredTransactions.build();
        _$failedField = 'borrows';
        borrows.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
