// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  Data? data;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
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
    this.phone,
    this.phoneText,
    this.email,
    this.emailText,
  });

  String? phone;
  String? phoneText;
  String? email;
  String? emailText;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    phoneText: json["phone_text"],
    email: json["email"],
    emailText: json["email_text"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "phone_text": phoneText,
    "email": email,
    "email_text": emailText,
  };
}
