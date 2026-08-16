import 'dart:convert';

import 'package:studypress_new/models/user_enrollment_model.dart';
import 'package:studypress_new/models/user_model.dart';



RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    this.success,
    this.msg,
    this.data,
    this.studyGroups,
    this.userEnrollment,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  bool? success;
  String? msg;
  UserModel? data;
  List<dynamic>? studyGroups;
  UserEnrollmentModel ? userEnrollment;
  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : UserModel.fromJson(json),
    studyGroups: json["studyGroups"] == null ? null : List<dynamic>.from(json["studyGroups"].map((x) => x)),
    userEnrollment: json["userEnrollment"] == null ? null : UserEnrollmentModel.fromJson(json),
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data?.toJson(),
    "studyGroups": studyGroups == null ? null : List<dynamic>.from(studyGroups!.map((x) => x)),
    "userEnrollment": userEnrollment == null ? null : userEnrollment?.toJson(),
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "expires_at": expiresAt == null ? null : expiresAt?.toIso8601String(),
  };
}

