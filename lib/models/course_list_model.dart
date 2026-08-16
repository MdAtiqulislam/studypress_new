// To parse this JSON data, do
//
//     final coursesListDataModel = coursesListDataModelFromJson(jsonString);

import 'dart:convert';

CoursesListDataModel coursesListDataModelFromJson(String str) => CoursesListDataModel.fromJson(json.decode(str));

String coursesListDataModelToJson(CoursesListDataModel data) => json.encode(data.toJson());

class CoursesListDataModel {
  CoursesListDataModel({
    this.courseList,
  });

  List<CourseList>? courseList;

  factory CoursesListDataModel.fromJson(Map<String, dynamic> json) => CoursesListDataModel(
    courseList: json["courseList"] == null ? null : List<CourseList>.from(json["courseList"].map((x) => CourseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courseList": courseList == null ? null : List<dynamic>.from(courseList!.map((x) => x.toJson())),
  };
}

class CourseList {
  CourseList({
    this.id,
    this.title,
    this.shortDesc,
    this.categoryId,
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
  int? display;
  int? createdBy;
  dynamic price;
  dynamic memberPrice;
  int? duration;
  String? banner;
  String? featuredPic;
  int? enrolledUser;
  DateTime? startDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    shortDesc: json["short_desc"] == null ? null : json["short_desc"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    display: json["display"] == null ? null : json["display"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    price: json["price"] == null ? null : json["price"],
    memberPrice: json["member_price"] == null ? null : json["member_price"],
    duration: json["duration"] == null ? null : json["duration"],
    banner: json["banner"] == null ? null : json["banner"],
    featuredPic: json["featured_pic"] == null ? null : json["featured_pic"],
    enrolledUser: json["enrolled_user"] == null ? null : json["enrolled_user"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "short_desc": shortDesc == null ? null : shortDesc,
    "category_id": categoryId == null ? null : categoryId,
    "display": display == null ? null : display,
    "created_by": createdBy == null ? null : createdBy,
    "price": price == null ? null : price,
    "member_price": memberPrice == null ? null : memberPrice,
    "duration": duration == null ? null : duration,
    "banner": banner == null ? null : banner,
    "featured_pic": featuredPic == null ? null : featuredPic,
    "enrolled_user": enrolledUser == null ? null : enrolledUser,
    "start_date": startDate == null ? null : startDate?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}
