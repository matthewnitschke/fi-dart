import 'package:built_collection/built_collection.dart';

extension MapExtensions<K, V> on Map<K, V> {
  Iterable<R> mapKV<R>(Function(K, V) runner) {
    return this.keys.map((key) {
      return runner(key, this[key]);
    });
  }

  V firstValueWhere(bool Function(K, V) test, {V Function() orElse}) {
    final key = keys.firstWhere(
      (key) {
        final value = this[key];
        return test(key, value);
      }, 
      orElse: () => null,
    );

    if (key == null) return orElse?.call();

    return key != null ? this[key] : null;
  }
}


extension BuiltMapExtendsions<K, V> on BuiltMap<K, V> {
  Iterable<R> mapKV<R>(R Function(K, V) runner) {
    return this.keys.map((key) {
      return runner(key, this[key]);
    });
  }
}

// extension IterableExtensions<V> on Iterable<V> {
//   Map<K, V> toMap<K>(MapEntry<K, V> Function(V ) runner) {
//     map(())
//   }
// }