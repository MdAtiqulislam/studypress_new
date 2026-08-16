import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/course_details_controller.dart';
import '../../controllers/mcq_test_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class CourseDetailsPage extends StatelessWidget {
  CourseDetailsPage({Key? key}) : super(key: key);

  final CourseDetailsController controller = Get.put(CourseDetailsController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });
    return SafeArea(
      child: Obx(() => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
            drawer: MyDrawer(),
              body: controller.isLoading.value
                  ? const LoadingScreen()
                  : Stack(
                      children: [
                        CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverAppBar(
                              toolbarHeight: 40.sp,
                              collapsedHeight: 40.sp,
                              iconTheme: const IconThemeData(
                                  color: AppColors.appHeaderTextColor),
                              // automaticallyImplyLeading: false,
                              pinned: true,
                              centerTitle: true,
                              floating: false,
                              snap: false,
                              //collapsedHeight: 40.sp,
                              backgroundColor: Colors.white,
                              flexibleSpace: FlexibleSpaceBar(
                                centerTitle: true,
                                title: HeaderText(
                                  text: "Course Details",
                                  color: AppColors.appHeaderTextColor,
                                ),
                                background: Stack(
                                  children: [
                                    const SliverAppBarBackground(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppDimensions.leftPadding),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          HeaderText(
                                            text: controller.response.value
                                                    .course?.title ??
                                                "".toUpperCase(),
                                            color: AppColors.appHeaderTextColor,
                                            size: 18,
                                          ),
                                          BodyText(
                                            text:
                                                "${controller.response.value.course?.duration} Day Crush Program",
                                            align: TextAlign.start,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.appHeaderTextColor,
                                  ),
                                ),
                              ],
                              expandedHeight: 180.sp,
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.leftPadding,
                                    vertical: AppDimensions.topPadding),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: Container(
                                    // height: 200.h,
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      AppColors.appPrimaryColor,
                                      AppColors.appSecondaryColor
                                    ])),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              HeaderText(
                                                text: controller.response.value
                                                        .course?.title ??
                                                    "".toUpperCase(),
                                                color: Colors.white,
                                              ),
                                              //SizedBox(height: Dimensions.widgetPaddingVer,),
                                              Html(
                                                data: controller.response.value
                                                        .course?.shortDesc ??
                                                    "",
                                                style: {
                                                  "body":
                                                      Style(color: Colors.white,)
                                                },
                                              ),
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.r))),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.grey.shade400,
                                                        Colors.grey.shade200,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.grey.shade200,
                                                        Colors.grey.shade400
                                                      ],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        HeaderText(
                                                          text: (controller
                                                                      .response
                                                                      .value
                                                                      .course
                                                                      ?.duration ??
                                                                  0)
                                                              .toString(),
                                                          color: AppColors
                                                              .appPrimaryColor,
                                                          size: 80,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        AppDimensions
                                                                            .widgetPaddingHor,
                                                                    vertical:
                                                                        15.h),
                                                            child: HeaderText(
                                                              text: "Day Crush Program"
                                                                  .toUpperCase(),
                                                              size: 28,
                                                              maxLine: 5,
                                                              align: TextAlign
                                                                  .start,
                                                              color: AppColors
                                                                  .appSecondaryColor,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    AppDimensions.widgetPaddingVer,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColors.appSuccessColor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(100.r)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(.3),
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(5, 0)),
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(.3),
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(0, -1)),
                                                ]),
                                            //height: 50,
                                            width: Get.width * .85,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: AppDimensions
                                                      .widgetPaddingHor,
                                                  right: AppDimensions.leftPadding,
                                                  top: AppDimensions
                                                      .widgetPaddingVer,
                                                  bottom: AppDimensions
                                                      .widgetPaddingVer),
                                              child: HeaderText(
                                                text: ("${DateFormat('MMMM dd, yyyy').format(controller.response.value.course?.startDate ?? DateTime.now())} - "
                                                    "${DateFormat('MMMM dd, yyyy').format(
                                                  (controller
                                                              .response
                                                              .value
                                                              .course
                                                              ?.startDate ??
                                                          DateTime.now())
                                                      .add(
                                                    Duration(
                                                        days: controller
                                                                .response
                                                                .value
                                                                .course
                                                                ?.duration ??
                                                            0),
                                                  ),
                                                )}"),
                                                color: Colors.white,
                                                maxLine: 10,
                                                align: TextAlign.start,
                                                size: 16,
                                                // fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: AppDimensions.contentPaddingVer,
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: controller.courseDetailsData
                                      .length, (buildContext, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.leftPadding,
                                      vertical: AppDimensions.widgetPaddingVer),
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.deepPurple.shade50,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      /* mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,*/
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.appPrimaryColor,
                                                  // borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100),),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(.3),
                                                      blurRadius: 5,
                                                      //offset: Offset(-2, 2)
                                                    ),
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(.3),
                                                        blurRadius: 10,
                                                        offset: const Offset(
                                                            -2, 3)),
                                                  ]),
                                              child: Center(
                                                //height: 50,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: AppDimensions
                                                            .sectionPaddingVer),
                                                    child: HeaderText(
                                                      text: "Contents",
                                                      color: Colors.white,
                                                      align: TextAlign.center,
                                                    )),
                                              ),
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: controller
                                                      .courseDetailsData[index]
                                                      .chapters
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (buildContext, index2) {
                                                //  print("controller.enrollmentData.value.enrollmentCategoryList?.length??0");
                                                return Padding(
                                                  padding: EdgeInsets.all(5.r),
                                                  child: BasicGridItem(
                                                    callback: () {
                                                      // controller.openPage(index:index);
                                                      Get.toNamed(
                                                          "/chapter_details_page",
                                                          arguments: [
                                                            controller
                                                                .courseDetailsData[
                                                                    index]
                                                                .chapters?[
                                                                    index2]
                                                                .id
                                                                .toString(),
                                                            controller
                                                                .response
                                                                .value
                                                                .course
                                                                ?.categoryId
                                                                .toString()
                                                          ]);
                                                    },
                                                    gapBetween: AppDimensions
                                                        .sectionPaddingHor,
                                                    index: index,
                                                    resizeable: true,

                                                    isGradientColour: false,
                                                    bgColor: Colors.transparent,
                                                    titleTextColor: AppColors
                                                        .appHeaderTextColor,
                                                    titleFontWight:
                                                        FontWeight.normal,
                                                    title: controller
                                                            .courseDetailsData[
                                                                index]
                                                            .chapters?[index2]
                                                            .name ??
                                                        "",
                                                    image:
                                                        "assets/moc_icons/moc_icons_${index2 % 10}.png",
                                                    //height: 40,
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: .5,
                                                  color: Colors.grey,
                                                );
                                              },
                                            ),
                                            Container(
                                              height: .5,
                                              color: Colors.grey,
                                            ),
                                            // SizedBox(height: Dimensions.contentPaddingVer,),
                                            SizedBox(
                                              height: 80.h,
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  BasicGridItem(
                                                    callback: () {
                                                      MCQTestController
                                                          mcqTestController =
                                                          Get.put(
                                                        MCQTestController(),
                                                      );
                                                      mcqTestController
                                                          .isLoading
                                                          .value = true;
                                                      mcqTestController
                                                          .formattedQuestions
                                                          .value = [];
                                                      mcqTestController
                                                          .questions.value = [];
                                                      mcqTestController
                                                          .currentAnswerIndex
                                                          .value = -1;
                                                      mcqTestController
                                                          .currentQuestionIndex
                                                          .value = 0;
                                                      mcqTestController.quizType
                                                          .value = "modelTest";
                                                      mcqTestController.testId
                                                          .value = controller
                                                              .courseDetailsData[
                                                                  index]
                                                              .modelTest
                                                              ?.id
                                                              .toString() ??
                                                          "";
                                                      mcqTestController
                                                          .fetchTestData(
                                                              /*endPoint: AppStrings.modelTestEndPoint*/);
                                                      //mcqTestController.timeSeconds.value=(controller.courseDetailsData[index].modelTest?.??15)*60;
                                                      Get.toNamed(
                                                          "/mcq_test_page");
                                                    },
                                                    gapBetween: AppDimensions
                                                        .sectionPaddingHor,
                                                    index: index,
                                                    resizeable: true,
                                                    isGradientColour: false,
                                                    bgColor: Colors.transparent,
                                                    titleTextColor: AppColors
                                                        .appHeaderTextColor,
                                                    titleFontWight:
                                                        FontWeight.normal,
                                                    title:
                                                        "Test : ${controller.courseDetailsData[index].modelTest?.name ?? ""}",
                                                    subTitleTextColor: AppColors
                                                        .appBodyTextColor,
                                                    subTitleSize: 14,
                                                    //subTitle:controller.courseDetailsData.value.data?.contents?[index].modelTest?.name??"",
                                                    image:
                                                        "assets/moc_icons/moc_icons_9.png",
                                                    //height: 40,
                                                  ),
                                                  if (controller
                                                          .courseDetailsData[
                                                              index]
                                                          .modelTestDisable ??
                                                      false)
                                                    Container(
                                                        color: Colors.black
                                                            .withOpacity(.5),
                                                        child: Icon(
                                                          Icons.lock,
                                                          color: Colors.white,
                                                          size: 36.sp,
                                                        ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: 50.sp,
                                              width: 50.sp,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/icons/award.png"),
                                                ),
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 4.h,
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    HeaderText(
                                                      text: "Day",
                                                      color: AppColors.appPrimaryColor,
                                                      size: 10,
                                                      fontWeight: FontWeight.normal,
                                                    ),

                                                    SizedBox(
                                                      height: 2.h,
                                                    ),

                                                    HeaderText(
                                                      text: "${index + 1}",
                                                      color: AppColors.appPrimaryColor,
                                                      size: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        if (controller.isLoadingMore.value)
                          const LoadingScreen()
                      ],
                    ),
            )),
    );
  }

  void loadMoreData() {
    if (controller.response.value.data?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        controller.loadMoreData();
      }
    }
  }
}
