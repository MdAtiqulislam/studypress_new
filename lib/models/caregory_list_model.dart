// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    this.success,
    this.msg,
    this.data,
    this.hasCurrentAffairs,
  });

  bool? success;
  String? msg;
  List<CategoryData>? data;
  bool? hasCurrentAffairs;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
    hasCurrentAffairs: json["hasCurrentAffairs"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "hasCurrentAffairs":hasCurrentAffairs,
  };
}

class CategoryData {
  CategoryData({
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

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
