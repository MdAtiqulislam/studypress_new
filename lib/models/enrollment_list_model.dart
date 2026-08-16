// To parse this JSON data, do
//
//     final enrollmentListModel = enrollmentListModelFromJson(jsonString);

import 'dart:convert';

EnrollmentListModel enrollmentListModelFromJson(String str) => EnrollmentListModel.fromJson(json.decode(str));

String enrollmentListModelToJson(EnrollmentListModel data) => json.encode(data.toJson());

class EnrollmentListModel {
  EnrollmentListModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  EnrollmentListData? data;

  factory EnrollmentListModel.fromJson(Map<String, dynamic> json) => EnrollmentListModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : EnrollmentListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data?.toJson(),
  };
}

class EnrollmentListData {
  EnrollmentListData({
    this.refGroupList,
    this.categoryList,
    this.courseList,
    this.pricingList,
  });

  List<CategoryListElement>? refGroupList;
  List<CategoryListElement>? categoryList;
  List<CourseList>? courseList;
  List<PricingList>? pricingList;

  factory EnrollmentListData.fromJson(Map<String, dynamic> json) => EnrollmentListData(
    refGroupList: json["refGroupList"] == null ? null : List<CategoryListElement>.from(json["refGroupList"].map((x) => CategoryListElement.fromJson(x))),
    categoryList: json["categoryList"] == null ? null : List<CategoryListElement>.from(json["categoryList"].map((x) => CategoryListElement.fromJson(x))),
    courseList: json["courseList"] == null ? null : List<CourseList>.from(json["courseList"].map((x) => CourseList.fromJson(x))),
    pricingList: json["pricingList"] == null ? null : List<PricingList>.from(json["pricingList"].map((x) => PricingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "refGroupList": refGroupList == null ? null : List<dynamic>.from(refGroupList!.map((x) => x.toJson())),
    "categoryList": categoryList == null ? null : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
    "courseList": courseList == null ? null : List<dynamic>.from(courseList!.map((x) => x.toJson())),
    "pricingList": pricingList == null ? null : List<dynamic>.from(pricingList!.map((x) => x.toJson())),
  };
}

class CategoryListElement {
  CategoryListElement({
    this.value,
    this.text,
  });

  int? value;
  String? text;

  factory CategoryListElement.fromJson(Map<String, dynamic> json) => CategoryListElement(
    value: json["value"] == null ? null : json["value"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "value": value == null ? null : value,
    "text": text == null ? null : text,
  };
}

class CourseList {
  CourseList({
    this.id,
    this.title,
    this.shortDesc,
  });

  int? id;
  String? title;
  String? shortDesc;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    shortDesc: json["short_desc"] == null ? null : json["short_desc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "short_desc": shortDesc == null ? null : shortDesc,
  };
}

class PricingList {
  PricingList({
    this.id,
    this.duration,
    this.price,
  });

  int? id;
  int? duration;
  int? price;

  factory PricingList.fromJson(Map<String, dynamic> json) => PricingList(
    id: json["id"] == null ? null : json["id"],
    duration: json["duration"] == null ? null : json["duration"],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "duration": duration == null ? null : duration,
    "price": price == null ? null : price,
  };
}
