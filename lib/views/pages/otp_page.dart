import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:studypress_new/constraints/header_text.dart';
import 'package:studypress_new/controllers/otp_controller.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import 'login_pages_bg.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final controller = Get.put(OtpController());

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
                            Get.back();
                          },
                          child: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppColors.appSecondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      otpSection(),
                      if (controller.wrongOTP.value)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BodyText(text: "OTP doesn’t match."),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: const BodyText(
                                    text: "Try with different account?",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: AppDimensions.sectionPaddingVer.h),
                      resendOTPSection(),
                      SizedBox(height: AppDimensions.sectionPaddingVer * 3.h),
                      Center(
                        child: IgnorePointer(
                          ignoring: !controller.isValidate.value,
                          child: AppButton(
                            onTap: () {
                              controller.handelNext();
                            },
                            bgColor: controller.isValidate.value
                                ? AppColors.appPrimaryColor
                                : AppColors.appPrimaryColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding.w),
                              child: HeaderText(
                                text: "Next",
                                color: Colors.white,
                              ),
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

  resendOTPSection() {
    return controller.isValidate.value
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(top: AppDimensions.sectionPaddingVer.h),
              child: Icon(
                Icons.check_circle_rounded,
                color: AppColors.appPrimaryColor,
                size: 46.sp,
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(text: "Didn’t receive the code?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: BodyText(
                      text: "You can request a new code after the time.",
                      align: TextAlign.start,
                    ),
                  ),

                  SizedBox(width: AppDimensions.sectionPaddingHor.w),
                  if (controller.resendOtpTime.value > 0)
                    BodyText(
                      text:
                          "${controller.resendOtpTime.value ~/ 60} min: ${controller.resendOtpTime.value % 60} Sec",
                      color: AppColors.appPrimaryColor,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  if (controller.resendOtpTime.value <= 0)
                    InkWell(
                      splashColor: Colors.white54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w, // AppDimensions.horizontalPadding,
                          vertical: 3.h,
                        ),
                        child: HeaderText(
                          text: "Resend Code",
                          color: AppColors.appPrimaryColor,
                          size: 12,
                        ),
                      ),
                      onTap: () {
                        controller.resendOTP();
                      },
                    ),

                  //    BodyText(text: "00:30 Sec",fontWeight: FontWeight.w500,color: AppColors.primaryColor,),
                ],
              ),
            ],
          );
  }

  otpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
          text: "Enter your 6 digit code we’ve sent to your email",
          size: 14,
          fontWeight: FontWeight.w600,
          align: TextAlign.start,
        ),
        SizedBox(height: AppDimensions.contentPaddingVer.h),
        BodyText(
          text: controller.email.value,
          size: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.inactiveColor,
        ),
        SizedBox(height: AppDimensions.sectionPaddingVer.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c1,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c2,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c3,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c4,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c5,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c6,
              onCompleted: (value) {
                if (value!.length == 1) {
                  controller.verifyOTP();
                }
                controller.checkOtpLength(value);
              },
              isLast: true,
            ),
            SizedBox(width: AppDimensions.contentPaddingHor.w),
          ],
        ),
      ],
    );
  }
}

class SingleOTPBox extends StatelessWidget {
  final bool? isLast;
  final bool verified;
  final bool wrongOTP;
  final void Function(String?) onCompleted;
  final TextEditingController? controller;

  const SingleOTPBox({
    this.isLast,
    required this.onCompleted,
    this.controller,
    this.wrongOTP = false,
    this.verified = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.sp,
      height: 45.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: verified
              ? AppColors.appPrimaryColor
              : wrongOTP
              ? AppColors.appErrorColor
              : AppColors.appBodyTextColor,
          width: 2,
        ),
      ),
      child: Center(
        child: TextFormField(
          enabled: !verified,
          controller: controller,
          keyboardType: TextInputType.number,
          textInputAction: (isLast ?? false)
              ? TextInputAction.done
              : TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            if (value.isNotEmpty) {
              onCompleted(value);
              if (!(isLast ?? false)) {
                FocusScope.of(context).nextFocus();
              }
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          cursorColor: AppColors.appPrimaryColor,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      ),
    );
  }
}
