import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:studypress_new/controllers/reset_password_controller.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import 'login_pages_bg.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final controller = Get.put(ResetPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: Stack(
            children: [
              const LoginPagesBG(),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.leftPadding.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: CircularButton(
                          bgColor: Colors.white,
                          callback: () {
                            Get.offAndToNamed("/login_email_page");
                          },
                          child: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppColors.appSecondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      SizedBox(height: AppDimensions.sectionPaddingVer.h),
                      HeaderText(
                        text: "Reset Password",
                        size: 20,
                        color: AppColors.appBodyTextColor,
                      ),
                      SizedBox(height: AppDimensions.sectionPaddingVer.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            passwordTextField(),
                            SizedBox(height: AppDimensions.widgetPaddingVer.h),
                            confirmPasswordTextField(),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.sectionPaddingVer.h),
                      const BodyText(
                        text:
                            "Your password must be 8 digits.\nMust Contain one Capital letter, one small letter, one number & one mark.",
                        align: TextAlign.start,
                      ),
                      SizedBox(height: AppDimensions.sectionPaddingVer * 2.h),
                      Center(
                        child: AppButton(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              print(">>>>>>>>>");
                              controller.saveNewPassword();
                            }
                          },
                          bgColor: AppColors.appPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.leftPadding.w,
                            ),
                            child: HeaderText(
                              text: "Reset",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withAlpha(
              (.3 * 254).toInt(),
            ),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          obscureText: true,
          controller: controller.passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password must not empty";
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
              color: AppColors.appSecondaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Password",
            hintText: "Enter your password",
            labelStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withAlpha(
              (.3 * 254).toInt(),
            ),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          obscureText: true,
          controller: controller.confirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password must not Empty";
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
              color: AppColors.appSecondaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Confirm password",
            hintText: "Re type password",
            labelStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
