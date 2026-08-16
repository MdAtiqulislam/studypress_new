// To parse this JSON data, do
//
//     final memberShipPlanModel = memberShipPlanModelFromJson(jsonString);

import 'dart:convert';

MemberShipPlanModel memberShipPlanModelFromJson(String str) => MemberShipPlanModel.fromJson(json.decode(str));

String memberShipPlanModelToJson(MemberShipPlanModel data) => json.encode(data.toJson());

class MemberShipPlanModel {
  MemberShipPlanModel({
    this.success,
    this.userEnrollment,
    this.enrollmentCategoryList,
    this.categoryPriceList,
    this.msg,
  });

  bool? success;
  List<UserEnrollment>? userEnrollment;
  List<EnrollmentCategoryList>? enrollmentCategoryList;
  Map<String, List<PriceList>>? categoryPriceList;
  String? msg;

  factory MemberShipPlanModel.fromJson(Map<String, dynamic> json) => MemberShipPlanModel(
    success: json["success"],
    userEnrollment: json["userEnrollment"] == null ? [] : List<UserEnrollment>.from(json["userEnrollment"]!.map((x) => UserEnrollment.fromJson(x))),
    enrollmentCategoryList: json["enrollmentCategoryList"] == null ? [] : List<EnrollmentCategoryList>.from(json["enrollmentCategoryList"]!.map((x) => EnrollmentCategoryList.fromJson(x))),
    categoryPriceList: Map.from(json["categoryPriceList"]!).map((k, v) => MapEntry<String, List<PriceList>>(k, List<PriceList>.from(v.map((x) => PriceList.fromJson(x))))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "userEnrollment": userEnrollment == null ? [] : List<dynamic>.from(userEnrollment!.map((x) => x.toJson())),
    "enrollmentCategoryList": enrollmentCategoryList == null ? [] : List<dynamic>.from(enrollmentCategoryList!.map((x) => x.toJson())),
    "categoryPriceList": Map.from(categoryPriceList!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    "msg": msg,
  };
}

class PriceList {
  PriceList({
    this.id,
    this.categoryId,
    this.duration,
    this.price,
    this.usdPrice,
    this.category,
  });

  int? id;
  int? categoryId;
  int? duration;
  int? price;
  double? usdPrice;
  Category? category;

  factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
    id: json["id"],
    categoryId: json["category_id"],
    duration: json["duration"],
    price: json["price"],
    usdPrice: json["usdPrice"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "duration": duration,
    "price": price,
    "usdPrice": usdPrice,
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
  List<PriceList>? priceList;

  factory EnrollmentCategoryList.fromJson(Map<String, dynamic> json) => EnrollmentCategoryList(
    id: json["id"],
    value: json["value"],
    name: json["name"],
    text: json["text"],
    priceList: json["priceList"] == null ? [] : List<PriceList>.from(json["priceList"]!.map((x) => PriceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "name": name,
    "text": text,
    "priceList": priceList == null ? [] : List<dynamic>.from(priceList!.map((x) => x.toJson())),
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
  dynamic subcriptionStartDate;
  dynamic subcriptionEndDate;
  int? membershipType;
  int? paymentStatus;
  dynamic categoryPriceId;
  dynamic projectedScore;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserEnrollment.fromJson(Map<String, dynamic> json) => UserEnrollment(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subscriptionType: json["subscription_type"],
    subscriptionMonth: json["subscription_month"],
    subcriptionStartDate: json["subcription_start_date"],
    subcriptionEndDate: json["subcription_end_date"],
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
    "subcription_start_date": subcriptionStartDate,
    "subcription_end_date": subcriptionEndDate,
    "membership_type": membershipType,
    "payment_status": paymentStatus,
    "category_price_id": categoryPriceId,
    "projected_score": projectedScore,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
