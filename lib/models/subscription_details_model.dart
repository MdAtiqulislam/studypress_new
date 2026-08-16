// To parse this JSON data, do
//
//     final subscriptionDetailsModel = subscriptionDetailsModelFromJson(jsonString);

import 'dart:convert';

SubscriptionDetailsModel subscriptionDetailsModelFromJson(String str) => SubscriptionDetailsModel.fromJson(json.decode(str));

String subscriptionDetailsModelToJson(SubscriptionDetailsModel data) => json.encode(data.toJson());

class SubscriptionDetailsModel {
  SubscriptionDetailsModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  Data? data;

  factory SubscriptionDetailsModel.fromJson(Map<String, dynamic> json) => SubscriptionDetailsModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.amount,
    this.address,
    this.status,
    this.transactionId,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  int? amount;
  String? address;
  String? status;
  dynamic transactionId;
  dynamic currency;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Detail>? details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    amount: json["amount"],
    address: json["address"],
    status: json["status"],
    transactionId: json["transaction_id"],
    currency: json["currency"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "amount": amount,
    "address": address,
    "status": status,
    "transaction_id": transactionId,
    "currency": currency,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.id,
    this.orderId,
    this.categoryId,
    this.categoryPriceId,
    this.price,
    this.category,
    this.categoryPrice,
  });

  int? id;
  int? orderId;
  int? categoryId;
  int? categoryPriceId;
  int? price;
  Category? category;
  CategoryPrice? categoryPrice;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    orderId: json["order_id"],
    categoryId: json["category_id"],
    categoryPriceId: json["category_price_id"],
    price: json["price"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    categoryPrice: json["category_price"] == null ? null : CategoryPrice.fromJson(json["category_price"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "category_id": categoryId,
    "category_price_id": categoryPriceId,
    "price": price,
    "category": category?.toJson(),
    "category_price": categoryPrice?.toJson(),
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

class CategoryPrice {
  CategoryPrice({
    this.id,
    this.categoryId,
    this.duration,
    this.price,
  });

  int? id;
  int? categoryId;
  int? duration;
  int? price;

  factory CategoryPrice.fromJson(Map<String, dynamic> json) => CategoryPrice(
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
