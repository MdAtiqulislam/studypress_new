import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studypress_new/controllers/otp_controller.dart';


import '../constraints/app_strings.dart';
import '../models/login_email_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';

class LoginController extends GetxController{

  final emailController=TextEditingController();
  final resetPasswordEmailController=TextEditingController();
  final passwordController=TextEditingController();
  var token="".obs;

  var isLoading = false.obs;
  var endPoint = AppStrings.loginEmailEndPoint;
  var response=LoginModel().obs;
  var userEnrollmentData=UserEnrollmentDataModel2().obs;
  var userModel=UserModel().obs;

  @override
  void dispose(){
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void onInit() async {
    token.value = await LocalServices.getToken()??"";

/*    if(token.value.isNotEmpty||token.value!=null){
      print(token.value);
      Get.offAllNamed("/home_page");
    }*/
    super.onInit();
  }

  void fetchData() async{
    isLoading.value = true;
    AppStrings.httpErrorMSG.value="";
    String email=emailController.text;
    String password=passwordController.text;

    var body={
      'email':email,
      'password':password,
    };

    print(body);
    try {
      var data = await RemoteServices.postRequest(endPoint:endPoint, body:body);
      //print(data);
      if (data != null) {
        response.value = LoginModel.fromJson(data);
        //AppStrings.httpResponseMSG.value = response.value.msg!;
        isLoading.value = false;
        await LocalServices.storeToken(response.value.accessToken??"");
       // await LocalServices.storeAssessmentStatus(response.value.userAssessmentCompleted??false);
        userModel.value.data=response.value.data!.data;
        userModel.value.userAssessmentCompleted=response.value.data!.userAssessmentCompleted;
        await LocalServices.storeUser(userModel.value);
        fetchEnrollmentData();
        //await LocalServices.storeUserEnrollment(response.value.userEnrollment);
        CustomSnackBar( msg:response.value.msg!,isSuccess: true).showSnackBar();
      }else{
        CustomSnackBar( msg:AppStrings.httpErrorMSG.value,isSuccess: false).showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void submitForm() {
   // LocalServices.deleteData();
    fetchData();
  }

  void openHomeScreen() {

    if((userEnrollmentData.value.userEnrollment?.length??0)<1){
      Get.offAllNamed("/enrollment_list_page");
    }else{
     if(response.value.userAssessmentCompleted??false){
       Get.offAllNamed("/home_page");
     }else{
       Get.offAllNamed("/assessment_test_page");
     }
    }
  }

  void fetchEnrollmentData()async{
    isLoading.value=true;
    var endPoint=AppStrings.getUserEnrollmentEndpoint;
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        userEnrollmentData.value=UserEnrollmentDataModel2.fromJson(data);
        LocalServices.storeUserEnrollment(userEnrollmentData.value);
        openHomeScreen();
        isLoading.value=false;
      }
    }finally{
      isLoading.value=false;
    }
  }

  void resetPassword()async {
    isLoading.value=true;
    var endPoint=AppStrings.requestOTP;
    var body={
      "email":resetPasswordEmailController.text
    };
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(response!=null){

        var session=response["data"]["sessionId"];

       Get.put(OtpController()).email.value=resetPasswordEmailController.text;
       Get.find<OtpController>().session=session;
        Get.toNamed("/otp_page");

      }
    } finally {
      isLoading.value=false;

    }

  }

}