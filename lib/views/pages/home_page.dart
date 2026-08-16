import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/app_links_controller.dart';
import '../../controllers/course_details_controller.dart';
import '../../controllers/drawer_controller.dart';
import '../../controllers/home_page_data_controller.dart';
import '../../controllers/mistake_and_review_list_item_page_controller.dart';
import '../../utilities/utils.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/card_with_percentage.dart';
import '../widgets/category_performenceProgressChart.dart';
import '../widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageDataController controller = Get.put(HomePageDataController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: AppDimensions.topPadding),
                    child: appBarSection(),
                  ),
                  SizedBox(
                    height: AppDimensions.widgetPaddingVer,
                  ),
                  if (controller.isLoadingHomePageData.value)
                    SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 250.h
                          : 130.w,
                      child: const Card(
                        child: Center(
                          child: LoadingScreen(),
                        ),
                      ),
                    )
                  else
                    const CategoryPerformanceProgressCart(
                        // data: controller.categoryPerformanceData.value,
                        ),
                  if (controller.categoryPerformanceData.isNotEmpty)
                    SizedBox(
                      height: AppDimensions.widgetPaddingVer,
                    ),
                  controller.isLoadingStrengthData.value
                      ? const SizedBox(
                          height: 50,
                          child: LoadingScreen(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.userStrengthAndWeaknessData
                                  .value.list?.length ??
                              0,
                          itemBuilder: (buildContext, index) {
                            return CardWithPercentage(
                              value: controller.userStrengthAndWeaknessData
                                      .value.list?[index]?.marksPercentage ??
                                  0,
                              title: (controller.userStrengthAndWeaknessData
                                          .value.list?[index]?.chapterId !=
                                      null)
                                  ? (controller.userStrengthAndWeaknessData
                                          .value.list?[index]?.chapter?.name ??
                                      "")
                                  : (controller.userStrengthAndWeaknessData
                                              .value.list?[index]?.subjectId !=
                                          null)
                                      ? (controller
                                              .userStrengthAndWeaknessData
                                              .value
                                              .list?[index]
                                              ?.subject
                                              ?.name ??
                                          "")
                                      : (controller
                                              .userStrengthAndWeaknessData
                                              .value
                                              .list?[index]
                                              ?.category
                                              ?.name ??
                                          ""),
                              text: "You Scored less then 95% of our users",
                            );
                          }),
                  if ((controller.userStrengthAndWeaknessData.value.list ?? [])
                      .isNotEmpty)
                    SizedBox(
                      height: AppDimensions.widgetPaddingVer,
                    ),
                  titleSection(title: "More Courses"),
                  SizedBox(height: AppDimensions.widgetPaddingVer),
                  courseItemSection(),
                  SizedBox(height: AppDimensions.widgetPaddingVer),
                  quoteSection(),
                  SizedBox(
                    height: AppDimensions.widgetPaddingVer,
                  ),
                  titleSection(title: "Explore More"),
                  SizedBox(
                    height: AppDimensions.widgetPaddingVer,
                  ),
                  moreAppsSection(),
                  if ((controller
                              .dashBoardData.value.whatHappenedToday?.length ??
                          0) >
                      0)
                    Column(
                      children: [
                        SizedBox(
                          height: AppDimensions.widgetPaddingVer,
                        ),
                        titleSection(title: "On This Day"),
                        SizedBox(
                          height: AppDimensions.widgetPaddingVer,
                        ),
                        onThisDaySection(),
                      ],
                    ),
                  SizedBox(
                    height: AppDimensions.widgetPaddingVer,
                  ),
                  BasicGridItem(
                      imageSize: 60,
                      gapBetween: 20,
                      titleTextSize: 18,
                      callback: () {
                        Get.toNamed("/contact_us_page");
                      },
                      index: 0,
                      title: "Contact Us",
                      subTitle: "If you have any quires please contact with us",
                      image: "assets/icons/contact_us.png"),
                  SizedBox(
                    height: AppDimensions.widgetPaddingVer,
                  ),

                  //share Button

                  BasicGridItem(
                      splashColor: AppColors.appSecondaryColor,
                      callback: () {
                        AppLinksController appLinkController =
                            Get.put(AppLinksController());
                        appLinkController.shareApp();
                      },
                      index: 0,
                      gapBetween: 20,
                      imageSize: 60,
                      title: "Share With Friends",
                      titleTextSize: 18,
                      subTitle: "If you have any quires please contact with us",
                      image: "assets/icons/share.png"),
                  SizedBox(
                    height: AppDimensions.bottomPadding,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarSection() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed("/user_profile_page");
            },
            child: Row(
              children: [
                /*const CircleAvatar(
                  minRadius: 30,
                  maxRadius: 30,
                  backgroundImage: AssetImage("assets/images/man.png"),
                ),*/
                CircleAvatar(
                  minRadius: 20.sp,
                  maxRadius: 20.sp,
                  backgroundColor: AppColors.appPrimaryColor,
                  child: Text(
                    getInitials(controller.userData.value.data?.name ?? ""),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                ),

                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                        text: "Welcome",
                        fontWeight: FontWeight.normal,
                        align: TextAlign.start,
                      ),
                      HeaderText(
                        text: controller.userData.value.data?.name ?? "",
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              splashColor: AppColors.appSecondaryColor,
              onTap: () {
                Get.toNamed("/user_profile_page");
              },
              child: Icon(
                Icons.settings,
                size: 36.sp,
                color: AppColors.appHeaderTextColor,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              splashColor: AppColors.appSecondaryColor,
              onTap: () {},
              child: Icon(
                Icons.notifications_outlined,
                size: 36.sp,
                color: AppColors.appHeaderTextColor,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              splashColor: AppColors.appSecondaryColor,
              onTap: () {
                if (_scaffoldKey.currentState!.isDrawerOpen) {
                  _scaffoldKey.currentState!.closeDrawer();
                } else {
                  MyDrawerController myDrawerController =
                      Get.put(MyDrawerController());
                  myDrawerController.user.refresh();
                  //   print((myDrawerController.user.value.data?.name??""));
                  _scaffoldKey.currentState!.openDrawer();
                }
              },
              child: Icon(
                Icons.menu,
                size: 36.sp,
                color: AppColors.appHeaderTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget courseItemSection() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5.w,
            childAspectRatio: 2.3),
        itemCount: controller.userEnrollmentModel.value.courseList?.length ?? 0,
        itemBuilder: (buildContext, index) {
          return BasicGridItem(
            callback: () {
              CourseDetailsController courseDetailsController =
                  Get.put(CourseDetailsController());
              courseDetailsController.isLoading.value = true;
              courseDetailsController.id.value =
                  (controller.userEnrollmentModel.value.courseList?[index].id ??
                          0)
                      .toString();
              courseDetailsController.getCourseDetailsData();
              Get.toNamed("/course_details_page");
            },
            index: index,
            titleTextSize: 14,
            subTitleSize: 10,
            image: "assets/icons/course.png",
            title:
                controller.userEnrollmentModel.value.courseList?[index].title ??
                    "",
            subTitle:
                "Starts on ${DateFormat('MMMM d, yyyy').format(controller.userEnrollmentModel.value.courseList?[index].startDate ?? DateTime.now())}",
          );
        });
  }

  Widget quoteSection() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.appBodyTextColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
              text: "Quote of The Day",
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              height: 30.h,
            ),
            BodyText(
              text:
                  '"${controller.dashBoardData.value.quoteOfTheDay?.details ?? ""}"',
              maxLine: 20,
              color: Colors.white,
              size: 14,
              // align: TextAlign.start,
            ),
            SizedBox(
              width: Get.width,
              child: Text(
                "--${controller.dashBoardData.value.quoteOfTheDay?.author ?? ""}",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: AppDimensions.sectionPaddingVer,
            )
          ],
        ),
      ),
    );
  }

  Widget titleSection({required String title}) {
    return SizedBox(
      width: Get.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        color: AppColors.appTitleBGColor,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: HeaderText(
              text: title,
              color: Colors.white,
              align: TextAlign.start,
              size: 18),
        ),
      ),
    );
  }

  Widget moreAppsSection() {
    return GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 250,
      mainAxisSpacing: 5.h,
      crossAxisSpacing: 5.w,
      childAspectRatio: 2.5,
      children: [
        BasicGridItem(
          index: 4,
          title: "Vocabulary app",
          image: "assets/icons/dictionary.png",
          callback: () {
            Get.toNamed("/vocabulary_app_page");
          },
        ),
        BasicGridItem(
          index: 5,
          title: "Current Affairs",
          image: "assets/icons/worldwide.png",
          callback: () {
            Get.toNamed("/current_affairs_page");
          },
        ),
        BasicGridItem(
          index: 15,
          title: "Mistake List",
          image: "assets/icons/mistake_list.png",
          callback: () {
            MistakeAndReviewController controller =
                Get.put(MistakeAndReviewController());
            controller.isMistake.value = true;
            controller.isReview.value = false;
            controller.isLoading.value = true;
            controller.getMistakeCategoryList();
            controller.title.value = "Mistake List";
            Get.toNamed("/basic_list_items_page");
          },
        ),
        BasicGridItem(
          index: 7,
          title: "Review List",
          image: "assets/icons/reviews.png",
          callback: () {
            MistakeAndReviewController controller =
                Get.put(MistakeAndReviewController());
            controller.isReview.value = true;
            controller.isMistake.value = false;
            controller.isLoading.value = true;
            controller.getReviewCategoryList();
            //controller.getCurrentWorldReviewList();
            controller.title.value = "Review List";
            Get.toNamed("/basic_list_items_page");
          },
        ),
      ],
    );
  }

  Widget onThisDaySection() {
    return SizedBox(
      height: 250.h,
      child: Stack(
        children: [
          Swiper(
            itemCount:
                controller.dashBoardData.value.whatHappenedToday?.length ?? 0,
            itemBuilder: (buildContext, index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage("assets/images/hc.jpg"))),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black,
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.5)
                      ])),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: AppDimensions.topPadding,
                                  bottom: AppDimensions.sectionPaddingVer,
                                  left: AppDimensions.leftPadding,
                                  right: AppDimensions.leftPadding),
                              child: Wrap(
                                children: [
                                  // Image.network("https://upload.wikimedia.org/wikipedia/en/a/ae/Shawkat_Ali_%28novelist%29.jpg"),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: HeaderText(
                                      text: controller
                                              .dashBoardData
                                              .value
                                              .whatHappenedToday?[index]
                                              .title ??
                                          "",
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDimensions.widgetPaddingVer,
                                  ),
                                  Html(
                                    data: controller
                                            .dashBoardData
                                            .value
                                            .whatHappenedToday?[index]
                                            .details ??
                                        "",
                                    style: {
                                      "body": Style(
                                          padding:  HtmlPaddings.zero),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                            ),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: AppDimensions.leftPadding,
                              right: AppDimensions.leftPadding,
                              top: AppDimensions.sectionPaddingVer,
                              bottom: AppDimensions.sectionPaddingVer * 1.5),
                          child: Html(
                            data: controller.dashBoardData.value
                                    .whatHappenedToday?[index].details ??
                                "",
                            style: {
                              "body": Style(
                                  color: Colors.white,
                                  fontSize: FontSize(14.sp),
                                  fontWeight: FontWeight.normal,
                                  maxLines: 8,
                                  textOverflow: TextOverflow.ellipsis)
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            pagination: const SwiperPagination(),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: HeaderText(
              text: DateFormat('dd MMMM').format(DateTime.now()),
            ),
          ),
        ],
      ),
    );
  }
}
