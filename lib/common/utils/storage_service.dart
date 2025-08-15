import "package:shared_preferences/shared_preferences.dart";

const cacheNumKey = "cacheNum";

class StorageService {
  static SharedPreferences? _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static int get cacheNum {
    if (_sharedPrefs == null) {
      throw Exception("StorageService not initialized. Call init() first.");
    }
    return _sharedPrefs!.getInt(cacheNumKey) ?? 0;
  }

  static Future<void> setCacheNum(int newCacheKey) async {
    if (_sharedPrefs == null) {
      throw Exception("StorageService not initialized. Call init() first.");
    }
    await _sharedPrefs!.setInt(cacheNumKey, newCacheKey);
  }
}
