import 'package:built_collection/built_collection.dart';
import 'package:fi/src/app/models/app_state.sg.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

final Uuid _uuidGenerator = Uuid();
String newUuid() => _uuidGenerator.v4(options: {'rng': UuidUtil.cryptoRNG})?.toString();

final useAppSelector = createSelectorHook<AppState>();

TValue useEqualitySelector<TValue>(TValue Function(AppState) selector) {
  return useAppSelector(
    selector,
    (a, b) {
      // this works for most built value equalities
      return a == b;
    }
  );
}

extension BuiltMapExtendsions<K, V> on BuiltMap<K, V> {
  Iterable<R> mapKV<R>(Function(K, V) runner) {
    return this.keys.map((key) {
      return runner(key, this[key]);
    });
  }
}

extension MapExtendsions<K, V> on Map<K, V> {
  Iterable<R> mapKV<R>(Function(K, V) runner) {
    return this.keys.map((key) {
      return runner(key, this[key]);
    });
  }
}

