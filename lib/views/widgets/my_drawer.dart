//import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'dart:io';

import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studypress_new/controllers/subject_list_controller.dart';


import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/app_links_controller.dart';
import '../../controllers/drawer_controller.dart';
import '../../controllers/home_page_data_controller.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../../controllers/test_controller.dart';
import '../../utilities/utils.dart';
import 'basic_grid_item.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final MyDrawerController myDrawerController = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    myDrawerController.fetchEnrollmentData();
    return Obx(
      () => Drawer(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? Get.width * .8
            : Get.width * .5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       /* const CircleAvatar(
                          maxRadius: 30,
                          minRadius: 30,
                          backgroundImage: AssetImage("assets/images/man.png"),
                        ),*/
                        CircleAvatar(
                          minRadius: 20.sp,
                          maxRadius: 20.sp,
                          backgroundColor: AppColors.appPrimaryColor,
                          child: Text(
                            getInitials(myDrawerController.user.value.data?.name ?? ""),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                        ),
                        SizedBox(height: AppDimensions.contentPaddingVer.h,),

                        HeaderText(
                            text:
                                myDrawerController.user.value.data?.name ?? "",resizeable: false,),
                        BodyText(
                            text:
                                "Mobile: ${myDrawerController.user.value.data?.details?.phone ?? ""}",resizeable: false,),
                        BodyText(
                            text:
                                "Email: ${myDrawerController.user.value.data?.email ?? ""}",resizeable: false,),
                      ],
                    ),
                    Positioned(
                      right: 0,
                        top: 0,
                        child: IconButton(onPressed: (){
                          Get.toNamed("/user_profile_page");
                        }, icon: Icon(Icons.edit)))
                  ],
                ),
              ),
              BasicGridItem(
                  callback: () {
                    HomePageDataController homepageController =
                        Get.put(HomePageDataController());
                    homepageController.isLoadingHomePageData.value = true;
                    homepageController.isLoadingStrengthData.value = true;
                    homepageController.fetchStrengthAndWeaknessData();
                    //fetchHomePageData();
                    homepageController.fetchDashBoardData();
                    Get.offAllNamed("/home_page");
                  },
                  // height: 30.h,
                  //imageSize: 30,
                  imageSize: 25,
                  gapBetween: 10,
                  isGradientColour: false,
                  index: 0,
                  bgColor: Colors.transparent,
                  titleTextColor: AppColors.appHeaderTextColor,
                  titleTextSize: 16,
                  titleFontWight: FontWeight.normal,
                  title: "Dashboard",
                  image: "assets/icons/dashboard.png"),
              SizedBox(
                height: AppDimensions.contentPaddingVer,
              ),
              BasicGridItem(
                  callback: () {
                    Get.offAndToNamed("/enrollment_list_page");
                  },
                  // height: 30.h,
                  //imageSize: 30,
                  imageSize: 25,
                  gapBetween: 10,
                  isGradientColour: false,
                  index: 0,
                  bgColor: Colors.transparent,
                  titleTextColor: AppColors.appHeaderTextColor,
                  titleTextSize: 16,
                  titleFontWight: FontWeight.normal,
                  title: "My Enrollments",
                  image: "assets/icons/img.png"),

            /*  SizedBox(
                height: AppDimensions.contentPaddingVer,
              ),
              BasicGridItem(
                  callback: () {
                    Get.offAndToNamed("/my_subscriptions_page");
                  },
                  // height: 30.h,
                  //imageSize: 30,
                  imageSize: 25,
                  gapBetween: 10,
                  isGradientColour: false,
                  index: 0,
                  bgColor: Colors.transparent,
                  titleTextColor: AppColors.appHeaderTextColor,
                  titleTextSize: 16,
                  titleFontWight: FontWeight.normal,
                  title: "My Subscription",
                  image: "assets/icons/diamond.png"),
*/

              myDrawerController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myDrawerController.userEnrollmentModel.value
                              .userEnrollment?.length ??
                          0,
                      itemBuilder: (buildContext, index) {
                     return ConfigurableExpansionTile(
                          animatedWidgetFollowingHeader: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.expand_more,
                              color: AppColors.appHeaderTextColor,
                            ),
                          ),
                          header: (bool isExpanded, Animation<double> iconTurns, Animation<double> heightFactor, ConfigurableExpansionTileController controller) {
                            return Flexible(
                              child: BasicGridItem(
                                imageSize: 25,
                                callback: () {},
                                gapBetween: 10,
                                isGradientColour: false,
                                index: 0,
                                bgColor: Colors.transparent,
                                titleTextColor: AppColors.appHeaderTextColor,
                                title: myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].name ?? "",
                                image: index == 0 ? "assets/icons/study.png" : "assets/moc_icons/moc_icons_3.png",
                                titleFontWight: FontWeight.normal,
                                titleTextSize: 16,
                              ),
                            );
                          },
                          childrenBody: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              _buildChildGridItem("Read and Practice", "assets/icons/open-book.png", () {
                                Get.put(SubjectListController()).fetchSubjectListData(id: myDrawerController.userEnrollmentModel.value.enrollmentCategoryList![index].id.toString());

                                Get.offAndToNamed("/subject_list_page", arguments: [
                                  myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].id.toString()
                                ]);
                              }),
                              _buildChildGridItem("Previous Job Tests", "assets/icons/question.png", () {
                                final testController = Get.put(TestController());
                                testController.parentId.value = myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].id.toString() ?? "";
                                testController.endPoint.value = AppStrings.getPreviousYearQuestionsListEndPoint;
                                testController.getPreviousJobTestListData();
                                Get.offAndToNamed("/model_test_list_page", arguments: [
                                  myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].name,
                                  "Previous Job Tests",
                                ]);
                              }),
                              _buildChildGridItem("ModelTest", "assets/icons/test.png", () {
                                final testController = Get.put(TestController());
                                testController.parentId.value = myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].id.toString() ?? "";
                                testController.endPoint.value = AppStrings.getModelTestListEndPoint;
                                testController.getModelTestListData();
                                Get.offAndToNamed("/model_test_list_page", arguments: [
                                  myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].name,
                                  "Model Test"
                                ]);
                              }),
                              _buildChildGridItem("Mistake List", "assets/icons/mistake_list.png", () {
                                final controller = Get.put(PractiseChapterController());
                                controller.id.value = myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].id.toString() ?? "";
                                controller.isLoading.value = true;
                                controller.fetchMistakeListData();
                                controller.isMistake.value = true;
                                controller.isPractise.value = false;
                                controller.resetStats();
                                Get.toNamed("/practise_page", arguments: ["id", "Mistake List"]);
                              }),
                              _buildChildGridItem("Review List", "assets/icons/reviews.png", () {
                                final controller = Get.put(PractiseChapterController());
                                controller.id.value = myDrawerController.userEnrollmentModel.value.enrollmentCategoryList?[index].id.toString() ?? "";
                                controller.isLoading.value = true;
                                controller.fetchPracticeReviewListData();
                                controller.isReview.value = true;
                                controller.isPractise.value = false;
                                controller.resetStats();
                                Get.toNamed("/practise_page", arguments: ["id", "Review List"]);
                              }),
                            ],
                          ),
                        );

                      }),
              const Divider(),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),
              BasicGridItem(
                imageSize: 25,
                callback: () {
                  TestController testController = Get.put(TestController());
                  testController.isLoading.value = true;
                  testController.getLiveTestListData();

                  Get.offAndToNamed("/live_test_list_page");
                },
                // height: 30.h,

                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: const Color(0xFFFF0303),
                titleTextColor: Colors.white,
                titleTextSize: 16,
                title: "Live ModelTest",
                image: "assets/icons/live.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),
              BasicGridItem(
                imageSize: 25,
                callback: () {
                  Get.toNamed("/contact_us_page");
                },
                // height: 30.h,
                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: Colors.transparent,
                titleTextColor: AppColors.appHeaderTextColor,
                titleTextSize: 16,
                title: "Contact Us",
                image: "assets/icons/contact_us.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),

              //Share Button
              BasicGridItem(
                imageSize: 25,
                callback: () {
                  AppLinksController appLinkController =
                      Get.put(AppLinksController());
                  appLinkController.shareApp();
                },
                //height: 30.h,
                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: Colors.transparent,
                titleTextColor: AppColors.appHeaderTextColor,
                titleTextSize: 16,
                title: "Share With Friends",
                image: "assets/icons/share.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),

              //Rate Button
              BasicGridItem(
                imageSize: 25,
                callback: () {
                  AppLinksController appLinksController =
                      Get.put(AppLinksController());
                  appLinksController.rateApp();
                },
                // height: 30.h,
                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: Colors.transparent,
                titleTextColor: AppColors.appHeaderTextColor,
                titleTextSize: 16,
                title: "Rate Us",
                image: "assets/icons/rating.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),

              BasicGridItem(
                splashColor: Colors.red,
                imageSize: 25,
                callback: () {
                  myDrawerController.logout();
                },
                // height: 30.h,
                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: Colors.transparent,
                titleTextColor: AppColors.appHeaderTextColor,
                titleTextSize: 16,
                title: "Log Out",
                image: "assets/icons/log_out.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              ),
              if(Platform.isIOS)BasicGridItem(
                splashColor: Colors.red,
                imageSize: 25,
                callback: () {
                  myDrawerController.deleteAccount();
                },
                // height: 30.h,
                gapBetween: 10,
                isGradientColour: false,
                index: 0,
                bgColor: Colors.transparent,
                titleTextColor: AppColors.appHeaderTextColor,
                titleTextSize: 16,
                title: "Delete Account",
                image: "assets/icons/delete_icon.png",
                titleFontWight: FontWeight.normal,
              ),
              SizedBox(
                height: AppDimensions.bottomPadding,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildGridItem(String title, String iconPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
      child: BasicGridItem(
        imageSize: 30,
        callback: onTap,
        height: 30.h,
        gapBetween: 10,
        isGradientColour: false,
        index: 0,
        bgColor: Colors.transparent,
        titleTextSize: 14,
        titleTextColor: AppColors.appHeaderTextColor,
        title: title,
        image: iconPath,
        titleFontWight: FontWeight.normal,
      ),
    );
  }

}
