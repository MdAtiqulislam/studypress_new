

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../constraints/app_strings.dart';
import '../models/login_email_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';


class SocialLoginController extends GetxController{

  var response=LoginModel().obs;
  var isLoading=false.obs;
  var userModel=UserModel().obs;
  var userEnrollmentData=UserEnrollmentDataModel2().obs;


  void facebookLogin() async{

    try {
      isLoading.value=true;
      final result = await FacebookAuth.i.login(
        permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      );


      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();

        var email=(userData.toString().contains("email"))?userData['email']:"";
        var body = {
          'id': userData['id'].toString(),
          'name': userData['name'],
          'email':email,
          'photoUrl': userData["picture"]["data"]["url"]??"",
        };

        completeLogin(body:body,provider:"facebook");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }finally{
      isLoading.value=false;
    }
  }




   Future<void> googleLogin() async {
    isLoading.value = true;

    try {
      // Disconnect old sessions first
      await GoogleSignIn.instance.disconnect();
      await GoogleSignIn.instance.signOut();

      // Optional: if required for web or custom clientId usage
      await GoogleSignIn.instance.initialize(
          serverClientId: "154691716657-ed38q5bdkp73u05lpo97ku4b7ssjtsgl.apps.googleusercontent.com"
      );

      final completer = Completer<GoogleSignInAccount>();

      // Listen for sign-in event
      final subscription = GoogleSignIn.instance.authenticationEvents.listen(
            (event) {
          if (event is GoogleSignInAuthenticationEventSignIn) {
            completer.complete(event.user);
          }
        },
        onError: (error) {
          completer.completeError(Exception("Google Sign-In Error: $error"));
        },
      );

      // Trigger the sign-in prompt
      await GoogleSignIn.instance.authenticate();

      // Wait for result
      final result = await completer.future;

      // Cleanup listener
      await subscription.cancel();

      if (kDebugMode) {
        print("Google user info: ${result.displayName}, ${result.email}");
      }

      // Prepare body for API call
      final body = {
        'id': result.id,
        'name': result.displayName ?? "",
        'email': result.email,
        'photoUrl': result.photoUrl ?? "",
      };

      // Call your existing method
       completeLogin(body: body, provider: "google");
    } catch (e) {
      if (kDebugMode) {
        print("Google Login Error: $e");
      }
      CustomSnackBar(isSuccess: false, msg: "Login failed: $e").showSnackBar();
    } finally {
      isLoading.value = false;
    }
  }




  void appleLogin() async{
    isLoading.value=true;
      try {
        final result = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        if(result!=null){
          if (kDebugMode) {
            print(result);
          }
            var body = {
              'id': result.userIdentifier,
              'name': result.givenName??"",
              'email':result.email??"",
              //'photoUrl': result.photoUrl??"",
            };
          completeLogin(body: body,provider: "apple");
          }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }finally{
      isLoading.value=false;
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



  void completeLogin({required Map<String, dynamic> body, required String provider}) async{
    var endPoint="${AppStrings.socialLoginEndpoint}$provider";


    print(body);

    var data=await RemoteServices.postRequest(endPoint: endPoint,body: body);

    if(data!=null){
      response.value = LoginModel.fromJson(data);
      // AppStrings.httpResponseMSG.value = response.value.msg!;
      isLoading.value = false;
      await LocalServices.storeToken(response.value.accessToken??"");
      userModel.value.data=response.value.data!.data;
      userModel.value.userAssessmentCompleted=response.value.data!.userAssessmentCompleted;
      await LocalServices.storeUser(userModel.value);
      fetchEnrollmentData();
      //await LocalServices.storeUserEnrollment(response.value.userEnrollment);
      CustomSnackBar( msg:response.value.msg??"",isSuccess: true).showSnackBar();
      // ShowSnackBar( msg:response.value.msg!,isSuccess: true).showSnackBar();
      // openUserInfoScreen();
    }else{
      CustomSnackBar( msg:AppStrings.httpErrorMSG.value,isSuccess: false).showSnackBar();
    }
    await FacebookAuth.instance.logOut();
  }


}