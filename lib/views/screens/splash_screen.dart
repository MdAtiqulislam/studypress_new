import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/splash_screen_controller.dart';
class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);

  final SplashScreenController controller=Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
                "assets/app_logo.png",
            width: 320,
             // height: 100,
            ),
          ),
          SizedBox(height: AppDimensions.sectionPaddingVer,),
        //  HeaderText(text: "Welcome to StudyPress",size: 26,color: AppColors.appPrimaryColor,),

          SizedBox(height: AppDimensions.widgetPaddingVer,),
          const SizedBox(
              width:320,
              child: LinearProgressIndicator(color: AppColors.appPrimaryColor,))
        ],
      ),
    );
  }
}
