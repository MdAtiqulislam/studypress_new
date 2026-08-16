import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import '../widgets/sliver_app_bar_background.dart';

class PractiseChapterPage extends StatefulWidget {
  const PractiseChapterPage({super.key});

  @override
  State<PractiseChapterPage> createState() => _PractiseChapterPageState();
}

class _PractiseChapterPageState extends State<PractiseChapterPage> {
  var id = Get.arguments[0];
  var title = Get.arguments[1];

  final PractiseChapterController controller =
      Get.put(PractiseChapterController());

  //var expandId = (-1).obs;
  //var isExpanded = false.obs;
  final ScrollController _scrollController = ScrollController();

  var color = Colors.white.obs;
  var isCorrect = false.obs;
  var isClicked = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.getReviewList();
    _scrollController.addListener(() {
      // print("Content Height: ${_globalKey.currentContext?.size?.height}");
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Obx(
          () => Visibility(
            visible: controller.isPractise.value,
            child: AppButton(
              bgColor: Colors.green.shade100,
              offset: const Offset(0, 5),
              onTap: () {
                goToTop();
              },
              child: HeaderText(
                text: "${controller.correctAns}/${controller.wrongAns}",
              ),
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingScreen()
              : Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        //appbar section
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
                              text: "Practice: $title",
                              maxLine: 2,
                            ),
                            background: Stack(
                              children: [
                                const SliverAppBarBackground(),
                                Positioned(
                                  top: 30.h,
                                  right: 30.w,
                                  child: CircularPercentIndicator(
                                    radius: 60.r,
                                    lineWidth: 10.r,
                                    progressColor: AppColors.appSuccessColor,
                                    backgroundColor:
                                        AppColors.appSecondaryColor,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    percent: (controller.formattedQuestions.isNotEmpty &&
                                  controller.myAnswers.isNotEmpty)
                                      ? ((1.0 / controller.formattedQuestions.length) *
                                      controller.myAnswers.length)
                                      .clamp(0.0, 1.0)
                                      : 0,
                                    center: Container(
                                      width: 200,
                                      clipBehavior: Clip.none,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BodyText(
                                            text: "Score",
                                            size: 14,
                                            resizeable: false,
                                          ),
                                          HeaderText(
                                              text:
                                                  "${controller.score.value}/${controller.response.value.data?.total ?? 0}",resizeable: false,),
                                          BodyText(
                                            text: "Correct/Wrong",
                                            size: 14,
                                            resizeable: false,
                                          ),
                                          HeaderText(
                                            text:
                                                "${controller.correctAns}/${controller.wrongAns}",
                                            resizeable: false,
                                          ),
                                        ],
                                      ),
                                    ),
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
                          expandedHeight: 220.h,
                        ),
                        //info section
                        SliverToBoxAdapter(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.leftPadding,
                                  vertical: AppDimensions.topPadding),
                              child: BodyText(
                                text: "These questions are generated based on"
                                    " your performance. Please practise more to "
                                    "unlock next level questions.",
                                size: 14,
                                align: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),

                        //Questions section
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: controller.formattedQuestions.length,
                              (buildContext, index) {
                            return Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 10.h),
                                      color: AppColors.appPrimaryColor,
                                      child: Obx(
                                        () => Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Html(
                                                    data:
                                                        "${index + 1}. ${controller.formattedQuestions[index].question}",
                                                    style: {
                                                      "body": Style(
                                                          color: Colors.white),
                                                    },
                                                  ),
                                                ),
                                                if (controller.myReviewList
                                                        .contains(controller
                                                            .formattedQuestions[
                                                                index]
                                                            .id) &&
                                                    controller.isPractise.value)
                                                  CircularButton(
                                                      offset:
                                                          const Offset(0, 0),
                                                      //  bgColor: Color(0xEB4F34FF),
                                                      bgColor:
                                                          Colors.red.shade50,
                                                      // shadowColor: Colors.white,
                                                      shadowOpacity: 1,
                                                      blurRadius: 20,
                                                      height: 40,
                                                      width: 40,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Stack(
                                                            children: const [
                                                              /* Image.asset(
                                                              "assets/icons/bookmark.png",
                                                              fit: BoxFit.fill,
                                                            ),*/
                                                              Icon(
                                                                Icons
                                                                    .bookmark_added,
                                                                color: AppColors
                                                                    .appSuccessColor,
                                                                size: 30,
                                                              ),
                                                            ],
                                                          )
                                                          ),
                                                      callback: () {
                                                        if (!controller
                                                            .isUpdating.value) {
                                                          controller.removeFromReviewList(
                                                              qid: controller
                                                                  .formattedQuestions[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                        }
                                                      }),
                                                if (!controller.myReviewList
                                                        .contains(controller
                                                            .formattedQuestions[
                                                                index]
                                                            .id) &&
                                                    controller.isPractise.value)
                                                  CircularButton(
                                                      offset:
                                                          const Offset(0, 0),
                                                      splashColor: AppColors
                                                          .appPrimaryColor,
                                                      bgColor:
                                                          Colors.red.shade50,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      height: 40,
                                                      width: 40,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Icon(
                                                          Icons.bookmark_add,
                                                          size: 30,
                                                          color: AppColors
                                                              .appPrimaryColor,
                                                        )
                                                        ,
                                                      ),
                                                      callback: () {
                                                        if (!controller
                                                            .isUpdating.value) {
                                                          controller.addToReviewList(
                                                              qid: controller
                                                                  .formattedQuestions[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              chapterId: controller
                                                                      .formattedQuestions[
                                                                          index]
                                                                      .chapter ??
                                                                  "");
                                                        }
                                                      }),
                                                if (controller
                                                        .isMistake.value ||
                                                    controller.isReview.value)
                                                  CircularButton(
                                                      offset:
                                                          const Offset(0, 0),
                                                      splashColor: AppColors
                                                          .appPrimaryColor,
                                                      bgColor:
                                                          Colors.red.shade50,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      height: 40,
                                                      width: 40,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 30,
                                                          color: AppColors
                                                              .appErrorColor,
                                                        ),
                                                      ),
                                                      callback: () {
                                                        if (controller
                                                            .isMistake.value) {
                                                          controller.removeFromMistakeListByQid(
                                                              qId: controller
                                                                      .formattedQuestions[
                                                                          index]
                                                                      .id ??
                                                                  -1);
                                                        }

                                                        if (controller
                                                            .isReview.value) {
                                                          controller.removeFromPracticeReviewListByQid(
                                                              qId: controller
                                                                      .formattedQuestions[
                                                                          index]
                                                                      .id ??
                                                                  -1);
                                                        }
                                                      }),
                                                SizedBox(
                                                  width: AppDimensions
                                                      .widgetPaddingHor,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.contentPaddingVer,
                                            ),
                                            if ((controller
                                                        .formattedQuestions[
                                                            index]
                                                        .previousExams ??
                                                    [])
                                                .isNotEmpty)

                                              //previous questions section
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: AppDimensions
                                                          .widgetPaddingHor),
                                                  child: BodyText(
                                                    text:
                                                        "${controller.formattedQuestions[index].previousExams}",
                                                    color: Colors.white,
                                                    size: 10,
                                                    maxLine: 5,
                                                    align: TextAlign.end,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                              .formattedQuestions[index]
                                              .formattedOptions
                                              ?.length ??
                                          0,
                                      shrinkWrap: true,
                                      itemBuilder: (buildContext, index_2) {
                                        return InkWell(
                                          onTap: () {
                                            controller.optionClicked(
                                                questionIndex: index,
                                                optionIndex: index_2);
                                          },
                                          child: singleOption(
                                              quesIndex: index, index: index_2),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: .5,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),


                                    if ((controller.formattedQuestions[index]
                                                    .hints ??
                                                "")
                                            .isNotEmpty &&
                                        controller.myAnswers.contains(index))
                                      Container(
                                        color: Colors.red.shade50,
                                        child: Obx(
                                          () => Column(
                                            children: [
                                              Material(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      HeaderText(
                                                        text: "Explanation",
                                                        color: AppColors
                                                            .appSecondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.red.shade50,
                                                child: Html(
                                                  data: controller
                                                      .formattedQuestions[index]
                                                      .hints,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),


                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: AppDimensions.sectionPaddingVer * 2,
                          ),
                        )
                      ],
                    ),
                    if (!controller.isPractise.value)
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: Get.width,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.leftPadding,
                                  vertical: AppDimensions.contentPaddingVer),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      offset: const Offset(0, 2),
                                      shadowColor: AppColors.appErrorColor,
                                      bgColor: AppColors.appErrorColor,
                                      onTap: () {
                                        if (controller.isMistake.value) {
                                          if (controller.isCurrentWorld.value) {
                                            controller
                                                .clearCurrentAffairsMistakeList();
                                          } else {
                                            controller.clearMistakeList();
                                          }
                                        }
                                        if (controller.isReview.value) {
                                          if (controller.isCurrentWorld.value) {
                                            controller
                                                .clearCurrentWorldReviewList();
                                          } else {
                                            controller.clearReviewList();
                                          }
                                        }
                                      },
                                      child: HeaderText(
                                        text: "Clear All",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.widgetPaddingHor,
                                  ),
                                  Obx(
                                    () => AppButton(
                                      bgColor: Colors.green.shade100,
                                      offset: const Offset(0, 5),
                                      onTap: () {
                                        goToTop();
                                      },
                                      child: HeaderText(
                                        text:
                                            "${controller.correctAns}/${controller.wrongAns}",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),),
                    if (controller.isUpdating.value) const LoadingScreen(),
                    if (controller.isLoadingMore.value) const LoadingScreen()
                  ],
                ),
        ),
      ),
    );
  }

  Widget singleOption({required quesIndex, required int index}) {
    if (controller.formattedQuestions[quesIndex].myOptions!.contains(index)) {
      if (index ==
          controller.formattedQuestions[quesIndex].correctAnswerIndex) {
        color.value = AppColors.appSuccessColor;
        isCorrect.value = true;
        isClicked.value = true;
      } else {
        color.value = AppColors.appErrorColor;

        isCorrect.value = false;
        isClicked.value = true;
      }
    } else {
      color.value = AppColors.appHeaderTextColor;
      isClicked.value = false;
    }
    return InkWell(
      onTap: () {
        controller.optionClicked(questionIndex: quesIndex, optionIndex: index);
      },
      child: AnimatedContainer(
        padding: isClicked.value
            ? const EdgeInsets.symmetric(vertical: 10)
            : const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: isClicked.value && isCorrect.value
                ? Colors.green.shade50
                : isClicked.value && !isCorrect.value
                    ? Colors.red.shade50
                    : Colors.white
            // border: Border.all(color: isClicked.value?color.value:Colors.transparent)
            ),
        duration: const Duration(milliseconds: 500),
        child: Row(
          children: [
            SizedBox(
              width: AppDimensions.widgetPaddingHor,
            ),
            CircularButton(
              //bgColor: ,
              width: 30,
              height: 30,
              offset: const Offset(0, 0),
              shadowOpacity: isClicked.value ? 1 : .2,
              shadowColor: color.value,
              callback: null,
              child: Center(
                child: HeaderText(
                  text: controller.optionsIndex[index],
                  color: color.value,
                  resizeable: false,
                ),
              ),
            ),
            SizedBox(
              width: AppDimensions.leftPadding,
            ),
            Expanded(
              child: Html(
                data:
                    "${controller.formattedQuestions[quesIndex].formattedOptions?[index]}",
                style: {
                  "body": Style(
                      color: color.value,
                      fontSize:
                          isClicked.value ? FontSize(16.sp) : FontSize(14.sp),
                      fontWeight:
                          isClicked.value ? FontWeight.bold : FontWeight.normal)
                },
              ),
            ),
            if (isClicked.value && isCorrect.value)
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.appSuccessColor,
              ),
            if (isClicked.value && !isCorrect.value)
              const Icon(
                Icons.cancel_outlined,
                color: AppColors.appErrorColor,
              ),
            if (!isClicked.value)
              Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade400,
              ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
      ),
    );
  }

  void goToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  void loadMoreData() {
    if (controller.response.value.data?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        if (controller.isMistake.value) {
          controller.loadMoreMistakeData();
        } else if (controller.isReview.value) {
          controller.loadMoreReviewData();
        } else {
          controller.loadMoreData();
        }
      }
    }
  }
}
