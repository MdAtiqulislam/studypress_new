// To parse this JSON data, do
//
//     final courseDetailsModel = courseDetailsModelFromJson(jsonString);

import 'dart:convert';

CourseDetailsModel courseDetailsModelFromJson(String str) => CourseDetailsModel.fromJson(json.decode(str));

String courseDetailsModelToJson(CourseDetailsModel data) => json.encode(data.toJson());

class CourseDetailsModel {
  CourseDetailsModel({
    this.success,
    this.msg,
    this.course,
    this.data,
  });

  bool? success;
  String? msg;
  Course? course;
  Data? data;

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) => CourseDetailsModel(
    success: json["success"],
    msg: json["msg"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "course": course?.toJson(),
    "data": data?.toJson(),
  };
}

class Course {
  Course({
    this.id,
    this.title,
    this.shortDesc,
    this.categoryId,
    this.isPaid,
    this.display,
    this.createdBy,
    this.price,
    this.memberPrice,
    this.duration,
    this.banner,
    this.featuredPic,
    this.enrolledUser,
    this.startDate,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? shortDesc;
  int? categoryId;
  int? isPaid;
  int? display;
  int? createdBy;
  String? price;
  String? memberPrice;
  int? duration;
  String? banner;
  String? featuredPic;
  int? enrolledUser;
  DateTime? startDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    title: json["title"],
    shortDesc: json["short_desc"],
    categoryId: json["category_id"],
    isPaid: json["is_paid"],
    display: json["display"],
    createdBy: json["created_by"],
    price: json["price"],
    memberPrice: json["member_price"],
    duration: json["duration"],
    banner: json["banner"],
    featuredPic: json["featured_pic"],
    enrolledUser: json["enrolled_user"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "short_desc": shortDesc,
    "category_id": categoryId,
    "is_paid": isPaid,
    "display": display,
    "created_by": createdBy,
    "price": price,
    "member_price": memberPrice,
    "duration": duration,
    "banner": banner,
    "featured_pic": featuredPic,
    "enrolled_user": enrolledUser,
    "start_date": startDate?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
  List<CourseDetailsData>? data;
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
    data: json["data"] == null ? [] : List<CourseDetailsData>.from(json["data"]!.map((x) => CourseDetailsData.fromJson(x))),
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

class CourseDetailsData {
  CourseDetailsData({
    this.id,
    this.chapters,
    this.courseId,
    this.modelTestId,
    this.modelTest,
    this.modelTestDisable,
  });

  int? id;
  List<ModelTest>? chapters;
  int? courseId;
  String? modelTestId;
  ModelTest? modelTest;
  bool? modelTestDisable;

  factory CourseDetailsData.fromJson(Map<String, dynamic> json) => CourseDetailsData(
    id: json["id"],
    chapters: json["chapters"] == null ? [] : List<ModelTest>.from(json["chapters"]!.map((x) => ModelTest.fromJson(x))),
    courseId: json["course_id"],
    modelTestId: json["model_test_id"],
    modelTest: json["model_test"] == null ? null : ModelTest.fromJson(json["model_test"]),
    modelTestDisable: json["model_test_disable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "course_id": courseId,
    "model_test_id": modelTestId,
    "model_test": modelTest?.toJson(),
    "model_test_disable": modelTestDisable,
  };
}

class ModelTest {
  ModelTest({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ModelTest.fromJson(Map<String, dynamic> json) => ModelTest(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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
