// To parse this JSON data, do
//
//     final userStrengthAndWeeknessModel = userStrengthAndWeeknessModelFromJson(jsonString);

import 'dart:convert';

UserStrengthAndWeaknessModel? userStrengthAndWeaknessModelFromJson(String str) => UserStrengthAndWeaknessModel.fromJson(json.decode(str));

String userStrengthAndWeaknessModelToJson(UserStrengthAndWeaknessModel? data) => json.encode(data!.toJson());

class UserStrengthAndWeaknessModel {
  UserStrengthAndWeaknessModel({
    this.success,
    this.msg,
    this.list,
  });

  bool? success;
  String? msg;
  List<EnrolledStrengthData?>? list;

  factory UserStrengthAndWeaknessModel.fromJson(Map<String, dynamic> json) => UserStrengthAndWeaknessModel(
    success: json["success"],
    msg: json["msg"],
    list: json["list"] == null ? [] : json["list"] == null ? [] : List<EnrolledStrengthData?>.from(json["list"]!.map((x) => EnrolledStrengthData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "list": list == null ? [] : list == null ? [] : List<EnrolledStrengthData>.from(list!.map((x) => x!.toJson())),
  };
}

class EnrolledStrengthData {
  EnrolledStrengthData({
    this.id,
    this.userId,
    this.subjectId,
    this.chapterId,
    this.categoryId,
    this.marksPercentage,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.chapter,
    this.subject,
  });

  int? id;
  int? userId;
  int? subjectId;
  int? chapterId;
  int? categoryId;
  int? marksPercentage;
  dynamic createdAt;
  dynamic updatedAt;
  Category? category;
  Category? chapter;
  Category? subject;

  factory EnrolledStrengthData.fromJson(Map<String, dynamic> json) => EnrolledStrengthData(
    id: json["id"],
    userId: json["user_id"],
    subjectId: json["subject_id"],
    chapterId: json["chapter_id"],
    categoryId: json["category_id"],
    marksPercentage: json["marks_percentage"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    category: Category.fromJson(json["category"]),
    chapter: Category.fromJson(json["chapter"]),
    subject: Category.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "subject_id": subjectId,
    "chapter_id": chapterId,
    "category_id": categoryId,
    "marks_percentage": marksPercentage,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category": category!.toJson(),
    "chapter": chapter!.toJson(),
    "subject": subject!.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.groupId,
    this.parentId,
    this.serial,
    this.display,
    this.examSerial,
  });

  int? id;
  String? name;
  int? groupId;
  int? parentId;
  int? serial;
  int? display;
  int? examSerial;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    groupId: json["group_id"],
    parentId: json["parent_id"],
    serial: json["serial"],
    display: json["display"],
    examSerial: json["exam_serial"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "group_id": groupId,
    "parent_id": parentId,
    "serial": serial,
    "display": display,
    "exam_serial": examSerial,
  };
}
