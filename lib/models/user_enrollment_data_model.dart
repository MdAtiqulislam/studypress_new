
import 'dart:convert';

import 'package:studypress_new/models/user_enrollment_model.dart';

import 'course_list_model.dart';


UserEnrollmentDataModel userEnrollmentDataModelFromJson(String str) => UserEnrollmentDataModel.fromJson(json.decode(str));

String userEnrollmentDataModelToJson(UserEnrollmentDataModel data) => json.encode(data.toJson());

class UserEnrollmentDataModel {
  UserEnrollmentDataModel({
    this.success,
    this.userEnrollment,
    this.enrollmentCategoryList,
    this.courseList,
    this.msg,
  });

  bool? success;
  UserEnrollmentModel? userEnrollment;
  List<EnrollmentCategoryList>? enrollmentCategoryList;
  CoursesListDataModel? courseList;
  String? msg;

  factory UserEnrollmentDataModel.fromJson(Map<String, dynamic> json) => UserEnrollmentDataModel(
    success: json["success"] == null ? null : json["success"],
    userEnrollment: json["userEnrollment"] == null ? null : UserEnrollmentModel.fromJson(json),
    enrollmentCategoryList: json["enrollmentCategoryList"] == null ? null : List<EnrollmentCategoryList>.from(json["enrollmentCategoryList"].map((x) => EnrollmentCategoryList.fromJson(x))),
    courseList: json["courseList"] == null ? null : CoursesListDataModel.fromJson(json),//json["courseList"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "userEnrollment": userEnrollment == null ? null : userEnrollment,
    "enrollmentCategoryList": enrollmentCategoryList == null ? null : List<dynamic>.from(enrollmentCategoryList!.map((x) => x.toJson())),
    "courseList": courseList == null ? null : courseList,
    "msg": msg == null ? null : msg,
  };
}


class EnrollmentCategoryList {
  EnrollmentCategoryList({
    this.id,
    this.value,
    this.name,
    this.text,
  });

  int? id;
  int? value;
  String? name;
  String? text;

  factory EnrollmentCategoryList.fromJson(Map<String, dynamic> json) => EnrollmentCategoryList(
    id: json["id"] == null ? null : json["id"],
    value: json["value"] == null ? null : json["value"],
    name: json["name"] == null ? null : json["name"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "value": value == null ? null : value,
    "name": name == null ? null : name,
    "text": text == null ? null : text,
  };
}

