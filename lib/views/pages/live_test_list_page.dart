import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_test_controller.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../../controllers/test_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/empty_card.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class LiveTestListPage extends StatelessWidget {
  LiveTestListPage({Key? key}) : super(key: key);

  final TestController controller = Get.put(TestController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      // print("Content Height: ${_globalKey.currentContext?.size?.height}");
      loadMoreData();
    });
    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const Scaffold(body: LoadingScreen())
            : Stack(
                children: [
                  Scaffold(
                    drawer: MyDrawer(),
                    body: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          toolbarHeight: 40.sp,
                          collapsedHeight: 40.sp,
                          iconTheme: const IconThemeData(
                            color: AppColors.appHeaderTextColor,
                          ),
                          // automaticallyImplyLeading: false,
                          pinned: true,
                          centerTitle: true,
                          floating: false,
                          snap: false,
                          backgroundColor: Colors.white,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: HeaderText(
                              text: "Live Test",
                              color: AppColors.appHeaderTextColor,
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
                          //collapsedHeight: 30.sp,
                        ),
                        if (controller.liveTestsList.isEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.leftPadding,
                              ),
                              child: Card(
                                color: Colors.red.shade50,
                                child: EmptyCard(
                                  title: 'There are no live Test running now.',
                                ),
                              ),
                            ),
                          ),

                        //Live test list
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: controller.liveTestsList.length,
                            (context, index) => liveTestCard(index: index),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: AppDimensions.sectionPaddingVer,
                          ),
                        ),

                        //Archive List
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: (controller.archiveDataList.length) + 1,
                            (buildContext, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.leftPadding,
                                ),
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.contentPaddingHor,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  //color: Colors.green,
                                  child: index == 0
                                      ? Card(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 0,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.r),
                                            ),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Column(
                                            children: [
                                              BasicGridItem(
                                                titleTextColor: AppColors
                                                    .appHeaderTextColor,
                                                //sGradientColour: false,
                                                borderRadius: 5.r,
                                                bgColor: Colors.white,
                                                index: index,
                                                title: "Archive List",
                                                gapBetween: 30.w,
                                                resizeable: true,
                                                subTitleSize: 12.sp,
                                                subTitle:
                                                    "Total Tests: ${controller.liveResponseData.value.archiveList?.total ?? 0}",
                                                image:
                                                    "assets/moc_icons/moc_icons_${index % 10}.png",
                                              ),
                                            ],
                                          ),
                                        )
                                      : Visibility(
                                          visible: true,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: .5,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                PractiseChapterController
                                                practiseChapterController =
                                                    Get.put(
                                                      PractiseChapterController(),
                                                    );
                                                practiseChapterController
                                                        .isPractise
                                                        .value =
                                                    true;
                                                practiseChapterController
                                                        .isMistake
                                                        .value =
                                                    false;
                                                practiseChapterController
                                                        .isReview
                                                        .value =
                                                    false;
                                                practiseChapterController
                                                        .score
                                                        .value =
                                                    0;
                                                practiseChapterController
                                                        .wrongAns
                                                        .value =
                                                    0;
                                                practiseChapterController
                                                        .correctAns
                                                        .value =
                                                    0;
                                                practiseChapterController
                                                        .myAnswers
                                                        .length =
                                                    0;
                                                practiseChapterController
                                                    .endPoint
                                                    .value = AppStrings
                                                    .modelTestEndPoint;
                                                practiseChapterController
                                                        .quizType
                                                        .value =
                                                    "modelTest";
                                                practiseChapterController
                                                    .testId
                                                    .value = controller
                                                    .archiveDataList[index - 1]
                                                    .id
                                                    .toString();
                                                practiseChapterController
                                                    .fetchDataWithChapterId();
                                                Get.toNamed(
                                                  "/practise_page",
                                                  arguments: [
                                                    controller
                                                        .archiveDataList[index -
                                                            1]
                                                        .id
                                                        .toString(),
                                                    controller
                                                        .archiveDataList[index -
                                                            1]
                                                        .name
                                                        .toString(),
                                                  ],
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: AppDimensions
                                                      .widgetPaddingHor,
                                                  vertical: AppDimensions
                                                      .widgetPaddingVer,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    HeaderText(
                                                      text:
                                                          controller
                                                              .archiveDataList[index -
                                                                  1]
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
                                                          "Total Questions: ${controller.archiveDataList[index - 1].totalQues ?? 0}",
                                                    ),
                                                    BodyText(
                                                      text:
                                                          "Time: ${controller.archiveDataList[index - 1].time ?? 0} minutes",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: AppDimensions.sectionPaddingVer,
                          ),
                        ),
                        if (controller.isLoadingMore.value)
                          const SliverToBoxAdapter(child: LoadingScreen()),
                      ],
                    ),
                  ),
                  if (controller.isUpdating.value) const LoadingScreen(),
                ],
              ),
      ),
    );
  }

  Widget liveTestCard({required int index}) {
    final liveTest = controller.liveTestsList[index];
    final examTime = DateTime.parse(
      liveTest.examTime ?? DateTime.now().toString(),
    );
    final remaining = examTime.difference(DateTime.now());
    final isStarted = remaining.inSeconds <= 0;

    // যদি time > 24 ঘন্টা হয় তাহলে day সহ দেখাবে
    final timerFormat = remaining.inHours >= 24
        ? CountDownTimerFormat.daysHoursMinutesSeconds
        : CountDownTimerFormat.hoursMinutesSeconds;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.leftPadding,
        vertical: AppDimensions.contentPaddingVer,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            // Header Section
            Container(
              width: Get.width,
              color: AppColors.appPrimaryColor,
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.widgetPaddingVer,
                horizontal: AppDimensions.contentPaddingHor,
              ),
              child: Center(
                child: HeaderText(
                  text: liveTest.name ?? "",
                  color: Colors.white,
                ),
              ),
            ),

            // Start Time Info
            BasicGridItem(
              index: index,
              borderRadius: 0,
              title: "START TIME:",
              subTitle: DateFormat('MM/dd/yyyy hh:mm a').format(examTime),
              subTitleSize: 18,
              image: "assets/icons/stopwatch.png",
            ),

            // Description
            BodyText(text: liveTest.details ?? ""),

            // Timer Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  isStarted
                      ? "assets/icons/running.png"
                      : "assets/icons/wait.png",
                  height: 50,
                ),
                SizedBox(width: AppDimensions.widgetPaddingHor),
                TimerCountdown(
                  colonsTextStyle: TextStyle(
                    color: isStarted
                        ? AppColors.appErrorColor
                        : AppColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                  timeTextStyle: TextStyle(
                    color: isStarted
                        ? AppColors.appErrorColor
                        : AppColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                  enableDescriptions: false,
                  format: timerFormat,
                  endTime: isStarted
                      ? examTime.add(Duration(minutes: liveTest.time ?? 0))
                      : examTime,
                  onEnd: () {
                    controller.isUpdating.value = true;
                    controller.getLiveTestListData();
                  },
                ),
              ],
            ),

            SizedBox(height: AppDimensions.widgetPaddingVer),

            // Test Info
            BodyText(text: "Total Questions: ${liveTest.totalQues ?? 0}"),
            BodyText(text: "Time: ${liveTest.time ?? 0} minutes"),

            SizedBox(height: AppDimensions.widgetPaddingVer),

            // Action Button
            if (isStarted)
              (liveTest.isPaid == 1 && liveTest.memberPaid == 0)
                  ? AppButton(
                      offset: const Offset(0, 0),
                      bgColor: AppColors.appPrimaryColor,
                      child: HeaderText(
                        text: "Upgrade to Start",
                        color: Colors.white,
                      ),
                      onTap: () => Get.toNamed("/my_subscriptions_page"),
                    )
                  : AppButton(
                      bgColor: AppColors.appPrimaryColor,
                      offset: const Offset(0, 3),
                      child: HeaderText(text: "START NOW", color: Colors.white),
                      onTap: () {
                        final mcqTestController = Get.put(MCQTestController());
                        mcqTestController.testId.value = liveTest.id.toString();
                        mcqTestController.formattedQuestions.value = [];
                        mcqTestController.questions.value = [];
                        mcqTestController.currentAnswerIndex.value = -1;
                        mcqTestController.currentQuestionIndex.value = 0;
                        mcqTestController.quizType.value = "modelTest";
                        mcqTestController.timeSeconds.value =
                            (liveTest.time ?? 0);
                        mcqTestController.fetchTestData();
                        Get.toNamed("/mcq_test_page");
                      },
                    ),

            SizedBox(height: AppDimensions.widgetPaddingVer),
          ],
        ),
      ),
    );
  }

  void loadMoreData() {
    if (controller.liveResponseData.value.archiveList?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        controller.loadMoreArchiveData();

        /*if (searchCategoryProductController
            .searchCategoryProductsModel.value.currentPage !=
            searchCategoryProductController
                .searchCategoryProductsModel.value.lastPage && !searchCategoryProductController.isLoadingMore.value) {
          searchCategoryProductController.loadMoreData(
              searchCategoryProductController
                  .searchCategoryProductsModel.value.nextPageUrl
                  .toString());
        }*/
      }
    }
  }
}
