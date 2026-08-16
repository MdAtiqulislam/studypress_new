import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../constraints/header_text.dart';
import '../../constraints/app_colors.dart';
import '../widgets/circular_button.dart';
import 'login_pages_bg.dart';

class LoginPhonePage extends StatelessWidget {
   LoginPhonePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appPrimaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appPrimaryAccentColor
                                      .withOpacity(.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      -3, 10), // changes position of shadow
                                ),
                              ]),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 32,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Form(
                      key: _otpFormKey,
                      child: Padding(
                        padding: EdgeInsets.all(50.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.w,
                            ),
                            Image.asset("assets/logo.png"),
                            SizedBox(
                              height: 20.h,
                            ),
                            phoneTextField(),
                            SizedBox(
                              height: 20.h,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.appSecondaryColor),
                                    elevation: MaterialStateProperty.all(10),
                                    shadowColor: MaterialStateProperty.all(
                                        AppColors.appPrimaryAccentColor
                                            .withOpacity(.5))),
                                onPressed: () {},
                                child: const Text("Login")),
                            const Divider(
                              thickness: 5,
                              color: AppColors.appPrimaryColor,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularButton(
                                  bgColor: Colors.white,
                                  child: const Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.cyan,
                                    size: 32,
                                  ),
                                  callback: () {
                                    Get.offAndToNamed("login_email_page");
                                  },
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CircularButton(
                                  callback: () {},
                                  bgColor: Colors.white,
                                  child: const Icon(
                                    FontAwesomeIcons.facebook,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CircularButton(
                                  callback: () {},
                                  bgColor: Colors.white,
                                  child: const Icon(
                                    FontAwesomeIcons.googlePlus,
                                    size: 32,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CircularButton(
                                  callback: () {},
                                  bgColor: Colors.white,
                                  child: const Icon(
                                    FontAwesomeIcons.apple,
                                    size: 32,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed("registration_page");
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
                                              .withOpacity(.5),
                                          blurRadius: 10,
                                          offset: const Offset(-3, 5),
                                        )
                                      ]),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Register Here',
                                      style: TextStyle(
                                          color: AppColors.appSecondaryColor,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                    )
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
          ],
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(-3, 10), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          onChanged:(s){
            _otpFormKey.currentState!.validate();
          },
         // controller: getOTPController.phoneController,
          validator: (value) {
            if(value!.length>2&&
                (value.isEmpty||
                    !value.startsWith("0")||
                    value[1]!="1"||
                    value[2]=="1"||
                    value[2]=="2"||
                    !value.isNumericOnly||
                    value.length<11) ) {
              return 'Please enter valid phone number';
            }
            return null;
          },
          maxLength: 11,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.phone,
         // cursorColor: AppColors.mainColorRed,
          cursorWidth: .5,
          decoration: InputDecoration(
            /* border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),*/
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.appSecondaryColor),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Image(
                      height: 24.h,
                      image: const AssetImage("assets/flag.png")),
                  SizedBox(
                    width: 20.w,
                  ),
                  HeaderText(
                    text: "+88 ",
                    align: TextAlign.start,
                    size: 18,
                  )
                ],
              ),
            ),
            // labelText: "login with your phone",
            hintText: "login with your phone",
            // labelStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        )
      ),
    );
  }

}
