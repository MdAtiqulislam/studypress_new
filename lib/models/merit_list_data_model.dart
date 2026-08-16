// To parse this JSON data, do
//
//     final meritListDataModel = meritListDataModelFromJson(jsonString);

import 'dart:convert';

MeritListDataModel meritListDataModelFromJson(String str) => MeritListDataModel.fromJson(json.decode(str));

String meritListDataModelToJson(MeritListDataModel data) => json.encode(data.toJson());

class MeritListDataModel {
  MeritListDataModel({
    this.success,
    this.msg,
    this.data,
    this.modelQuizeSummery,
    this.modelTest,
    this.category,
  });

  bool? success;
  String? msg;
  Data? data;
  ModelQuizeSummery? modelQuizeSummery;
  ModelTest? modelTest;
  Category? category;

  factory MeritListDataModel.fromJson(Map<String, dynamic> json) => MeritListDataModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    modelQuizeSummery: json["modelQuizeSummery"] == null ? null : ModelQuizeSummery.fromJson(json["modelQuizeSummery"]),
    modelTest: json["modelTest"] == null ? null : ModelTest.fromJson(json["modelTest"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
    "modelQuizeSummery": modelQuizeSummery?.toJson(),
    "modelTest": modelTest?.toJson(),
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
  List<MeritListData>? data;
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
    data: json["data"] == null ? [] : List<MeritListData>.from(json["data"]!.map((x) => MeritListData.fromJson(x))),
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

class MeritListData {
  MeritListData({
    this.quizeSummeryId,
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
    this.fullName,
    this.address,
    this.phone,
    this.photo,
    this.avatarId,
    this.studyLevel,
    this.instituteName,
    this.className,
    this.deptGroup,
    this.session,
  });

  int? quizeSummeryId;
  int? id;
  int? userId;
  int? testId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  String? expertReview;
  int? marksAchieved;
  String? fullName;
  String? address;
  String? phone;
  String? photo;
  dynamic avatarId;
  String? studyLevel;
  String? instituteName;
  dynamic className;
  String? deptGroup;
  String? session;

  factory MeritListData.fromJson(Map<String, dynamic> json) => MeritListData(
    quizeSummeryId: json["quize_summery_id"],
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
    fullName: json["full_name"],
    address: json["address"],
    phone: json["phone"],
    photo: json["photo"],
    avatarId: json["avatar_id"],
    studyLevel: json["study_level"],
    instituteName: json["institute_name"],
    className: json["class_name"],
    deptGroup: json["dept_group"],
    session: json["session"],
  );

  Map<String, dynamic> toJson() => {
    "quize_summery_id": quizeSummeryId,
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
    "full_name": fullName,
    "address": address,
    "phone": phone,
    "photo": photo,
    "avatar_id": avatarId,
    "study_level": studyLevel,
    "institute_name": instituteName,
    "class_name": className,
    "dept_group": deptGroup,
    "session": session,
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

class ModelQuizeSummery {
  ModelQuizeSummery({
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

  factory ModelQuizeSummery.fromJson(Map<String, dynamic> json) => ModelQuizeSummery(
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
  String? details;
  int? marksCarry;
  int? totalQues;
  int? time;
  int? display;
  int? isPaid;
  dynamic examTime;
  dynamic examYear;
  int? averageTime;
  dynamic averageMarks;
  int? totalAttempt;
  int? highestMarks;
  dynamic examId;

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
    averageMarks: json["average_marks"],
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
