import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/contact_us_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/circular_button.dart';
import '../widgets/my_drawer.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({Key? key}) : super(key: key);
  final ContactUsPageController controller = Get.put(ContactUsPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white ,
            iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
            title: HeaderText(
              text: "Contact Us",
              color: AppColors.appHeaderTextColor,
            ),
          ),
          body: controller.isLoading.value
              ? const LoadingScreen()
              : Padding(
                padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.leftPadding,
                      vertical: AppDimensions.topPadding),
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/contact_us_bg_image.png"),
                            opacity: .3),
                        color: Colors.deepPurple.shade50),
                  child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    HeaderText(
                                      text: "Do you have any Questions?",
                                      size: 30,
                                      color: AppColors.appPrimaryHeaderColor,
                                      maxLine: 2,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.widgetPaddingVer,
                                    ),
                                    BodyText(
                                      text:
                                          "If you need any help, you can always contact us. We will answer to you shortly!",
                                      color: AppColors.appSecondaryColor,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.widgetPaddingVer,
                                    ),
                                    const Icon(
                                      Icons.headset_mic_outlined,
                                      color: AppColors.appPrimaryHeaderColor,
                                      size: 40,
                                    ),
                                    HeaderText(
                                      text: controller.contactData.value.data
                                              ?.phone ??
                                          "",
                                      color: AppColors.appPrimaryHeaderColor,
                                      size: 25,
                                    ),
                                    BodyText(
                                      text: controller.contactData.value.data
                                              ?.phoneText ??
                                          "",
                                      color: AppColors.appPrimaryColor,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.widgetPaddingVer,
                                    ),
                                    const Icon(
                                      Icons.email_outlined,
                                      color: AppColors.appPrimaryHeaderColor,
                                      size: 40,
                                    ),
                                    HeaderText(
                                      text: controller.contactData.value.data
                                              ?.email ??
                                          "",
                                      color: AppColors.appPrimaryHeaderColor,
                                      size: 25,
                                    ),
                                    BodyText(
                                      text: controller.contactData.value.data
                                              ?.emailText ??
                                          "",
                                      color: AppColors.appPrimaryColor,
                                    ),
                                  ]),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularButton(
                                    offset: const Offset(0, 2),
                                    callback: () {
                                      final url = Uri.parse(
                                          "tel:${controller.contactData.value.data?.phone ?? ""}");
                                      launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    bgColor: AppColors.appPrimaryColor,
                                    child: const Icon(
                                      Icons.headset_mic_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.widgetPaddingHor,
                                  ),
                                  CircularButton(
                                    offset: const Offset(0, 2),
                                    callback: () {
                                      final url = Uri.parse(
                                          "mailto:${controller.contactData.value.data?.email ?? ""}");
                                      launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    bgColor: AppColors.appPrimaryColor,
                                    child: const Icon(
                                      Icons.mail_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
