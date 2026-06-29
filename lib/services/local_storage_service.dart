import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String boxName = 'luckyfit90';
  late final Box _box;
  Future<void> init() async { await Hive.initFlutter(); _box = await Hive.openBox(boxName); }
  T get<T>(String key, T fallback) => (_box.get(key) as T?) ?? fallback;
  Future<void> put(String key, Object? value) => _box.put(key, value);
  Future<void> clear() => _box.clear();
}
