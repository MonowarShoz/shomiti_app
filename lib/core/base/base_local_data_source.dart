import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/shared_pref_helper.dart';
import 'package:imsomitiapp/core/helper/shared_preferences_keys.dart';


class BaseLocalDataSource {
  final SharedPrefHelper? prefs;
  BaseLocalDataSource({this.prefs});

  Future<void> storeToken(String value) async {
    try {
      await prefs?.setData(SharedPreferencesKeys.token, value);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }

  Future<String?> getAuthToken()async{
     try {
      return await prefs?.getString(SharedPreferencesKeys.token,);
    } catch (e) {
      debugPrint("fetch pref username  : $e");
      return null;
    }

  }

  Future<void> storeUserInfo(String userData) async {
    try {
      await prefs?.setData(SharedPreferencesKeys.userData, userData);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }


  Future<String?> getuserName() async {
    try {
      return await prefs?.getString(SharedPreferencesKeys.userName,);
    } catch (e) {
      debugPrint("fetch pref username  : $e");
      return null;
    }
  }
  Future<String?> getuserInfo() async {
    try {
      return await prefs?.getString(SharedPreferencesKeys.userData);
    } catch (e) {
      debugPrint("fetch pref userInfo  : $e");
      return null;
    }
  }

  Future<void> storePassword(String value) async {
    try {
      await prefs?.setData(SharedPreferencesKeys.password, value);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }

  Future<void> storeIsUser(bool value) async {
    try {
      await prefs?.setData(SharedPreferencesKeys.isUserStored, value);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }

  Future<void> storeOnboarding(bool value) async {
    try {
      await prefs?.setData(SharedPreferencesKeys.isOnboardingShowed, value);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }

  Future<void> logoutAndClearCache() async {
    await prefs?.clearAllData();
  }
}
