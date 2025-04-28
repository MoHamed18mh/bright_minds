  import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // initialize of cache
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // save data in local database using key
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if(value is List<String>){
      return await sharedPreferences.setStringList(key, value);
    }else{
      throw Exception('Invalid value type');
    }
  }

  // get data already saved in  local database uing key
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // remov data using key
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // check if local database contains keys
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  // clear all data in the local database
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
