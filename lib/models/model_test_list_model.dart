// To parse this JSON data, do
//
//     final modelTestListModel = modelTestListModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_model_test_model.dart';


ModelTestListModel modelTestListModelFromJson(String str) => ModelTestListModel.fromJson(json.decode(str));

String modelTestListModelToJson(ModelTestListModel data) => json.encode(data.toJson());

class ModelTestListModel {
  ModelTestListModel({
    this.success,
    this.msg,
    this.data,
    this.subjectItem,
  });

  bool? success;
  String? msg;
  Data? data;
  SubjectItem? subjectItem;

  factory ModelTestListModel.fromJson(Map<String, dynamic> json) => ModelTestListModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    subjectItem: json["subjectItem"] == null ? null : SubjectItem.fromJson(json["subjectItem"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
    "subjectItem": subjectItem?.toJson(),
  };
}

class Data {
  Data({
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
  List<SingleModelTestModel>? data;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<SingleModelTestModel>.from(json["data"]!.map((x) => SingleModelTestModel.fromJson(x))),
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

/*class Datum {
  Datum({
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
  });

  int? id;
  int? category;
  int? type;
  int? qType;
  int? isFeatured;
  String? name;
  dynamic details;
  int? marksCarry;
  int? totalQues;
  int? time;
  int? display;
  int? isPaid;
  dynamic examTime;
  dynamic examYear;
  int? averageTime;
  double? averageMarks;
  int? totalAttempt;
  int? highestMarks;
  int? examId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    examTime: json["exam_time"],
    examYear: json["exam_year"],
    averageTime: json["average_time"],
    averageMarks: json["average_marks"]?.toDouble(),
    totalAttempt: json["total_attempt"],
    highestMarks: json["highest_marks"],
    examId: json["exam_id"],
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
    "exam_time": examTime,
    "exam_year": examYear,
    "average_time": averageTime,
    "average_marks": averageMarks,
    "total_attempt": totalAttempt,
    "highest_marks": highestMarks,
    "exam_id": examId,
  };
}*/

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

class SubjectItem {
  SubjectItem({
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

  factory SubjectItem.fromJson(Map<String, dynamic> json) => SubjectItem(
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
