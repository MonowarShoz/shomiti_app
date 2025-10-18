import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;
  SharedPrefHelper(this._prefs);

   Future<void> setData(String key, dynamic value) async {
  if (value is String) {
    await _prefs.setString(key, value);
  } else if (value is int) {
    await _prefs.setInt(key, value);
  } else if (value is bool) {
    await _prefs.setBool(key, value);
  } else if (value is double) {
    await _prefs.setDouble(key, value);
  } else {
    throw UnsupportedError('Unsupported value type: ${value.runtimeType}');
  }
}

  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAllData() async {
    await _prefs.clear();
   
  }

  Future<T> getValue<T>(String key, T defaultValue) async {
    final actions = {
      bool: _prefs.getBool,
      double: _prefs.getDouble,
      int: _prefs.getInt,
      String: _prefs.getString,
    };

    return (actions[T]?.call(key) as T?) ?? defaultValue;
  }

  Future<bool> getBool(String key) async {
    return _prefs.getBool(key) ?? false;
  }

  Future<String> getString(String key) async {
    return _prefs.getString(key) ?? '';
  }

  Future<int> getInt(String key) async {
    return _prefs.getInt(key) ?? 0;
  }

  Future<double> getDouble(String key) async {
    return _prefs.getDouble(key) ?? 0.0;
  }


}