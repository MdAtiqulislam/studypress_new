// To parse this JSON data, do
//
//     final userEnrollmentDataModel = userEnrollmentDataModelFromJson(jsonString);

import 'dart:convert';

UserEnrollmentDataModel2 userEnrollmentDataModelFromJson(String str) => UserEnrollmentDataModel2.fromJson(json.decode(str));

String userEnrollmentDataModelToJson(UserEnrollmentDataModel2 data) => json.encode(data.toJson());

class UserEnrollmentDataModel2 {
  UserEnrollmentDataModel2({
    this.success,
    this.userEnrollment,
    this.enrollmentCategoryList,
    this.courseList,
    this.msg,
  });

  bool? success;
  List<UserEnrollment>? userEnrollment;
  List<EnrollmentCategoryList>? enrollmentCategoryList;
  List<CourseList>? courseList;
  String? msg;

  factory UserEnrollmentDataModel2.fromJson(Map<String, dynamic> json) => UserEnrollmentDataModel2(
    success: json["success"] == null ? null : json["success"],
    userEnrollment: json["userEnrollment"] == null ? null : List<UserEnrollment>.from(json["userEnrollment"].map((x) => UserEnrollment.fromJson(x))),
    enrollmentCategoryList: json["enrollmentCategoryList"] == null ? null : List<EnrollmentCategoryList>.from(json["enrollmentCategoryList"].map((x) => EnrollmentCategoryList.fromJson(x))),
    courseList: json["courseList"] == null ? null : List<CourseList>.from(json["courseList"].map((x) => CourseList.fromJson(x))),
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "userEnrollment": userEnrollment == null ? null : List<dynamic>.from(userEnrollment!.map((x) => x.toJson())),
    "enrollmentCategoryList": enrollmentCategoryList == null ? null : List<dynamic>.from(enrollmentCategoryList!.map((x) => x.toJson())),
    "courseList": courseList == null ? null : List<dynamic>.from(courseList!.map((x) => x.toJson())),
    "msg": msg == null ? null : msg,
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
  String? price;
  String? memberPrice;
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

class EnrollmentCategoryList {
  EnrollmentCategoryList({
    this.id,
    this.value,
    this.name,
    this.text,
    this.priceList,
  });

  int? id;
  int? value;
  String? name;
  String? text;
  List<CategoryPriceM2>? priceList;

  factory EnrollmentCategoryList.fromJson(Map<String, dynamic> json) => EnrollmentCategoryList(
    id: json["id"],
    value: json["value"],
    name: json["name"],
    text: json["text"],
    priceList: json["priceList"] == null ? null : List<CategoryPriceM2>.from(json["priceList"].map((x) => CategoryPriceM2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "name": name,
    "text": text,
    "priceList": priceList == null ? null : List<dynamic>.from(priceList!.map((x) => x.toJson())),
  };
}

class CategoryPriceM2 {
  CategoryPriceM2({
    this.id,
    this.categoryId,
    this.duration,
    this.price,
  });

  int? id;
  int? categoryId;
  int? duration;
  int? price;

  factory CategoryPriceM2.fromJson(Map<String, dynamic> json) => CategoryPriceM2(
    id: json["id"],
    categoryId: json["category_id"],
    duration: json["duration"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "duration": duration,
    "price": price,
  };
}


class UserEnrollment {
  UserEnrollment({
    this.id,
    this.userId,
    this.categoryId,
    this.subscriptionType,
    this.subscriptionMonth,
    this.subcriptionStartDate,
    this.subcriptionEndDate,
    this.membershipType,
    this.paymentStatus,
    this.categoryPriceId,
    this.projectedScore,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? categoryId;
  String? subscriptionType;
  int? subscriptionMonth;
  DateTime? subcriptionStartDate;
  DateTime? subcriptionEndDate;
  int? membershipType;
  int? paymentStatus;
  int? categoryPriceId;
  dynamic projectedScore;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserEnrollment.fromJson(Map<String, dynamic> json) => UserEnrollment(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subscriptionType: json["subscription_type"],
    subscriptionMonth: json["subscription_month"],
    subcriptionStartDate: json["subcription_start_date"] == null ? null : DateTime.parse(json["subcription_start_date"]),
    subcriptionEndDate: json["subcription_end_date"] == null ? null : DateTime.parse(json["subcription_end_date"]),
    membershipType: json["membership_type"],
    paymentStatus: json["payment_status"],
    categoryPriceId: json["category_price_id"],
    projectedScore: json["projected_score"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "subscription_type": subscriptionType,
    "subscription_month": subscriptionMonth,
    "subcription_start_date": subcriptionStartDate?.toIso8601String(),
    "subcription_end_date": subcriptionEndDate?.toIso8601String(),
    "membership_type": membershipType,
    "payment_status": paymentStatus,
    "category_price_id": categoryPriceId,
    "projected_score": projectedScore,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

