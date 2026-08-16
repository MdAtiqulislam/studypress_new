import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/body_text.dart';
import '../constraints/header_text.dart';
import '../models/app_version_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';

class SplashScreenController extends GetxController{
  var token="".obs;
  var userModel=UserModel().obs;
  var assessmentStatus=false.obs;
  var enrollData=UserEnrollmentDataModel2().obs;
  var appVersionData = AppVersionModel().obs;
  var isLoading=false.obs;

  @override
  void onInit() async{
    // TODO: implement onInit


    checkAppVersion();



/*    if(token.value.isEmpty){
      Get.offAndToNamed("/login_email_page");
    }else{
     if(enrollData.value.userEnrollment!.isEmpty){
       Get.offAllNamed("/enrollment_list_page");
     }else{
       if(assessmentStatus.value){
         Get.offAndToNamed("/home_page");
       }else{
         Get.offAndToNamed("/assessment_test_page");
       }
     }
    }*/
    super.onInit();
  }



  void checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentAppVersion = packageInfo.version;
    var previousAppVersion =await LocalServices.getPreviousAppVersion()??"";


    if (previousAppVersion
        .toString()
        .isNotEmpty) {
      if (previousAppVersion != currentAppVersion) {
        // print("Version is not matched~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        _deleteCacheDir(currentAppVersion);
      }else{
        //_deleteCacheDir(currentAppVersion);
        // print("Cached Not Cleared~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      }
    }else{
      LocalServices.storeAppVersion(currentAppVersion);
      // print("AppVersion Updated~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    }





    const endPoint = AppStrings.getVersionEndPoint;
    var data = await RemoteServices.getRequest(endPoint:endPoint);


    if (data != null && Platform.isAndroid) {
      appVersionData.value = AppVersionModel.fromJson(data);


      if (appVersionData.value.data?.verstionControlData?.original?.data?.version != currentAppVersion &&
          (appVersionData.value.data?.verstionControlData?.original?.data?.androidTestVersion??"") != currentAppVersion) {
        //print("d-------------------------------------------");
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                titlePadding: const EdgeInsets.all(0),
                title: Container(
                  color: AppColors.appPrimaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    child: HeaderText(
                      text: appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg?.title ?? "",
                      size: 20, color: Colors.white,
                    ),
                  ),
                ),
                content: BodyText(
                  text:appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg?.msg ?? "",
                  maxLine: 10,
                  size: 14,
                ),
                actions: <Widget>[
                  MaterialButton(
                    autofocus: true,
                    textColor: AppColors.appPrimaryColor,
                    focusColor: AppColors.appPrimaryColor,
                    splashColor: AppColors.appPrimaryColor,
                    focusElevation: 5,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.appPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // color: AppColors.mainColorRed,
                    onPressed: () {
                      if (Platform.isAndroid) {
                        final appId = appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg!.url!.apk!
                            .split("id")[1];
                        final url = Uri.parse("market://details?id$appId");
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      "Update",
                    ),),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        side:  const BorderSide(color: AppColors.appPrimaryColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textColor: AppColors.appPrimaryColor,
                      splashColor: AppColors.appPrimaryColor,
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text("Cancel"))
                ],
              ),
            );
          },
        );
      }
      else{
        token.value=await LocalServices.getToken()??"";
        userModel.value=await LocalServices.getUser()??UserModel();
        enrollData.value=await LocalServices.getEnrollmentItems()??UserEnrollmentDataModel2();
        await Future.delayed(const Duration(seconds: 2),);
        assessmentStatus.value=userModel.value.userAssessmentCompleted??false;
        if(token.value.isEmpty){
          Get.offAndToNamed("/login_email_page");
        }else{
          if((enrollData.value.userEnrollment??[]).isEmpty){
            Get.offAllNamed("/enrollment_list_page");
          }else{
            if(assessmentStatus.value){
              Get.offAndToNamed("/home_page");
            }else{
              Get.offAndToNamed("/assessment_test_page");
            }
          }
        }
      }

    }





    else if (data != null && Platform.isIOS) {
      appVersionData.value = AppVersionModel.fromJson(data);
      if ((appVersionData.value.data?.verstionControlData?.original?.data?.iosVersion??"") != currentAppVersion &&
          (appVersionData.value.data?.verstionControlData?.original?.data?.iosTestVersion??"") != currentAppVersion) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                titlePadding: const EdgeInsets.all(0),
                title: Container(
                  color: AppColors.appPrimaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    child: HeaderText(
                      text: appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg?.title ?? "",
                      size: 20, color: Colors.white,
                    ),
                  ),
                ),
                content: BodyText(
                  text: appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg?.msg ?? "",
                  maxLine: 10,
                  size: 14,
                ),
                actions: <Widget>[
                  MaterialButton(
                    autofocus: true,
                    textColor: AppColors.appPrimaryColor,
                    focusColor: AppColors.appPrimaryColor,
                    splashColor: AppColors.appPrimaryColor,
                    focusElevation: 5,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.appPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // color: AppColors.mainColorRed,
                    onPressed: () {






                      if (Platform.isIOS) {
                        // final appId=appVersionData.value.majorMsg!.url!.apk!.split("id")[1];
                        final url = Uri.parse(appVersionData.value.data?.verstionControlData?.original?.data?.majorMsg?.url?.ios??"");
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }

                    },
                    child: const Text(
                      "Update",
                    ),),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.appPrimaryColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textColor: AppColors.appPrimaryColor,
                      splashColor: AppColors.appPrimaryColor,
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text("Cancel"))
                ],
              ),
            );
          },
        );
      }
      else{
        token.value=await LocalServices.getToken()??"";
        userModel.value=await LocalServices.getUser()??UserModel();
        enrollData.value=await LocalServices.getEnrollmentItems()??UserEnrollmentDataModel2();
        await Future.delayed(const Duration(seconds: 2),);
        assessmentStatus.value=userModel.value.userAssessmentCompleted??false;
        if(token.value.isEmpty){
          Get.offAndToNamed("/login_email_page");
        }else{
          if(enrollData.value.userEnrollment!.isEmpty){
            Get.offAllNamed("/enrollment_list_page");
          }else{
            if(assessmentStatus.value){
              Get.offAndToNamed("/home_page");
            }else{
              Get.offAndToNamed("/assessment_test_page");
            }
          }
        }
      }
    }
  }




  Future<void> _deleteCacheDir(String currentAppVersion) async {

    isLoading.value=true;

    try{
      // print("Cache deleting.......................................................................");

      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
        //  print("Cache deleted.......................................................................");
      }
      final appDir = await getApplicationSupportDirectory();
      if(appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
        // print("Data deleted.......................................................................");
      }
      LocalServices.storeAppVersion(currentAppVersion);
    }finally{
      isLoading.value=false;
      LocalServices.deleteData();
      Get.offAndToNamed("/login_email_page");
    }

  }


}