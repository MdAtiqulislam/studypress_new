import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/header_text.dart';
import '../../controllers/registration_controller.dart';
import '../../controllers/social_login_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import 'login_pages_bg.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final RegistrationController registrationController = Get.put(RegistrationController());
  final SocialLoginController socialLogianController = Get.put(SocialLoginController());

  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
              () => Stack(
            children: [
              const LoginPagesBG(),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
                    child: Form(
                      key: _registrationFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 100, child: Image.asset("assets/app_logo.png")),
                          SizedBox(height: 20.h),
                          nameTextField(),
                          SizedBox(height: 20.h),
                          phoneTextField(),
                          SizedBox(height: 20.h),
                          emailTextField(),
                          SizedBox(height: 20.h),
                          passwordTextField(),
                          SizedBox(height: 20.h),
                          rePasswordTextField(),
                          SizedBox(height: 20.h),
                          AppButton(
                            bgColor: AppColors.appSecondaryColor,
                            onTap: () {
                              if (_registrationFormKey.currentState!.validate()) {
                                registrationController.submitForm();
                              }
                            },
                            child: SizedBox(
                              width: Get.width,
                              child: HeaderText(text: "Register", color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const Divider(thickness: 5, color: AppColors.appPrimaryColor),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularButton(
                                bgColor: Colors.white,
                                child: const Icon(FontAwesomeIcons.envelope, color: Colors.cyan, size: 32),
                                callback: () => Get.toNamed("login_email_page"),
                              ),
                              SizedBox(width: 10.w),
                              CircularButton(
                                callback: () => socialLogianController.facebookLogin(),
                                bgColor: Colors.white,
                                child: const Icon(FontAwesomeIcons.facebook, size: 32, color: Colors.blue),
                              ),
                              SizedBox(width: 10.w),
                              CircularButton(
                                callback: () => socialLogianController.googleLogin(),
                                bgColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/icons/google_log_in.png", height: 20, width: 20),
                                ),
                              ),
                              if (Platform.isIOS) ...[
                                SizedBox(width: 10.w),
                                CircularButton(
                                  callback: () {},
                                  bgColor: Colors.white,
                                  child: const Icon(FontAwesomeIcons.apple, size: 32),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 30.h),
                          InkWell(
                            onTap: () => Get.offAndToNamed("login_email_page"),
                            child: RichText(
                              text: TextSpan(
                                text: "Already Have an Account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  shadows: [
                                    Shadow(
                                      color: AppColors.appPrimaryAccentColor.withOpacity(.5),
                                      blurRadius: 10,
                                      offset: const Offset(-3, 5),
                                    )
                                  ],
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Login Here',
                                    style: TextStyle(
                                      color: AppColors.appPrimaryHeaderColor,
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
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.r),
                child: CircularButton(
                  callback: () => Get.back(),
                  bgColor: Colors.white,
                  child: const Icon(FontAwesomeIcons.arrowLeft, color: AppColors.appSecondaryColor),
                ),
              ),
              if (registrationController.isLoading.value || socialLogianController.isLoading.value)
                const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, required String hint}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
      hintStyle: TextStyle(color: AppColors.inactiveColor, fontSize: 14.sp),
      floatingLabelStyle: TextStyle(
        color: AppColors.appSecondaryColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget nameTextField() => _buildField(
    controller: registrationController.nameController,
    validator: (value) => value!.isEmpty ? "Please enter your full name" : null,
    label: "Name",
    hint: "Your Full Name",
  );

  Widget emailTextField() => _buildField(
    controller: registrationController.emailController,
    validator: (value) => value!.isEmpty || !value.isEmail ? "Please enter valid Email" : null,
    keyboardType: TextInputType.emailAddress,
    label: "Email",
    hint: "example@abc.com",
  );

  Widget phoneTextField() => _buildField(
    controller: registrationController.phoneController,
    validator: (value) {
      if(value==null||value.isEmpty){
        return null;
      }
      if (!value.startsWith("0") ||
              value[1] != "1" ||
              value[2] == "1" ||
              value[2] == "2" ||
              !value.isNumericOnly ||
              value.length < 11) {
        return 'Please enter valid phone number';
      }
      return null;
    },
    keyboardType: TextInputType.phone,
    label: "Phone",
    hint: "Enter your phone number",
  );

  Widget passwordTextField() => _buildField(
    controller: registrationController.passwordController,
    validator: (value) => value!.isEmpty ? "Password must not be empty" : null,
    label: "Password",
    hint: "Enter your password",
    obscureText: true,
  );

  Widget rePasswordTextField() => _buildField(
    controller: registrationController.reTypePasswordController,
    validator: (value) {
      if (value!.isEmpty) return "Password must not be empty";
      if (value != registrationController.passwordController.text) {
        return "Password not matched";
      }
      return null;
    },
    label: "Re type password",
    hint: "Re type password",
    obscureText: true,
  );

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(fontSize: 14.sp),
        cursorColor: AppColors.appSecondaryColor,
        cursorWidth: .5,
        decoration: _inputDecoration(label: label, hint: hint),
      ),
    );
  }
}
