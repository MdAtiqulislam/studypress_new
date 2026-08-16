// To parse this JSON data, do
//
//     final appLinksModel = appLinksModelFromJson(jsonString);

import 'dart:convert';

AppLinksModel appLinksModelFromJson(String str) => AppLinksModel.fromJson(json.decode(str));

String appLinksModelToJson(AppLinksModel data) => json.encode(data.toJson());

class AppLinksModel {
  AppLinksModel({
    this.success,
    this.msg,
    this.androidAppLink,
    this.androidPackageId,
    this.iosAppId,
    this.iosAppLink,
  });

  bool? success;
  String? msg;
  String? androidAppLink;
  String? androidPackageId;
  String? iosAppId;
  String? iosAppLink;

  factory AppLinksModel.fromJson(Map<String, dynamic> json) => AppLinksModel(
    success: json["success"],
    msg: json["msg"],
    androidAppLink: json["android_app_link"],
    androidPackageId: json["android_package_id"],
    iosAppId: json["ios_app_id"],
    iosAppLink: json["ios_app_link"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "android_app_link": androidAppLink,
    "android_package_id": androidPackageId,
    "ios_app_id": iosAppId,
    "ios_app_link": iosAppLink,
  };
}
