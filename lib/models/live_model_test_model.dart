// To parse this JSON data, do
//
//     final liveModelTestModel = liveModelTestModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_model_test_result_model.dart';


LiveModelTestModel liveModelTestModelFromJson(String str) => LiveModelTestModel.fromJson(json.decode(str));

String liveModelTestModelToJson(LiveModelTestModel data) => json.encode(data.toJson());

class LiveModelTestModel {
  LiveModelTestModel({
    this.success,
    this.msg,
    this.liveList,
    this.archiveList,
  });
  bool? success;
  String? msg;
  List<SingleModelTestResultModel>? liveList;
  ArchiveList? archiveList;

  factory LiveModelTestModel.fromJson(Map<String, dynamic> json) => LiveModelTestModel(
    success: json["success"],
    msg: json["msg"],
    liveList: json["liveList"] == null ? [] : List<SingleModelTestResultModel>.from(json["liveList"]!.map((x) => SingleModelTestResultModel.fromJson(x))),
    archiveList: json["archiveList"] == null ? null : ArchiveList.fromJson(json["archiveList"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "liveList": liveList == null ? [] : List<dynamic>.from(liveList!.map((x) => x.toJson())),
    "archiveList": archiveList?.toJson(),
  };
}

class ArchiveList {
  ArchiveList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<SingleModelTestResultModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ArchiveList.fromJson(Map<String, dynamic> json) => ArchiveList(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<SingleModelTestResultModel>.from(json["data"]!.map((x) => SingleModelTestResultModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class LiveList {
  LiveList({
    this.id,
    this.category,
    this.type,
    this.qType,
    this.isFeatured,
    this.name,
    this.details,
    this.marksCarry,
    this.totalQues,
    this.time,
    this.display,
    this.isPaid,
    this.examTime,
    this.examYear,
    this.averageTime,
    this.averageMarks,
    this.totalAttempt,
    this.highestMarks,
    this.examId,
    this.categoryName,
  });

  int? id;
  int? category;
  int? type;
  int? qType;
  int? isFeatured;
  String? name;
  String? details;
  int? marksCarry;
  int? totalQues;
  int? time;
  int? display;
  int? isPaid;
  DateTime? examTime;
  dynamic examYear;
  int? averageTime;
  int? averageMarks;
  int? totalAttempt;
  int? highestMarks;
  int? examId;
  String? categoryName;

  factory LiveList.fromJson(Map<String, dynamic> json) => LiveList(
    id: json["id"],
    category: json["category"],
    type: json["type"],
    qType: json["q_type"],
    isFeatured: json["is_featured"],
    name: json["name"],
    details: json["details"],
    marksCarry: json["marks_carry"],
    totalQues: json["total_ques"],
    time: json["time"],
    display: json["display"],
    isPaid: json["is_paid"],
    examTime: json["exam_time"] == null ? null : DateTime.parse(json["exam_time"]),
    examYear: json["exam_year"],
    averageTime: json["average_time"],
    averageMarks: json["average_marks"],
    totalAttempt: json["total_attempt"],
    highestMarks: json["highest_marks"],
    examId: json["exam_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "type": type,
    "q_type": qType,
    "is_featured": isFeatured,
    "name": name,
    "details": details,
    "marks_carry": marksCarry,
    "total_ques": totalQues,
    "time": time,
    "display": display,
    "is_paid": isPaid,
    "exam_time": examTime?.toIso8601String(),
    "exam_year": examYear,
    "average_time": averageTime,
    "average_marks": averageMarks,
    "total_attempt": totalAttempt,
    "highest_marks": highestMarks,
    "exam_id": examId,
    "category_name": categoryName,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
