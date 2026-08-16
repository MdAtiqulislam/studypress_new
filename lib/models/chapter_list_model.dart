// To parse this JSON data, do
//
//     final chapterListDataModel = chapterListDataModelFromJson(jsonString);

import 'dart:convert';

ChapterListDataModel chapterListDataModelFromJson(String str) => ChapterListDataModel.fromJson(json.decode(str));

String chapterListDataModelToJson(ChapterListDataModel data) => json.encode(data.toJson());

class ChapterListDataModel {
  ChapterListDataModel({
    this.success,
    this.msg,
    this.chapterItem,
    this.dataList,
    this.category,
  });

  bool? success;
  String? msg;
  Category? chapterItem;
  List<Category>? dataList;
  Category? category;

  factory ChapterListDataModel.fromJson(Map<String, dynamic> json) => ChapterListDataModel(
    success: json["success"],
    msg: json["msg"],
    chapterItem: json["chapterItem"] == null ? null : Category.fromJson(json["chapterItem"]),
    dataList: json["dataList"] == null ? [] : List<Category>.from(json["dataList"]!.map((x) => Category.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "chapterItem": chapterItem?.toJson(),
    "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
    "category": category?.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.parentId,
    this.chapters,
    this.previousTestCount,
  });

  int? id;
  String? name;
  int? parentId;
  List<Category>? chapters;
  int? previousTestCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    chapters: json["chapters"] == null ? [] : List<Category>.from(json["chapters"]!.map((x) => Category.fromJson(x))),
    previousTestCount: json["previous_test_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "previous_test_count": previousTestCount,
  };
}
