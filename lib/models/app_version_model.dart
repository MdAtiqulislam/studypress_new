// To parse this JSON data, do
//
//     final appVersionModel = appVersionModelFromJson(jsonString);

import 'dart:convert';

AppVersionModel appVersionModelFromJson(String str) => AppVersionModel.fromJson(json.decode(str));

String appVersionModelToJson(AppVersionModel data) => json.encode(data.toJson());

class AppVersionModel {
  AppVersionModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  AppVersionModelData? data;

  factory AppVersionModel.fromJson(Map<String, dynamic> json) => AppVersionModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : AppVersionModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class AppVersionModelData {
  AppVersionModelData({
    this.verstionControlData,
  });

  VerstionControlData? verstionControlData;

  factory AppVersionModelData.fromJson(Map<String, dynamic> json) => AppVersionModelData(
    verstionControlData: json["verstion_control_data"] == null ? null : VerstionControlData.fromJson(json["verstion_control_data"]),
  );

  Map<String, dynamic> toJson() => {
    "verstion_control_data": verstionControlData?.toJson(),
  };
}

class VerstionControlData {
  VerstionControlData({
    this.headers,
    this.original,
    this.exception,
  });

  Headers? headers;
  Original? original;
  dynamic exception;

  factory VerstionControlData.fromJson(Map<String, dynamic> json) => VerstionControlData(
    headers: json["headers"] == null ? null : Headers.fromJson(json["headers"]),
    original: json["original"] == null ? null : Original.fromJson(json["original"]),
    exception: json["exception"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers?.toJson(),
    "original": original?.toJson(),
    "exception": exception,
  };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Original {
  Original({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  OriginalData? data;

  factory Original.fromJson(Map<String, dynamic> json) => Original(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : OriginalData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class OriginalData {
  OriginalData({
    this.current,
    this.version,
    this.androidTestVersion,
    this.iosVersion,
    this.iosTestVersion,
    this.enable,
    this.majorMsg,
    this.minorMsg,
  });

  String? current;
  String? version;
  dynamic androidTestVersion;
  dynamic iosVersion;
  dynamic iosTestVersion;
  bool? enable;
  OrMsg? majorMsg;
  OrMsg? minorMsg;

  factory OriginalData.fromJson(Map<String, dynamic> json) => OriginalData(
    current: json["current"],
    version: json["version"],
    androidTestVersion: json["android_test_version"],
    iosVersion: json["ios_version"],
    iosTestVersion: json["ios_test_version"],
    enable: json["enable"],
    majorMsg: json["majorMsg"] == null ? null : OrMsg.fromJson(json["majorMsg"]),
    minorMsg: json["minorMsg"] == null ? null : OrMsg.fromJson(json["minorMsg"]),
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "version": version,
    "android_test_version": androidTestVersion,
    "ios_version": iosVersion,
    "ios_test_version": iosTestVersion,
    "enable": enable,
    "majorMsg": majorMsg?.toJson(),
    "minorMsg": minorMsg?.toJson(),
  };
}

class OrMsg {
  OrMsg({
    this.title,
    this.msg,
    this.button,
    this.url,
  });

  String? title;
  String? msg;
  String? button;
  Url? url;

  factory OrMsg.fromJson(Map<String, dynamic> json) => OrMsg(
    title: json["title"],
    msg: json["msg"],
    button: json["button"],
    url: json["url"] == null ? null : Url.fromJson(json["url"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "msg": msg,
    "button": button,
    "url": url?.toJson(),
  };
}

class Url {
  Url({
    this.apk,
    this.ios,
  });

  String? apk;
  String? ios;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    apk: json["apk"],
    ios: json["ios"],
  );

  Map<String, dynamic> toJson() => {
    "apk": apk,
    "ios": ios,
  };
}
