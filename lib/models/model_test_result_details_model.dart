// To parse this JSON data, do
//
//     final modelTestResultDetailsModel = modelTestResultDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_question_model.dart';



ModelTestResultDetailsModel modelTestResultDetailsModelFromJson(String str) => ModelTestResultDetailsModel.fromJson(json.decode(str));

String modelTestResultDetailsModelToJson(ModelTestResultDetailsModel data) => json.encode(data.toJson());

class ModelTestResultDetailsModel {
  ModelTestResultDetailsModel({
    this.success,
    this.msg,
    this.quizSummery,
    this.modelTest,
    this.category,
    this.position,
    this.modelQuesiton,
  });

  bool? success;
  String? msg;
  QuizSummery? quizSummery;
  ModelTest? modelTest;
  Category? category;
  int? position;
  ModelQuesiton? modelQuesiton;

  factory ModelTestResultDetailsModel.fromJson(Map<String, dynamic> json) => ModelTestResultDetailsModel(
    success: json["success"],
    msg: json["msg"],
    quizSummery: json["quizSummery"] == null ? null : QuizSummery.fromJson(json["quizSummery"]),
    modelTest: json["model_test"] == null ? null : ModelTest.fromJson(json["model_test"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    position: json["position"],
    modelQuesiton: json["model_quesiton"] == null ? null : ModelQuesiton.fromJson(json["model_quesiton"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "quizSummery": quizSummery?.toJson(),
    "model_test": modelTest?.toJson(),
    "category": category?.toJson(),
    "position": position,
    "model_quesiton": modelQuesiton?.toJson(),
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

class ModelQuesiton {
  ModelQuesiton({
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
  List<SingleQuestionModel>? data;
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

  factory ModelQuesiton.fromJson(Map<String, dynamic> json) => ModelQuesiton(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<SingleQuestionModel>.from(json["data"]!.map((x) => SingleQuestionModel.fromJson(x))),
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

class ModelTest {
  ModelTest({
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

  factory ModelTest.fromJson(Map<String, dynamic> json) => ModelTest(
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
}

class QuizSummery {
  QuizSummery({
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
  });

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

  factory QuizSummery.fromJson(Map<String, dynamic> json) => QuizSummery(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}


