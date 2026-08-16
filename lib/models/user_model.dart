
import 'dart:convert';

import 'package:studypress_new/models/user_data_model.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
    this.userAssessmentCompleted,
  });

  UserDataModel? data;
  bool? userAssessmentCompleted;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: json["data"] == null ? null : UserDataModel.fromJson(json["data"]),
    userAssessmentCompleted: json["userAssessmentCompleted"] == null ? null : json["userAssessmentCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "userAssessmentCompleted": userAssessmentCompleted == null ? null : userAssessmentCompleted,
  };
}

