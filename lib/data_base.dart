import 'dart:convert';

import 'package:dio/dio.dart' show Response;
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';


class _DataBaseKey {
  static String userInfo = "userInfo";
}


class DefaultDataBase extends DataBase {

  //用户信息
  get userInfo => getValue(_DataBaseKey.userInfo);
  //设置用户信息
  Future<bool> setUserInfo(String userInfo) async {
    return await saveValue(_DataBaseKey.userInfo, userInfo);
  }

  @override
  Future<Response> getDbResponse(String saveCode) async {
    var result = await getValue<String>(saveCode);
    if (result == null) return null;
    var decodeData = json.decode(result);
    return Response(data: {'data': decodeData}, statusCode: 200);
  }

  @override
  Future<T> getPageData<T>(String saveCode) async {
    var result = await getValue<String>(saveCode);
    if (result == null) return null;
    var decodeData = json.decode(result);
    return BaseConfig.entityBase.formJson<T>(decodeData);
  }

  @override
  Future<Map<String, dynamic>> hadLogin() async {
    String userInfo = await this.userInfo;
    if (userInfo != null && userInfo.isNotEmpty) {
      return {
        'userInfo': userInfo,
      };
    }
    return {};
  }

  @override
  void savePageData<T>(String saveCode, T t) {
//    dynamic result;
//    result = BaseConfig.entityBase.formJson<T>(json);
//    if (result.isEmpty) return;
    var encodeData = json.encode(t);
    saveValue(saveCode, encodeData);
  }
}


abstract class DataBase {
  void savePageData<T>(String saveCode, T t);
  Future<T> getPageData<T>(String saveCode);
  Future<Response> getDbResponse(String saveCode);
  Future<Map<String, dynamic>> hadLogin();
}

class Preferences {
  static SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    return prefs = await SharedPreferences.getInstance();
  }
}

Future<bool> saveValue(String key, dynamic value) async {
  if (Preferences.prefs == null) await Preferences.init();
  if (value is int)
    return await Preferences.prefs.setInt(key, value);
  else if (value is String)
    return await Preferences.prefs.setString(key, value);
  else if (value is bool)
    return await Preferences.prefs.setBool(key, value);
  else if (value is double)
    return await Preferences.prefs.setDouble(key, value);
  else if (value is List<String>)
    return await Preferences.prefs.setStringList(key, value);
  else
    return false;
}

Future<T> getValue<T>(String key) async {
  if (Preferences.prefs == null) await Preferences.init();
  return Preferences.prefs.get(key) as T;
}

Future<bool> containsKey(String key) async {
  if (Preferences.prefs == null) await Preferences.init();
  return Preferences.prefs.containsKey(key);
}

Future<bool> removeKey(String key) async {
  if (Preferences.prefs == null) await Preferences.init();
  return Preferences.prefs.remove(key);
}
