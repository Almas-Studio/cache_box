import 'package:hive/hive.dart';

class CacheBox {
  final Box _box;

  CacheBox._(this._box);

  static Future<CacheBox> open(String boxName,
      {String? path}) async {
    final box = await Hive.openBox(boxName, path: path);
    return CacheBox._(box);
  }

  Future<void> put(String key, value) {
    return _box.put(key, value);
  }

  Stream<T?> get<T>(String key, {T? defaultValue}) async* {
    yield (_box.get(key, defaultValue: defaultValue) as T?);
    yield* _box.watch(key: key).map((event) => event.value);
  }

  Future<void> delete() {
    return _box.deleteFromDisk();
  }

  Future<void> clear() {
    return _box.clear();
  }
}
