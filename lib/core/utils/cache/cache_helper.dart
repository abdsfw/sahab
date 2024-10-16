import 'dart:developer';
import 'package:sahab_project/core/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> cacheInit() async {
    log('init cash helper');
    sharedPreferences = await SharedPreferences.getInstance();
    // await setData(key: Constant.kUserId, value: 5);
    // print("setid seccess");
    var lang = getData(key: Constant.kLang);
    if (lang == null) {
      setData(key: Constant.kLang, value: 'en');
    }
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> clearCashe() async {
    await sharedPreferences.clear();
  }

  static Future<void> clearUserData() async {
    await deleteData(key: Constant.kUserId);
    await deleteData(key: Constant.kUserName);
    await deleteData(key: Constant.kUserPhoneNumber);
    await deleteData(key: Constant.kUserRole);
    await deleteData(key: Constant.kUserEmail);
    await deleteData(key: Constant.kUserImage);
    await deleteData(key: Constant.kToken);
    await deleteData(key: Constant.kUserRole);
  }
}
