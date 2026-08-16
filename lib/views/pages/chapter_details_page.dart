import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/header_text.dart';
import '../../controllers/chapter_details_controller.dart';
import '../../controllers/mcq_test_controller.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class ChapterDetailsPage extends StatelessWidget {
  var id = Get.arguments[0];
  var categoryId = Get.arguments[1];

  ChapterDetailsPage({super.key});
  final ChapterDetailsController chapterDetailsController =
      Get.put(ChapterDetailsController());


  @override
  Widget build(BuildContext context) {
    chapterDetailsController.fetchDetailsData(id: id);
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        bottomNavigationBar: Row(
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
                    practiseChapterController.endPoint.value=AppStrings.getPractiseChapterEndPoint;
                    practiseChapterController.quizType.value="chapterQuiz";
                    practiseChapterController.chapterId.value=id;
                    practiseChapterController.fetchDataWithChapterId(categoryId: categoryId);
                    Get.toNamed("/practise_page", arguments: [
                      id,
                      chapterDetailsController
                              .response.value.subjectItem?.name ??
                          ""
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
                    mcqTestController.chapterId.value=id;
                    mcqTestController.isLoading.value = true;
                    mcqTestController.formattedQuestions.value=[];
                    mcqTestController.questions.value=[];
                    mcqTestController.currentAnswerIndex.value=-1;
                    mcqTestController.currentQuestionIndex.value=0;
                    mcqTestController.endPoint.value= AppStrings.quizTestEndPoint;
                    mcqTestController.quizType.value="chapterQuiz";
                    mcqTestController.chapterId.value=id;
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
        body: Obx(
          () => chapterDetailsController.isLoading.value
              ? const Center(
                  child: LoadingScreen(),
                )
              : CustomScrollView(
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
                          text: chapterDetailsController
                                  .response.value.subjectItem?.name ??
                              "",
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
                    if ((chapterDetailsController
                                .response.value.dataItem?.hotTips ??
                            "")
                        .isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: Get.width,
                                  color: AppColors.appPrimaryColor,
                                  child: Center(
                                    child: HeaderText(
                                      text: "Hot Tips",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Html(
                                    data: chapterDetailsController
                                            .response.value.dataItem?.hotTips ??
                                        "")
                              ],
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Html(
                            data: chapterDetailsController
                                    .response.value.dataItem?.details ??
                                ""),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
