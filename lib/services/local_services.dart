import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';

class LocalServices {
  static const _keyToken = 'token';
  static const _keyAssessmentStatus = 'assessmentStatus';
  static const _keyItemsOnCart = 'itemsOnCart';
  static const _keyUser = 'user';
  static const _userEnrollment = 'userEnrollment';
  static const _keyPreviousVersion = 'previousVersion';

  // write token
  static Future storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // read token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // write assessment status
  static Future storeAssessmentStatus(bool assessmentStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAssessmentStatus, assessmentStatus);
  }

  // read assessment status
  static Future<bool?> getAssessmentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAssessmentStatus);
  }

  // write app version
  static Future storeAppVersion(String appVersion) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPreviousVersion, appVersion);
  }

  // read app version
  static Future<String?> getPreviousAppVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPreviousVersion);
  }

  // write items on cart (as JSON string)
  static Future storeItemsOnCart(String itemsOnCart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyItemsOnCart, itemsOnCart);
  }

  // read items on cart
  static Future<String?> getItemsOnCart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyItemsOnCart);
  }

  // store user (as JSON string)
  static Future storeUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final value = json.encode(user);
    await prefs.setString(_keyUser, value);
  }

  // read user
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyUser);
    return value == null ? null : UserModel.fromJson(json.decode(value));
  }

  // store user enrollment (as JSON string)
  static Future storeUserEnrollment(UserEnrollmentDataModel2 userEnrollmentModel) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode(userEnrollmentModel);
    await prefs.setString(_userEnrollment, value);
  }

  // read user enrollment
  static Future<UserEnrollmentDataModel2?> getEnrollmentItems() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_userEnrollment);
    return value == null ? null : UserEnrollmentDataModel2.fromJson(json.decode(value));
  }

  // delete all keys
  static Future deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
