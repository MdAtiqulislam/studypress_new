import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:studypress_new/constraints/app_strings.dart';
import 'package:studypress_new/controllers/reset_password_controller.dart';
import '../../../../services/remote_services.dart';
import '../models/login_email_model.dart';
import '../utilities/show_snack_bar.dart';


class OtpController extends GetxController {
  var isLoading = false.obs;
  var isValidate = false.obs;
  var wrongOTP = false.obs;
  var resendOtpTime = 60.obs;
  var otp = "";
  var loginModel = LoginModel();

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  Timer? timer;

  var email = "".obs;
  var session="";

  @override
  Future<void> onInit() async {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {}

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTime.value > 0) {
        resendOtpTime.value--;
      }
      if (resendOtpTime.value <= 0) {
        resendOtpTime.value = 0;
        timer.cancel();
      }
      if (isValidate.value) {
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    isLoading.value = true;
    final endPoint = AppStrings.resendOTP;
    final body = {
      "email":email.value
    };

    try {
      final response =
      await RemoteServices.postRequest(endPoint: endPoint, body: body,);
      if (response != null) {
        isLoading.value = false;
        resendOtpTime.value = 180;
        startTimer();
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"],
        ).showSnackBar();
      } else {
        isLoading.value = false;
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackBar(
        isSuccess: false,
        msg: '$e',
      ).showSnackBar();
    }
  }

  void checkOtpLength(String? value) {
    if ((value ?? "").length >= 6) {
      for (int i = 0; i < 6; i++) {
        [c1, c2, c3, c4, c5, c6][i].text = value![i];
      }
      verifyOTP();
    }
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    var endPoint = AppStrings.verifyOTP;
    String otp = "${c1.text}${c2.text}${c3.text}${c4.text}${c5.text}${c6.text}";

    var body = {"otp": otp, "session_id": session};

    try {
      var response =
      await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isValidate.value = true;
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
        wrongOTP.value=true;
      }
    } catch (e) {
      CustomSnackBar(
          isSuccess: false,
          msg: "OTP verification failed. Please try again.")
          .showSnackBar();
    } finally {
      isLoading.value = false;
    }
  }

  void handelNext() {
    Get.put(ResetPasswordController()).email=email.value;
    Get.offAllNamed("/reset_password_page");
  }
}
