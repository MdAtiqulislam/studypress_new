import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/current_affairs_controller.dart';
import '../../controllers/mcq_test_controller.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../../controllers/review_list_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class CurrentAffairsPage extends StatelessWidget {
  CurrentAffairsPage({super.key});

  final CurrentAffairsController controller =
      Get.put(CurrentAffairsController());

  final ReviewListController reviewListController =
      Get.put(ReviewListController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });
    return SafeArea(
      child: Obx(
        () => Scaffold(
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
                         // collapsedHeight: 60.h,
                          backgroundColor: Colors.white,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: HeaderText(
                              text: "Current Affairs",
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
                          expandedHeight: 200.h,
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: controller
                                  .formattedQuestions
                                  .length, (buildContext, index) {
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
                                                if (reviewListController
                                                    .myReviewList
                                                    .contains(
                                                        controller
                                                            .formattedQuestions[
                                                                index]
                                                            .id))
                                                  CircularButton(
                                                      offset: const Offset(0, 0),
                                                      //  bgColor: Color(0xEB4F34FF),
                                                      bgColor: Colors.red.shade50,
                                                      // shadowColor: Colors.white,
                                                      shadowOpacity: 1,
                                                      blurRadius: 20,
                                                      height: 40,
                                                      width: 40,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  5.0),
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
                                                              /* Positioned(
                                                              top: 5,
                                                              //bottom: 0,
                                                              right: 0,
                                                              child: Icon(Icons.check_circle_rounded,color: AppColors.appSuccessColor,size: 20,))*/
                                                            ],
                                                          )
                                                          /* Image.asset(
                                                        "assets/icons/bookmarked.png",
                                                        fit: BoxFit.fill,
                                                      ),*/
                                                          ),
                                                      callback: () {
                                                        if (!reviewListController
                                                            .isUpdating.value) {
                                                          reviewListController
                                                              .removeFromReviewList(
                                                                  qid: controller
                                                                      .formattedQuestions[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                        }
                                                      }),
                                                if (!reviewListController
                                                    .myReviewList
                                                    .contains(
                                                        controller
                                                            .formattedQuestions[
                                                                index]
                                                            .id))
                                                  CircularButton(
                                                      offset: const Offset(0, 0),
                                                      splashColor:
                                                          AppColors.appPrimaryColor,
                                                      bgColor: Colors.red.shade50,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      height: 40,
                                                      width: 40,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(
                                                                5.0),
                                                        child: Icon(
                                                          Icons.bookmark_add,
                                                          size: 30,
                                                          color: AppColors
                                                              .appPrimaryColor,
                                                        ) /*Image.asset(
                                                        "assets/icons/bookmark.png",
                                                        fit: BoxFit.fill,
                                                      )*/
                                                        ,
                                                      ),
                                                      callback: () {
                                                        if (!reviewListController
                                                            .isUpdating.value) {
                                                          reviewListController.addToReviewList(
                                                              qid: controller
                                                                  .formattedQuestions[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              chapterId:
                                                                  controller
                                                                          .formattedQuestions[
                                                                              index]
                                                                          .chapter ??
                                                                      "");
                                                        }
                                                      }),
                                                SizedBox(
                                                  width:
                                                      AppDimensions.widgetPaddingHor,
                                                )
                                              ],
                                            ),
                                            Align(
                                                alignment: Alignment.bottomRight,
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: AppDimensions.widgetPaddingHor),
                                                  child: BodyText(text: "Last Updated: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.formattedQuestions[index].updatedAt??DateTime(1999)))}",color: Colors.white,size: 10,),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),

                                    //TO DO

                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade50

                                          // border: Border.all(color: isClicked.value?color.value:Colors.transparent)
                                          ),
                                      child: Row(
                                        children: [
                                          if (controller
                                                  .formattedQuestions[index]
                                                  .correctAnswerIndex! >=
                                              0)
                                            Expanded(
                                              child: Html(
                                                data:
                                                    "Answer: ${controller.formattedQuestions[index].formattedOptions![controller.formattedQuestions[index].correctAnswerIndex!]}",
                                                /*     style: {
                                              "body": Style(
                                                color:
                                                    AppColors.appHeaderTextColor,
                                                fontSize: FontSize(16.sp),
                                              )
                                            },*/
                                              ),
                                            )
                                          else
                                            Expanded(
                                              child: Html(
                                                data:
                                                    "Answer: ${controller.formattedQuestions[index].formattedOptions!}",
                                                /*     style: {
                                              "body": Style(
                                                color:
                                                    AppColors.appHeaderTextColor,
                                                fontSize: FontSize(16.sp),
                                              )
                                            },*/
                                              ),
                                            ),
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: AppColors.appSuccessColor,
                                          ),
                                          SizedBox(
                                            width: AppDimensions.widgetPaddingHor,
                                          ),
                                        ],
                                      ),
                                    ),

                                    if ((controller
                                                .formattedQuestions[index]
                                                .hints ??
                                            "")
                                        .isNotEmpty)
                                      Container(
                                          color: Colors.red.shade50,
                                          child: Obx(
                                            () => Column(
                                              children: [
                                                Material(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
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
                                                    data:
                                                        controller
                                                            .formattedQuestions[
                                                                index]
                                                            .hints,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                  ],
                                ),
                              ),
                            );

                          }),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 60,),)
                      ],
                    ),


                    //bottom section
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 60.h,
                        width: Get.width,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppButton(
                                  offset: const Offset(0, 3),
                                  bgColor: AppColors.appWarningColor,
                                  splashColor: AppColors.appPrimaryColor,
                                  onTap: () {
                                    PractiseChapterController practiseChapterController =
                                    Get.put(PractiseChapterController());
                                    practiseChapterController.isPractise.value = true;
                                    practiseChapterController.isMistake.value = false;
                                    practiseChapterController.isReview.value = false;
                                    practiseChapterController.score.value = 0;
                                    practiseChapterController.wrongAns.value = 0;
                                    practiseChapterController.correctAns.value = 0;
                                    practiseChapterController.myAnswers.length = 0;
                                    practiseChapterController.endPoint.value=AppStrings.currentAffairsEndPoint;
                                    practiseChapterController.quizType.value="chapterQuiz";
                                    practiseChapterController.chapterId.value="315";
                                    practiseChapterController.fetchCurrentAffairsQuestion();
                                     Get.toNamed("/practise_page", arguments: [
                                 315,
                                "Current Affairs"
                          ]);
                                  },
                                  child: HeaderText(
                                    text: "Start Practice",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppButton(
                                  offset: const Offset(0, 3),
                                  splashColor: AppColors.appPrimaryColor,
                                  bgColor: AppColors.appSecondaryColor,
                                  onTap: () {
                                    MCQTestController mcqTestController =
                                    Get.put(MCQTestController());
                                    // mcqTestController.chapterId.value=id;
                                    mcqTestController.isLoading.value = true;
                                    mcqTestController.formattedQuestions.value=[];
                                    mcqTestController.questions.value=[];
                                    mcqTestController.currentAnswerIndex.value=-1;
                                    mcqTestController.currentQuestionIndex.value=0;
                                    mcqTestController.endPoint.value= AppStrings.currentAffairsMCQTestEndPoint;
                                    mcqTestController.quizType.value="chapterQuiz";
                                     mcqTestController.chapterId.value="315";
                                    mcqTestController.fetchQuizData();
                                    Get.toNamed("/mcq_test_page");
                                  },
                                  child: HeaderText(
                                    text: "Start Quiz",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),




                    if (reviewListController.isUpdating.value ||
                        controller.isLoadingMore.value)
                     const LoadingScreen()
                  ],
                ),
        ),
      ),
    );
  }

  void loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!controller.isLoadingMore.value &&
          (controller.response.value.data?.currentPage ?? 0) <
              (controller.response.value.data?.lastPage ?? 0)) {
        controller.loadMoreData();
      }
    }
  }
}
