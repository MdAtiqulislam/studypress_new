import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:studypress_new/constraints/app_strings.dart';
import 'package:studypress_new/services/remote_services.dart';
import 'package:studypress_new/utilities/show_snack_bar.dart';

class ResetPasswordController extends GetxController{
  var isLoading=false.obs;
  var email="";

  var confirmPasswordController=TextEditingController();

  var passwordController=TextEditingController();

  void saveNewPassword()async {
    isLoading.value=true;
    var endpoint=AppStrings.resetPassword;
    var body={
      "email":email,
      "password":passwordController.text
    };
    try {
      if(passwordController.text!=confirmPasswordController.text){
        CustomSnackBar(
          isSuccess: false,
          msg: "Your passwords don’t match, please try again"
        ).showSnackBar();
      }else{
        var response=await RemoteServices.postRequest(endPoint: endpoint,body: body);
        if(response!=null){
          Get.offAllNamed("/login_email_page");
          CustomSnackBar(
            isSuccess: true,
            msg: response["message"]
          ).showSnackBar();
          
        }
      }
    } finally {
      isLoading.value=false;
    }

  }

}