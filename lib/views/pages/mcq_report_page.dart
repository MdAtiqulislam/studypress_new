import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_report_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import '../widgets/my_drawer.dart';

class MCQReportPage extends StatelessWidget {
  MCQReportPage({super.key});

  MCQReportController controller = Get.put(MCQReportController());
  var color = Colors.white.obs;
  var isCorrect = false.obs;
  var isClicked = false.obs;
  final ScrollController _scrollController = ScrollController();

  //var wrongAnswer=mcqReportController.getWrongAnswer().obs;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      // print("Content Height: ${_globalKey.currentContext?.size?.height}");
      loadMoreData();
    });

   // controller.calculation();
    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const LoadingScreen()
            : Stack(
                children: [
                  Scaffold(
                    drawer: MyDrawer(),
                    appBar: AppBar(
                      toolbarHeight: 40.sp,
                      //collapsedHeight: 40.sp,
                      backgroundColor: Colors.white,
                      title: HeaderText(
                        text: "Test Report - ${controller.title.value}",
                        color: AppColors.appHeaderTextColor,
                        maxLine: 2,
                      ),
                      centerTitle: true,
                      iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
                    ),
                    body: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.leftPadding),
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.widgetPaddingVer,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HeaderText(text: "Score"),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.contentPaddingVer,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 200.sp,
                              child: CircularButton(
                                  // shape: BoxShape.rectangle,
                                  shadowColor: AppColors.appPrimaryColor,
                                  bgColor: Colors.purple.shade50,
                                  offset: const Offset(0, 5),
                                  blurRadius: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      HeaderText(
                                        text:
                                            "${controller.correctAnswer.value-(controller.wrongAnswer.value*.25)}/ ${controller.testData.value.modelQuesiton?.total??0}",
                                        color: AppColors.appErrorColor,
                                        align: TextAlign.center,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        height: AppDimensions.contentPaddingVer,
                                      ),
                                      BodyText(
                                          text:
                                              "Right Answer:${controller.correctAnswer.value}"),
                                      BodyText(
                                          text:
                                              "Wrong Answer:${controller.wrongAnswer.value}"),
                                      BodyText(
                                          text:
                                              "No Answer:${controller.noAnswer.value}"),
                                      SizedBox(
                                        height: AppDimensions.contentPaddingVer,
                                      ),
                                      HeaderText(text: "Time Taken"),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            color: AppColors.appPrimaryColor,
                                            //color: Colors.green.shade100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: HeaderText(
                                                text: "${(controller.testData.value.quizSummery?.timeTaken??0)~/3600}",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          HeaderText(text: ":"),
                                          Card(
                                            color: AppColors.appPrimaryColor,
                                            //color: Colors.green.shade100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: HeaderText(
                                                text: "${((controller.testData.value.quizSummery?.timeTaken??0)%3600)~/60}",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          HeaderText(text: ":"),
                                          Card(
                                            color: AppColors.appPrimaryColor,
                                            //color: Colors.green.shade100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: HeaderText(
                                                text: "${(((controller.testData.value.quizSummery?.timeTaken??0)%3600)%60)}",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  callback: () {}),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.widgetPaddingVer,
                            ),
                          ),
                          if (controller.isModelTest.value)
                            SliverToBoxAdapter(
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 200.w,
                                  height: 40.h,
                                  child: AppButton(

                                    bgColor: AppColors.appPrimaryColor,
                                    onTap: () {
                                      Get.toNamed("/merit_list_page",
                                          arguments: [
                                            controller.title.value,
                                            controller.testData.value
                                                    .quizSummery?.quizId ??
                                                ""
                                          ]);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/medal.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        HeaderText(
                                          text: "View Merit List",
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 200.h,
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                      radius: 50.r,
                                      center: HeaderText(
                                        text:
                                            "${controller.correctAnswerPercentage.toStringAsFixed(2)}%",
                                        resizeable: false,
                                      ),
                                      lineWidth: 20,
                                      percent:
                                          (controller.correctAnswerPercentage /
                                              100),
                                      progressColor: AppColors.appSuccessColor,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      header: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                AppDimensions.widgetPaddingVer),
                                        child: BodyText(
                                          text: "Right Answer",
                                        ),
                                      ),
                                      footer: Column(
                                        children: [
                                          BodyText(
                                            text:
                                                "${controller.correctAnswer.value}/${controller.testData.value.modelQuesiton?.total??0}",
                                          ),
                                          BodyText(
                                            text:
                                                "Score: ${controller.correctAnswer.value} X 1 = ${controller.correctAnswer.value}",
                                            size: 10,
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    width: AppDimensions.widgetPaddingHor,
                                  ),

                                  CircularPercentIndicator(
                                      radius: 50.r,
                                      center: HeaderText(
                                        text:
                                            "${(controller.wrongAnswerPercentage.value).toStringAsFixed(2)}%",
                                        resizeable: false,
                                      ),
                                      lineWidth: 20,
                                      percent: (controller
                                              .wrongAnswerPercentage.value /
                                          100),
                                      progressColor: AppColors.appErrorColor,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      header: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                AppDimensions.widgetPaddingVer),
                                        child: BodyText(
                                          text: "Wrong Answer",
                                        ),
                                      ),
                                      footer: Column(
                                        children: [
                                          BodyText(
                                            text:
                                                "${controller.wrongAnswer.value}/${controller.testData.value.modelQuesiton?.total??0}",
                                          ),
                                          BodyText(
                                            text:
                                                "Score: ${controller.wrongAnswer.value} X (-.25) = ${controller.wrongAnswer.value * (-.25)}",
                                            size: 10,
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    width: AppDimensions.widgetPaddingHor,
                                  ),

                                  CircularPercentIndicator(
                                      radius: 50.r,
                                      center: HeaderText(
                                        text:
                                            "${controller.noAnswerPercentage.value.toStringAsFixed(2)}%",
                                        resizeable: false,
                                      ),
                                      lineWidth: 20,
                                      percent:
                                          controller.noAnswerPercentage / 100,
                                      progressColor: AppColors.appWarningColor,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      header: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                AppDimensions.widgetPaddingVer),
                                        child: BodyText(
                                          text: "No Answer",
                                        ),
                                      ),
                                      footer: Column(
                                        children: [
                                          BodyText(
                                            text:
                                                "${controller.noAnswer.value}/${controller.testData.value.modelQuesiton?.total??0}",
                                          ),
                                          BodyText(
                                            text:
                                                "Score: ${controller.noAnswer} X 0 = 0",
                                            size: 10,
                                          )
                                        ],
                                      )),
                                  //SizedBox(width: Dimensions.widgetPaddingHor,),
                                ],
                              ),
                            ),
                          ),


                          //Chart Section


                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.sectionPaddingVer,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HeaderText(
                              text: "  Your Answers:",
                              align: TextAlign.start,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.sectionPaddingVer,
                            ),
                          ),
                          answersSection(),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isLoadingMore.value) const LoadingScreen()
                ],
              ),
      ),
    );
  }

  Widget singleOption({required quesIndex, required int index}) {
    var selectedOptionIndex = controller.optionsIndex.indexWhere(
        (element) => element == controller.formattedQuestions[quesIndex].ans);
    isClicked.value = true;
    //noAnswer.value=false;
    if (controller.formattedQuestions[quesIndex].correctAnswerIndex ==
        index) {
      isCorrect.value = true;
      color.value = AppColors.appSuccessColor;
/*      if((mcqReportController.formattedQuestions[index].ans??"").isEmpty){
        //noAnswer.value=true;
      }else {
        //noAnswer.value=false;
      }*/

    } else {
      if (selectedOptionIndex == index) {
        color.value = AppColors.appErrorColor;
        isClicked.value = true;
        isCorrect.value = false;
      } else {
        color.value = AppColors.appHeaderTextColor;
        isClicked.value = false;
      }
    }
    return AnimatedContainer(
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
              )),
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
            const Icon(
              Icons.circle_outlined,
              /* color:noAnswer.value && isClicked.value && isCorrect.value?AppColors.appErrorColor
                   : Colors.grey.shade400,*/
            ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }

  Widget answersSection() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: controller.formattedQuestions.length,
          (buildContext, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Card(
            clipBehavior: Clip.hardEdge,
            shadowColor:
                (controller.formattedQuestions[index].ans ?? "").isEmpty
                    ? Colors.red
                    : Colors.grey.shade200,
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
                  color: AppColors.appPrimaryColor,
                  child: Obx(() => Row(
                        children: [
                          Expanded(
                            child: Html(
                              data:
                                  "${index + 1}. ${controller.formattedQuestions[index].question}",
                              style: {
                                "body": Style(color: Colors.white),
                              },
                            ),
                          ),
                          if (controller.myReviewList.contains(
                              controller.formattedQuestions[index].id))
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
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: const [
                                      Icon(
                                        Icons.bookmark_added,
                                        color: AppColors.appSuccessColor,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                callback: () {
                                  if (!controller.isUpdating.value) {
                                    // RemoteServices.

                                    controller.removeFromReviewList(
                                      qid: controller
                                          .formattedQuestions[index].id
                                          .toString(),
                                    );
                                  }
                                }),
                          if (!controller.myReviewList.contains(
                              controller.formattedQuestions[index].id))
                            CircularButton(
                                offset: const Offset(0, 0),
                                splashColor: AppColors.appPrimaryColor,
                                bgColor: Colors.red.shade50,
                                shadowColor: Colors.transparent,
                                height: 40,
                                width: 40,
                                child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.bookmark_add,
                                      size: 30,
                                      color: AppColors.appPrimaryColor,
                                    ),),
                                callback: () {
                                  if (!controller.isUpdating.value) {
                                    controller.addToReviewList(
                                        qid: controller
                                            .formattedQuestions[index].id
                                            .toString(),
                                        chapterId: controller
                                                .formattedQuestions[index]
                                                .chapter ??
                                            "");
                                  }
                                }),
                          SizedBox(
                            width: AppDimensions.widgetPaddingHor,
                          )
                        ],
                      )),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.formattedQuestions[index]
                          .formattedOptions?.length ??
                      0,
                  shrinkWrap: true,
                  itemBuilder: (buildContext, index_2) {
                    return singleOption(quesIndex: index, index: index_2);
                    //return optionCard(questionModel: mcqReportController.formattedQuestions[index],optionTitle: mcqReportController);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: .5,
                      color: Colors.grey,
                    );
                  },
                ),
                if ((controller.formattedQuestions[index].hints ?? "")
                    .isNotEmpty)
                  Container(
                    color: Colors.red.shade50,
                    child: Obx(
                      () => Column(
                        children: [
                          Material(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  HeaderText(
                                    text: "Explanation",
                                    color: AppColors.appSecondaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red.shade50,
                            child: Html(
                              data: controller
                                  .formattedQuestions[index].hints,
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
    );
  }

  void loadMoreData() {
    if (controller.testData.value.modelQuesiton?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        if(controller.isModelTest.value)controller.loadMoreModelTestData();
        if(controller.isQuiz.value)controller.loadMoreQuizTestData();
        //controller.formattedQuestions.refresh();

      }
    }
  }
}
