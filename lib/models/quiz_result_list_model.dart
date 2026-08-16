// To parse this JSON data, do
//
//     final quizResultListModel = quizResultListModelFromJson(jsonString);

import 'dart:convert';

QuizResultListModel quizResultListModelFromJson(String str) => QuizResultListModel.fromJson(json.decode(str));

String quizResultListModelToJson(QuizResultListModel data) => json.encode(data.toJson());

class QuizResultListModel {
  QuizResultListModel({
    this.success,
    this.msg,
    this.data,
    this.category,
  });

  bool? success;
  String? msg;
  Data? data;
  Category? category;

  factory QuizResultListModel.fromJson(Map<String, dynamic> json) => QuizResultListModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
    "category": category?.toJson(),
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
  List<SingleResultDataModel>? data;
  String? firstPageUrl;
  dynamic from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  dynamic to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<SingleResultDataModel>.from(json["data"]!.map((x) => SingleResultDataModel.fromJson(x))),
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
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
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


class SingleResultDataModel {
  SingleResultDataModel({
    this.id,
    this.userId,
    this.chapterId,
    this.quizId,
    this.quizDate,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.marksAchieved,
    this.totalQuestion,
    this.chapter,
  });

  int? id;
  int? userId;
  int? chapterId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  int? marksAchieved;
  int? totalQuestion;
  ResultChapterModel? chapter;

  factory SingleResultDataModel.fromJson(Map<String, dynamic> json) => SingleResultDataModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    chapterId: json["chapter_id"] == null ? null : json["chapter_id"],
    quizId: json["quiz_id"] == null ? null : json["quiz_id"],
    quizDate: json["quiz_date"] == null ? null : DateTime.parse(json["quiz_date"]),
    timeTaken: json["time_taken"] == null ? null : json["time_taken"],
    totalCorrect: json["total_correct"] == null ? null : json["total_correct"],
    totalWrong: json["total_wrong"] == null ? null : json["total_wrong"],
    marksAchieved: json["marks_achieved"] == null ? null : json["marks_achieved"],
    totalQuestion: json["total_question"] == null ? null : json["total_question"],
    chapter: json["chapter"] == null ? null : ResultChapterModel.fromJson(json["chapter"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "chapter_id": chapterId == null ? null : chapterId,
    "quiz_id": quizId == null ? null : quizId,
    "quiz_date": quizDate == null ? null : quizDate!.toIso8601String(),
    "time_taken": timeTaken == null ? null : timeTaken,
    "total_correct": totalCorrect == null ? null : totalCorrect,
    "total_wrong": totalWrong == null ? null : totalWrong,
    "marks_achieved": marksAchieved == null ? null : marksAchieved,
    "total_question": totalQuestion == null ? null : totalQuestion,
    "chapter": chapter == null ? null : chapter!.toJson(),
  };
}

class ResultChapterModel {
  ResultChapterModel({
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

  factory ResultChapterModel.fromJson(Map<String, dynamic> json) => ResultChapterModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    serial: json["serial"] == null ? null : json["serial"],
    display: json["display"] == null ? null : json["display"],
    examSerial: json["exam_serial"] == null ? null : json["exam_serial"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "group_id": groupId == null ? null : groupId,
    "parent_id": parentId == null ? null : parentId,
    "serial": serial == null ? null : serial,
    "display": display == null ? null : display,
    "exam_serial": examSerial == null ? null : examSerial,
  };
}
