import 'dart:io';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constraints/app_strings.dart';
import '../models/app_links_model.dart';
import '../services/remote_services.dart';

class AppLinksController extends GetxController{


  var isLoading=true.obs;
  var response=AppLinksModel().obs;


  void getAppLinks()async{
    var endPoint=AppStrings.getAppLinksEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        response.value=AppLinksModel.fromJson(data);
      }
    } finally {
      isLoading.value=false;
    }
  }

  void shareApp()async{

    var endPoint=AppStrings.getAppLinksEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        response.value=AppLinksModel.fromJson(data);
        if(Platform.isAndroid){
          await Share.share(
            response.value.androidAppLink??"Share",
            subject: "subject",
          );
        }
        if(Platform.isIOS){
          await Share.share(
            response.value.iosAppLink??"Share",
            subject: "subject",
          );
        }
      }
    } finally {
      isLoading.value=false;
    }

  }

  void rateApp() async{
    var endPoint=AppStrings.getAppLinksEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        response.value=AppLinksModel.fromJson(data);
        if (Platform.isAndroid) {
          final appId =response.value.androidPackageId;
          final url = Uri.parse("market://details?$appId");


          print(url);
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }

        if (Platform.isIOS) {
          // final appId=appVersionData.value.majorMsg!.url!.apk!.split("id")[1];
          final url = Uri.parse(response.value.iosAppLink??"");
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }


      }
    } finally {
      isLoading.value=false;
    }
  }

}