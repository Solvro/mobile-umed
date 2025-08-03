import "package:shared_preferences/shared_preferences.dart";

const cacheKey = "cacheNum";

class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  int get cacheNum => _prefs.getInt(cacheKey) ?? -1;

  Future<void> setCacheNum(int newCacheKey) async {
    await _prefs.setInt(cacheKey, newCacheKey);
  }
}
