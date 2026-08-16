// To parse this JSON data, do
//
//     final getAllQuestionsModel = getAllQuestionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_question_model.dart';



GetAllQuestionsModel getAllQuestionsModelFromJson(String str) => GetAllQuestionsModel.fromJson(json.decode(str));

String getAllQuestionsModelToJson(GetAllQuestionsModel data) => json.encode(data.toJson());

class GetAllQuestionsModel {
  GetAllQuestionsModel({
    this.success,
    this.msg,
    this.data,
    this.totalRow,
  });

  bool? success;
  String? msg;
  Data? data;
  int? totalRow;

  factory GetAllQuestionsModel.fromJson(Map<String, dynamic> json) => GetAllQuestionsModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    totalRow: json["total_row"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
    "total_row": totalRow,
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
  List<SingleQuestionModel>? data;
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
/*
class Datum {
  Datum({
    this.id,
    this.examName,
    this.subject,
    this.chapterGroup,
    this.chapter,
    this.question,
    this.hints,
    this.insertedFromIp,
    this.questionBy,
    this.display,
    this.isPrev,
    this.options,
    this.hasParagraph,
    this.questionGrade,
    this.questionSource,
    this.tags,
    this.period,
    this.isChangeable,
    this.createdAt,
    this.updatedAt,
    this.expiredDate,
    this.hitCount,
    this.mistakeCount,
    this.status,
  });

  int? id;
  ExamName? examName;
  String? subject;
  dynamic chapterGroup;
  dynamic chapter;
  String? question;
  String? hints;
  String? insertedFromIp;
  int? questionBy;
  int? display;
  dynamic isPrev;
  String? options;
  int? hasParagraph;
  dynamic questionGrade;
  dynamic questionSource;
  dynamic tags;
  int? period;
  int? isChangeable;
  DateTime? createdAt;
  UpdatedAt? updatedAt;
  dynamic expiredDate;
  int? hitCount;
  int? mistakeCount;
  int? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    examName: examNameValues.map[json["exam_name"]]!,
    subject: json["subject"],
    chapterGroup: json["chapter_group"],
    chapter: json["chapter"],
    question: json["question"],
    hints: json["hints"],
    insertedFromIp: json["inserted_from_ip"],
    questionBy: json["question_by"],
    display: json["display"],
    isPrev: json["is_prev"],
    options: json["options"],
    hasParagraph: json["has_paragraph"],
    questionGrade: json["question_grade"],
    questionSource: json["question_source"],
    tags: json["tags"],
    period: json["period"],
    isChangeable: json["is_changeable"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: updatedAtValues.map[json["updated_at"]]!,
    expiredDate: json["expired_date"],
    hitCount: json["hit_count"],
    mistakeCount: json["mistake_count"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_name": examNameValues.reverse[examName],
    "subject": subject,
    "chapter_group": chapterGroup,
    "chapter": chapter,
    "question": question,
    "hints": hints,
    "inserted_from_ip": insertedFromIp,
    "question_by": questionBy,
    "display": display,
    "is_prev": isPrev,
    "options": options,
    "has_paragraph": hasParagraph,
    "question_grade": questionGrade,
    "question_source": questionSource,
    "tags": tags,
    "period": period,
    "is_changeable": isChangeable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAtValues.reverse[updatedAt],
    "expired_date": expiredDate,
    "hit_count": hitCount,
    "mistake_count": mistakeCount,
    "status": status,
  };
}

enum ExamName { AA }

final examNameValues = EnumValues({
  "aa": ExamName.AA
});

enum UpdatedAt { THE_00000000000000 }

final updatedAtValues = EnumValues({
  "0000-00-00 00:00:00": UpdatedAt.THE_00000000000000
});*/

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

/*class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}*/
