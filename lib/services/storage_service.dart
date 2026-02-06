import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// StorageService keeps all read/write logic in one place and provide helpers.
class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<bool> setJson(String key, Object value) async {
    await init();
    return _preferences!.setString(key, jsonEncode(value));
  }

  T? getJson<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    final str = _preferences?.getString(key);
    if (str == null) return null;
    final map = jsonDecode(str) as Map<String, dynamic>;
    return fromMap(map);
  }

  Future<bool> setJsonList(String key, List<Object> values) async {
    await init();
    return _preferences!.setString(key, jsonEncode(values));
  }

  List<T> getJsonList<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    final str = _preferences?.getString(key);
    if (str == null) return <T>[];
    final list = jsonDecode(str) as List<dynamic>;
    return list
        .map((e) => fromMap(e as Map<String, dynamic>))
        .toList(growable: true);
  }

  Future<bool> remove(String key) async {
    await init();
    return _preferences!.remove(key);
  }
}
