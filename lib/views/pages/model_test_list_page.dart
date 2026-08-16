import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_test_controller.dart';
import '../../controllers/test_controller.dart';
import '../../utilities/show_snack_bar.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class ModelTestListPage extends StatelessWidget {
  ModelTestListPage({super.key});

  //var endPoint=Get.arguments[0];   //enrollment id
  final String title = Get.arguments[0]; //enrollment category name
  final String testType = Get.arguments[1]; //model test or live test
  //  var index=Get.arguments[3];

  final TestController controller = Get.put(TestController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // testController.getModelTestListData(endPoint: endPoint);
    _scrollController.addListener(() {
      // print("Content Height: ${_globalKey.currentContext?.size?.height}");
      loadMoreData();
    });
    return SafeArea(
      child: Obx(() => controller.isLoading.value
          ? const Scaffold(
              body: LoadingScreen(),
            )
          : Scaffold(
        drawer: MyDrawer(),
              body: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
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
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: HeaderText(
                            text: "$testType: $title ",
                            maxLine: 2,
                          ),
                          background: const SliverAppBarBackground(),
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
                       // collapsedHeight: 30.sp,
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount:
                                  (controller.modelTestList.length) + 1,
                              (buildContext, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.leftPadding),
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: AppDimensions.contentPaddingHor),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero)),
                            //color: Colors.green,
                            child: index == 0
                                ? Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: [
                                       if(true) BasicGridItem(
                                          titleTextColor:
                                              AppColors.appHeaderTextColor,
                                          //sGradientColour: false,
                                          borderRadius: 5.r,
                                          bgColor: Colors.white,
                                          index: index,
                                          resizeable: true,
                                          subTitleSize: 12.sp,
                                          title: "$testType List",
                                          gapBetween: 30.w,
                                          subTitle:
                                              "Total Tests: ${controller.modelTestList.length}",
                                          image:
                                              "assets/moc_icons/moc_icons_${index % 10}.png",
                                        ),
                                      ],
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {

                                      if(!(controller.modelTestList
                                          [index - 1].isPaid ==
                                          1 &&
                                          controller.modelTestList
                                              [index - 1].memberPaid ==
                                              0)
                                      ){
                                        MCQTestController mcqTestController =
                                        Get.put(MCQTestController());
                                        mcqTestController.endPoint.value=AppStrings.modelTestEndPoint;
                                        mcqTestController.testId.value =
                                            controller
                                                .modelTestList[index - 1].id
                                                .toString();
                                        mcqTestController.quizType.value =
                                        "modelTest";
                                        mcqTestController
                                            .formattedQuestions.value = [];
                                        mcqTestController.questions.value = [];
                                        mcqTestController
                                            .currentAnswerIndex.value = -1;
                                        mcqTestController
                                            .currentQuestionIndex.value = 0;
                                        mcqTestController.timeSeconds.value =
                                            (controller.modelTestList
                                                [index - 1].time ??
                                                15) *
                                                60;
                                        mcqTestController.fetchTestData(
                                          /*endPoint: AppStrings.modelTestEndPoint,*/);
                                        Get.toNamed("/mcq_test_page");

                                      }
                                      else{
                                        CustomSnackBar(
                                          duration: 10,
                                          isWarning: true,
                                          msg: "To avail this service please upgrade your package.",
                                          showButton: true,
                                          buttonText: "UPGRADE",
                                          onTab: (){
                                            Get.back();
                                            Get.toNamed(
                                                "/my_subscriptions_page");
                                          }
                                        ).showSnackBar();
                                      }
                                    },
                                    child: Container(
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: .5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AppDimensions
                                                    .widgetPaddingHor,
                                                vertical: AppDimensions
                                                    .widgetPaddingVer),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                HeaderText(
                                                  text: controller
                                                          .modelTestList
                                                          [index - 1]
                                                          .name ??
                                                      "",
                                                  color: AppColors
                                                      .appHeaderTextColor,
                                                  maxLine: 10,
                                                  align: TextAlign.start,
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  height: AppDimensions
                                                      .contentPaddingVer,
                                                ),
                                                BodyText(
                                                    text:
                                                        "Total Questions: ${controller.modelTestList[index - 1].totalQues ?? 0}"),
                                                BodyText(
                                                    text:
                                                        "Time: ${controller.modelTestList[index - 1].time ?? 0} minutes"),
                                              ],
                                            ),
                                          ),
                                           if (controller
                                                      .modelTestList
                                                      [index - 1]
                                                      .isPaid ==
                                                  1 &&
                                              controller
                                                      .modelTestList
                                                      [index - 1]
                                                      .memberPaid ==
                                                  0)
                                            Positioned(
                                              right: 10.w,
                                              bottom: 10.h,
                                              child: AppButton(
                                                  offset: const Offset(0, 0),
                                                  borderRadius: 5,
                                                  bgColor:
                                                      AppColors.appPrimaryColor,
                                                  child: HeaderText(
                                                    text: "Upgrade",
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  onTap: () {
                                                    Get.toNamed(
                                                        "/my_subscriptions_page");
                                                  }),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      })),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: AppDimensions.sectionPaddingVer,
                        ),
                      )
                    ],
                  ),
                  if (controller.isLoadingMore.value) const LoadingScreen(),
                ],
              ),
            )),
    );
  }

  void loadMoreData() {
    if (controller.modelTestListData.value.data?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        controller.loadMoreModelTestData();
      }
    }
  }
}
