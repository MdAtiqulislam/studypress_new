import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/header_text.dart';
import '../../controllers/login_email_page_controller.dart';
import '../../controllers/social_login_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import 'login_pages_bg.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  final SocialLoginController socialLoginController = Get.put(
    SocialLoginController(),
  );
  final GlobalKey<FormState> _loginEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetPasswordFormKey = GlobalKey<FormState>();

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: CircularButton(
                          bgColor: Colors.white,
                          callback: () {},
                          child: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppColors.appSecondaryColor,
                          ),
                        ),
                      ),
                      Form(
                        key: _loginEmailFormKey,
                        child: Padding(
                          padding: EdgeInsets.all(50.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.asset("assets/app_logo.png"),
                              ),
                              SizedBox(height: 20.h),
                              emailTextField(),
                              SizedBox(height: 20.h),
                              passwordTextField(),
                              SizedBox(height: 20.h),

                              //login with button
                              AppButton(
                                onTap: () {
                                  if (_loginEmailFormKey.currentState!
                                      .validate()) {
                                    controller.submitForm();
                                  }
                                },

                                bgColor: AppColors.appSecondaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: SizedBox(
                                    width: Get.width,
                                    child: HeaderText(
                                      text: "Login",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h,),
                              TextButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      child: Obx(()=>Stack(
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                HeaderText(
                                                  text: "Forgot Password? 🔒",
                                                  size: 18,
                                                  align: TextAlign.start,
                                                ),
                                                SizedBox(height: 50.h),
                                                BodyText(
                                                  text:
                                                  "Enter your email and we'll send you OTP to reset your password",
                                                  size: 14,
                                                  align: TextAlign.start,
                                                ),
                                                 SizedBox(height: 20.h),
                                            
                                                Form(
                                                  key: _resetPasswordFormKey,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                            
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                          !value.isEmail) {
                                                        return "Please enter valid Email";
                                                      }
                                                      return null;
                                                    },
                                                    controller: controller
                                                        .resetPasswordEmailController,
                                                    decoration: InputDecoration(
                                                      labelText: "Email Address",
                                                      hintText: "example@abc.com",
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                      ),
                                                      prefixIcon: const Icon(
                                                        Icons.email,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 50.h),
                                            
                                                AppButton(
                                                  bgColor:
                                                  AppColors.appPrimaryColor,
                                                  child: SizedBox(
                                                    width: Get.width,
                                                    child: HeaderText(
                                                      text: "Send OTP",
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    if (_resetPasswordFormKey
                                                        .currentState
                                                        ?.validate() ??
                                                        false) {
                                                      controller.resetPassword();
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                          ),
                                          if (controller.isLoading.value)
                                            Center(
                                              child:
                                              CircularProgressIndicator(),
                                            ),
                                        ],
                                      )),
                                    ),
                                  );
                                },
                                child:  Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    //color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              const Divider(
                                thickness: 5,
                                color: AppColors.appPrimaryColor,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //login with facebook
                                  CircularButton(
                                    bgColor: Colors.white,
                                    callback: () {
                                      // SocialLoginController socialLoginController=Get.put(SocialLoginController());
                                      socialLoginController.facebookLogin();
                                    },
                                    child: const Icon(
                                      FontAwesomeIcons.facebook,
                                      size: 32,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  //Login with google
                                  CircularButton(
                                    callback: () {
                                      //SocialLoginController socialLoginController=Get.put(SocialLoginController());
                                      socialLoginController.googleLogin();
                                    },
                                    bgColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/icons/google_log_in.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ) /*const Icon(
                                      FontAwesomeIcons.google,
                                      size: 32,
                                      color: Colors.pink,
                                    )*/,
                                  ),
                                  if (Platform.isIOS) SizedBox(width: 10.w),
                                  if (Platform.isIOS)
                                    CircularButton(
                                      callback: () {
                                        socialLoginController.appleLogin();
                                      },
                                      bgColor: Colors.white,
                                      child: const Icon(
                                        FontAwesomeIcons.apple,
                                        size: 32,
                                      ),
                                    ),
                                  if (Platform.isIOS) SizedBox(width: 10.w),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              InkWell(
                                onTap: () {
                                  Get.toNamed("registration_page");
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't Have an Account?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      shadows: [
                                        Shadow(
                                          color: AppColors.appPrimaryAccentColor
                                              .withAlpha((.5 * 254).toInt()),
                                          blurRadius: 10,
                                          offset: const Offset(-3, 5),
                                        ),
                                      ],
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' Register Here',
                                        style: TextStyle(
                                          color:
                                              AppColors.appPrimaryHeaderColor,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading.value ||
                  socialLoginController.isLoading.value)
                const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
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
          controller: controller.emailController,
          validator: (value) {
            if (value!.isEmpty || !value.isEmail) {
              return "Please enter valid Email";
            }
            return null;
          },
          style: TextStyle(fontSize: 14.sp),

          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(

            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Email",
            hintText: "example@abc.com",
            labelStyle:  TextStyle(color: Colors.black,fontSize:14.sp ),
            hintStyle:  TextStyle(color: AppColors.inactiveColor,fontSize:14.sp ),

            floatingLabelStyle: TextStyle(
              color: AppColors.appSecondaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.red,
            hoverColor: Colors.red,
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
          style: TextStyle(fontSize: 14.sp),
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
            labelStyle:  TextStyle(color: Colors.black,fontSize:14.sp ),
            hintStyle:  TextStyle(color: AppColors.inactiveColor,fontSize:14.sp ),

            floatingLabelStyle: TextStyle(
              color: AppColors.appSecondaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Password",
            hintText: "********",
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
