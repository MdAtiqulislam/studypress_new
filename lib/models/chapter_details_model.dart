// To parse this JSON data, do
//
//     final chapterDetailsModel = chapterDetailsModelFromJson(jsonString);

import 'dart:convert';

ChapterDetailsModel chapterDetailsModelFromJson(String str) => ChapterDetailsModel.fromJson(json.decode(str));

String chapterDetailsModelToJson(ChapterDetailsModel data) => json.encode(data.toJson());

class ChapterDetailsModel {
  ChapterDetailsModel({
    this.success,
    this.msg,
    this.subjectItem,
    this.subChapterItem,
    this.chapterItem,
    this.categoryItem,
    this.dataItem,
  });

  bool? success;
  String? msg;
  Item? subjectItem;
  Item? subChapterItem;
  Item? chapterItem;
  Item? categoryItem;
  DataItem? dataItem;

  factory ChapterDetailsModel.fromJson(Map<String, dynamic> json) => ChapterDetailsModel(
    success: json["success"],
    msg: json["msg"],
    subjectItem: json["subjectItem"] == null ? null : Item.fromJson(json["subjectItem"]),
    subChapterItem: json["subChapterItem"] == null ? null : Item.fromJson(json["subChapterItem"]),
    chapterItem: json["chapterItem"] == null ? null : Item.fromJson(json["chapterItem"]),
    categoryItem: json["categoryItem"] == null ? null : Item.fromJson(json["categoryItem"]),
    dataItem: json["dataItem"] == null ? null : DataItem.fromJson(json["dataItem"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "subjectItem": subjectItem?.toJson(),
    "subChapterItem": subChapterItem?.toJson(),
    "chapterItem": chapterItem?.toJson(),
    "categoryItem": categoryItem?.toJson(),
    "dataItem": dataItem?.toJson(),
  };
}

class Item {
  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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

class DataItem {
  DataItem({
    this.id,
    this.refId,
    this.hotTips,
    this.details,
  });

  int? id;
  int? refId;
  String? hotTips;
  String? details;

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
    id: json["id"],
    refId: json["ref_id"],
    hotTips: json["hot_tips"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ref_id": refId,
    "hot_tips": hotTips,
    "details": details,
  };
}
