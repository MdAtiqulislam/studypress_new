// To parse this JSON data, do
//
//     final modelTestResultListModel = modelTestResultListModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_model_test_result_model.dart';


ModelTestResultListModel modelTestResultListModelFromJson(String str) => ModelTestResultListModel.fromJson(json.decode(str));

String modelTestResultListModelToJson(ModelTestResultListModel data) => json.encode(data.toJson());

class ModelTestResultListModel {
  ModelTestResultListModel({
    this.success,
    this.msg,
    this.data,
    this.category,
  });

  bool? success;
  String? msg;
  Data? data;
  dynamic category;

  factory ModelTestResultListModel.fromJson(Map<String, dynamic> json) => ModelTestResultListModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
    "category": category,
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
  List<SingleModelTestResultModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

class Datum {
  Datum({
    this.quizSummeryId,
    this.id,
    this.userId,
    this.testId,
    this.quizId,
    this.quizDate,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.expertReview,
    this.marksAchieved,
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

  int? quizSummeryId;
  int? id;
  int? userId;
  int? testId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  dynamic expertReview;
  int? marksAchieved;
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
  dynamic examTime;
  dynamic examYear;
  int? averageTime;
  int? averageMarks;
  int? totalAttempt;
  int? highestMarks;
  dynamic examId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    quizSummeryId: json["quiz_summery_id"],
    id: json["id"],
    userId: json["user_id"],
    testId: json["test_id"],
    quizId: json["quiz_id"],
    quizDate: json["quiz_date"] == null ? null : DateTime.parse(json["quiz_date"]),
    timeTaken: json["time_taken"],
    totalCorrect: json["total_correct"],
    totalWrong: json["total_wrong"],
    expertReview: json["expert_review"],
    marksAchieved: json["marks_achieved"],
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
    averageMarks: json["average_marks"],
    totalAttempt: json["total_attempt"],
    highestMarks: json["highest_marks"],
    examId: json["exam_id"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_summery_id": quizSummeryId,
    "id": id,
    "user_id": userId,
    "test_id": testId,
    "quiz_id": quizId,
    "quiz_date": quizDate?.toIso8601String(),
    "time_taken": timeTaken,
    "total_correct": totalCorrect,
    "total_wrong": totalWrong,
    "expert_review": expertReview,
    "marks_achieved": marksAchieved,
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
