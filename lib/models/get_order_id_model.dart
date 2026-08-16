// To parse this JSON data, do
//
//     final getOrderIdModel = getOrderIdModelFromJson(jsonString);

import 'dart:convert';

GetOrderIdModel getOrderIdModelFromJson(String str) => GetOrderIdModel.fromJson(json.decode(str));

String getOrderIdModelToJson(GetOrderIdModel data) => json.encode(data.toJson());

class GetOrderIdModel {
  GetOrderIdModel({
    this.success,
    this.msg,
    this.order,
  });

  bool? success;
  String? msg;
  Order? order;

  factory GetOrderIdModel.fromJson(Map<String, dynamic> json) => GetOrderIdModel(
    success: json["success"],
    msg: json["msg"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "order": order?.toJson(),
  };
}

class Order {
  Order({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.amount,
  });

  int? userId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  dynamic amount;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    status: json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "amount": amount,
  };
}
