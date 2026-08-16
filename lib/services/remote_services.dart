import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import '../constraints/app_strings.dart';
import '../utilities/show_snack_bar.dart';
import 'local_services.dart';

class RemoteServices {
  static var clint = http.Client();
  static var baseURL = "https://studypress.org/api/v1/";

  static var token="";

  //http post request
  static Future<dynamic> postRequest(
      {required String endPoint, Map<dynamic, dynamic>? body}) async {
    token = await LocalServices.getToken()??"";

    var uri = Uri.parse(baseURL + endPoint);
    var requestBody = body;
    var requestHeader = {"Authorization": "Bearer $token"};
    if (kDebugMode) {
      print(baseURL + endPoint);
    }
    try {
      http.Response response = await http.post(
        uri,
        body: requestBody,
        headers: requestHeader,
      );
      var r = json.decode(response.body);
      print(r);

      if (r["success"]??false) {
        if (kDebugMode) {
          print(r["msg"]);
        }
        return r;
      } else {
        String message = r["msg"] ?? r["message"] ?? "Something went wrong. Please try again later.";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }




  //http post request with Json Data
  static Future<dynamic> postRequestWithJsonData(
      {required String endPoint, Map<dynamic, dynamic>? body}) async {
    //var uri = Uri.parse(baseURL+endPoint);
    token = await LocalServices.getToken()??"";
    var uri = Uri.parse(baseURL + endPoint);
    var requestBody = body;
    var requestHeader = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };
    if (kDebugMode) {
      print(baseURL + endPoint);
    }
    try {
      http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: requestHeader,
          encoding: Encoding.getByName("utf-8")
      );
      var r = json.decode(response.body);

      if (r["success"]??true) {
        if (kDebugMode) {
          print(r["msg"]);
        }
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }




  //http post request with Direct link
  static Future<dynamic> postRequestWithFullLink({required String url}) async {
    token = await LocalServices.getToken()??"";
    var requestHeader = {"Authorization": "Bearer $token"};
    try {
      var uri = Uri.parse(url);
      if (kDebugMode) {
        print(url);
      }
      http.Response response = await http.post(
          uri, headers: requestHeader);
      //print("Response:   ${response.body}");
      var r = json.decode(response.body);

      if (r["success"]) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }



  //http get request
  static Future<dynamic> getRequest(
      {
        required String endPoint,
        Map<String, dynamic>? body,
        Map<String, dynamic>? parameters
      }) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);

    token = await LocalServices.getToken()??"";
    print("Token: $token");
    var headers = {"Authorization": "Bearer $token"};
    try {
      var response =
          await clint.get(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters), headers: headers);
      var r = json.decode(response.body);
      print(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters));
      print(response.body);
      if (r["success"]) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }



  //http get request with full Link
  static Future<dynamic> getRequestLoadMore(
      String url, Map<String, dynamic> body) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);
    token = await LocalServices.getToken()??"";
    var headers = {"Authorization": "Bearer $token"};

    try {
      var response = await clint.get(Uri.parse(url), headers: headers);
      if (kDebugMode) {
        print(url);
      }

      var r = json.decode(response.body);
      print(response.body);
      if (kDebugMode) {
        print(url);
      }
      if (r["success"]) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }


/*  void itemHitCount({required id})async{
    var endPoint=AppStrings.itemHitCountEndPoint+id.toString();
    print(endPoint);
    try{

      var data= await RemoteServices.getRequest(endPoint, {"":""});
      if(data!=null){
        print(data);
      }

    }finally{

    }
  }*/


  //Item HitCount
  static Future<dynamic> itemHitCount({required String qId}) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);

    var endPoint=AppStrings.itemHitCountEndPoint;
    token = await LocalServices.getToken()??"";
    var headers = {"Authorization": "Bearer $token"};
    var parameters={
      "qid":qId.toString()
    };
    try {
      var response =
      await clint.get(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters), headers: headers);
      var r = json.decode(response.body);

      print(response.body);
      print(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters));
      if (r["success"]) {
       // print(r);
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }


  //Item MistakeCount
  static Future<dynamic> itemMistakeCount({required String qId,required String chapterId}) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);
    var endPoint=AppStrings.itemMistakeCountEndPoint;
    token = await LocalServices.getToken()??"";
    var headers = {"Authorization": "Bearer $token"};
    var parameters = {
      "qid":qId,
      "chapter_id":chapterId
    };


    print(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters));


    try {
      var response =
      await clint.get(Uri.parse(baseURL + endPoint).replace(queryParameters: parameters), headers: headers);
      var r = json.decode(response.body);
      if (r["success"]) {
        print(r);
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        AppStrings.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }




  static void customLogOut() async {
    CustomSnackBar(
      msg: "Login Required!",
      isWarning: true,
      buttonText: "Go To Login".toUpperCase(),
    ).showSnackBar();
    // final UserInfoController userInfoController=Get.put(UserInfoController());
    // userInfoController.logOut();
  }
}
