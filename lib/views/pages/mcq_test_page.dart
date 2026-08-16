import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_test_controller.dart';
import '../../utilities/show_snack_bar.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/empty_card.dart';

class MCQTestPage extends StatelessWidget {
  MCQTestPage({super.key});

 final MCQTestController controller = Get.put(MCQTestController());



  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const SafeArea(
              child: Scaffold(
                body: LoadingScreen()
              ),
            )
          : SafeArea(
              child: (controller.questions.isEmpty)
                  ? Scaffold(
                      body: EmptyCard(
                        title: "Oops!!! The Question List Is Empty",
                      ),
                    )
                  : Scaffold(
                      backgroundColor: AppColors.appPrimaryColor,
                      bottomNavigationBar: bottomSection(),
                      body: Stack(
                        children: [
                          CustomScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: AppDimensions.topPadding,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: headerSection(),
                              ),
                             /* SliverToBoxAdapter(
                                child: SizedBox(
                                  height: Dimensions.sectionPaddingVer,
                                ),
                              ),*/
                              SliverFillRemaining(
                                child: bodySection(),
                              )
                            ],
                          ),
                          if (controller.isUpdating.value)
                            const LoadingScreen(),
                        ],
                      ),
                    ),
            ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
      child: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  // color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                            SizedBox(
                              //clipBehavior: Clip.hardEdge,
                              height: Get.height * .8,
                              child: Scaffold(
                                appBar: AppBar(
                                  title: HeaderText(
                                    text: "All Questions",
                                    color: AppColors.appHeaderTextColor,
                                    resizeable: false,
                                  ),
                                  centerTitle: true,
                                  leading: IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                body: CustomScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  slivers: [
                                    // SliverToBoxAdapter(child: SizedBox(height: Dimensions.sectionPaddingVer,),),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          childCount: controller.formattedQuestions
                                              .length, (buildContext, index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            //  color: controller.clickedQuestionsId.value.contains(index)?Colors.green.shade50:Colors.red.shade50,
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey, width: .5),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              controller.currentQuestionIndex.value = index;
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  AppDimensions.widgetPaddingVer,
                                                  horizontal:
                                                  AppDimensions.leftPadding),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: HeaderText(
                                                        text: "${index + 1}",resizeable: false,),
                                                  ),
                                                  Expanded(
                                                    child: Html(
                                                        data: controller
                                                            .formattedQuestions
                                                            [index]
                                                            .question ??
                                                            ""),
                                                  ),
                                                  controller
                                                      .clickedQuestionsId
                                                      .contains(index)
                                                      ? const Icon(
                                                    Icons.circle,
                                                    color: Colors.green,
                                                  )
                                                      : const Icon(Icons.circle_outlined),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            ignoreSafeArea: true,
                            enterBottomSheetDuration:
                            const Duration(milliseconds: 700),
                            exitBottomSheetDuration:
                            const Duration(milliseconds: 700),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.r),
                                topLeft: Radius.circular(20.r),
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.grid_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: HeaderText(
                    text:
                        "Question: ${controller.currentQuestionIndex.value + 1} of ${controller.formattedQuestions.length}",
                    color: Colors.white,
                    // fontWeight: FontWeight.f,
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  // color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                            SizedBox(
                              //clipBehavior: Clip.hardEdge,
                              height: Get.height * .8,
                              child: Scaffold(
                                appBar: AppBar(
                                  title: HeaderText(
                                    text: "All Questions",
                                    color: AppColors.appHeaderTextColor,
                                    resizeable: false,
                                  ),
                                  centerTitle: true,
                                  leading: IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                body: CustomScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  slivers: [
                                    // SliverToBoxAdapter(child: SizedBox(height: Dimensions.sectionPaddingVer,),),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          childCount: controller.formattedQuestions
                                              .length, (buildContext, index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            //  color: controller.clickedQuestionsId.value.contains(index)?Colors.green.shade50:Colors.red.shade50,
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey, width: .5),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              controller.currentQuestionIndex.value = index;
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      AppDimensions.widgetPaddingVer,
                                                  horizontal:
                                                      AppDimensions.leftPadding),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: HeaderText(
                                                        text: "${index + 1}",resizeable: false,),
                                                  ),
                                                  Expanded(
                                                    child: Html(
                                                        data: controller
                                                                .formattedQuestions
                                                                [index]
                                                                .question ??
                                                            ""),
                                                  ),
                                                  controller
                                                          .clickedQuestionsId
                                                          .contains(index)
                                                      ? const Icon(
                                                          Icons.circle,
                                                          color: Colors.green,
                                                        )
                                                      : const Icon(Icons.circle_outlined),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            ignoreSafeArea: true,
                            enterBottomSheetDuration:
                                const Duration(milliseconds: 700),
                            exitBottomSheetDuration:
                                const Duration(milliseconds: 700),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.r),
                                topLeft: Radius.circular(20.r),
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.grid_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              //height: 50,
              width: 170.w,
              decoration: BoxDecoration(
                color: AppColors.appSecondaryColor,
               // color: Colors.black,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.contentPaddingHor,
                    vertical: AppDimensions.contentPaddingVer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer,
                    // color: AppColors.appPrimaryColor,
                     color: Colors.white,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: AppDimensions.sectionPaddingHor,
                    ),
                    Expanded(
                      child: TimerCountdown(
                        colonsTextStyle: TextStyle(
                           // color: Colors.white,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "clock",
                            fontSize: 20.sp),
                        timeTextStyle: TextStyle(
                            //color: AppColors.appPrimaryColor,
                            color: Colors.white,
                            //color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "clock",
                            fontSize: 20.sp),
                        enableDescriptions: false,
                        format: CountDownTimerFormat.hoursMinutesSeconds,
                        endTime: controller.startTime.value.add(
                          Duration(
                            days: 0,
                            hours: 0,
                            minutes: 0,
                            seconds: controller.timeSeconds.value,
                          ),
                        ),
                        onEnd: () {
                          controller.isUpdating.value = true;
                          controller.submitData();
                          Get.closeAllSnackbars();
                          CustomSnackBar(
                              duration: 5,
                              isSuccess: true,
                              msg:
                              "Your time has been finished and your your paper has been submitted automatically.",
                              title: "Times Up!")
                              .showSnackBar();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget bodySection() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.leftPadding,
                vertical: AppDimensions.topPadding),
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.sectionPaddingVer),

                Html(
                  data: controller.formattedQuestions[controller.currentQuestionIndex.value].question ??
                      "",
                  style: {
                    "body": Style(
                        fontSize: FontSize(18.sp),
                        fontWeight: FontWeight.bold,
                        color: AppColors.appHeaderTextColor)
                  },
                ),
                // HeaderText(text: "কোন শাসনামলে চর্যাপদ রচিত হয়েছে বলে জানা যায়?",maxLine: 10,),
                SizedBox(
                  height: AppDimensions.sectionPaddingVer,
                ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller
                          .formattedQuestions[controller.currentQuestionIndex.value]
                          .formattedOptions
                          ?.length ??
                      0,
                  itemBuilder: (buildContext, index) {
                    return Obx(
                      () => SizedBox(
                        //height: 100,
                        width: Get.width,
                        child: AppButton(
                          bgColor: Colors.white,
                          offset: const Offset(0, 0),
                          blurRadius: 10,
                          shadowColor: controller
                                  .formattedQuestions[controller.currentQuestionIndex.value]
                                  .myOptions!
                                  .isNotEmpty
                              ? index ==
                                      (controller
                                              .formattedQuestions[controller.currentQuestionIndex.value]
                                              .myOptions
                                              ?.last ??
                                          -1)
                                  ? AppColors.appSuccessColor
                                  : Colors.grey.shade100
                              : AppColors.appSecondaryColor.withOpacity(.9),
                          onTap: () {
                            // selectedOptionIndex.value = index;

                            controller.currentAnswerIndex.value = index;

                            controller
                                .formattedQuestions[controller.currentQuestionIndex.value]
                                .ans = controller.optionsIndex[index];
                            if (controller
                                .formattedQuestions[controller.currentQuestionIndex.value]
                                .myOptions!
                                .isNotEmpty) {
                              controller
                                  .formattedQuestions[controller.currentQuestionIndex.value]
                                  .myOptions![0] = index;
                            } else {
                              controller.formattedQuestions[controller.currentQuestionIndex.value].myOptions
                                  ?.add(index);
                            }
                            controller.formattedQuestions.refresh();
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Html(
                                  data: "(${controller.optionsIndex[index]}). "
                                      "${controller.formattedQuestions[controller.currentQuestionIndex.value].formattedOptions?[index] ?? ""}",
                                  style: {
                                    "body": controller
                                            .formattedQuestions[controller.currentQuestionIndex.value]
                                            .myOptions!
                                            .isNotEmpty
                                        ? Style(
                                            color: index == (controller.formattedQuestions[controller.currentQuestionIndex.value].myOptions?.last ?? -1)
                                                ? AppColors.appSuccessColor
                                                : AppColors.appHeaderTextColor,
                                            fontWeight: index ==
                                                    (controller
                                                            .formattedQuestions[
                                                    controller.currentQuestionIndex
                                                                    .value]
                                                            .myOptions
                                                            ?.last ??
                                                        -1)
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: index ==
                                                    (controller
                                                            .formattedQuestions[
                                                    controller.currentQuestionIndex
                                                                    .value]
                                                            .myOptions
                                                            ?.last ??
                                                        -1)
                                                ? FontSize(18.sp)
                                                : FontSize(15.sp))
                                        : Style(
                                            color: AppColors.appHeaderTextColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: FontSize(15.sp))
                                  },
                                ),
                              ),
                              if (controller
                                  .formattedQuestions[controller.currentQuestionIndex.value]
                                  .myOptions!
                                  .isEmpty)
                                const Icon(Icons.circle_outlined)
                              else if (index ==
                                  (controller
                                          .formattedQuestions[controller.currentQuestionIndex.value]
                                          .myOptions
                                          ?.last ??
                                      -1))
                                const Icon(
                                  Icons.circle,
                                  color: AppColors.appSuccessColor,
                                )
                              else
                                const Icon(Icons.circle_outlined)
                              //if(index!=(mcqTestController.formattedQuestions.value[currentQuestionIndex.value].myOptions?[0]??-1)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: AppDimensions.widgetPaddingVer);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSection() {
    return Container(
      // height: 100,
      color: Colors.white.withOpacity(.9),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.leftPadding,
            vertical: AppDimensions.widgetPaddingVer),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //previous question btn
            IgnorePointer(
              ignoring: controller.isUpdating.value,
              child: AppButton(
                onTap: () {
                  if (controller.currentQuestionIndex.value > 0) {
                    controller.currentQuestionIndex.value--;
                  }
                },
                bgColor: Colors.white,
                offset: const Offset(0, 1),
                blurRadius: 2,
                child:  Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.appSecondaryColor,
                  size: AppDimensions.titleTextSize.sp,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),

            controller.quizType.value=="chapterQuiz"
                ?(controller.currentQuestionIndex.value+1 !=
                (controller.responseQuiz.value.data?.length?? 0))?
            //next btn
            Expanded(
              child: IgnorePointer(
                ignoring: controller.isUpdating.value,
                child: AppButton(
                  offset: const Offset(0, 3),
                  shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
                  bgColor: Colors.white,
                  onTap: () {
                    if(controller.currentQuestionIndex.value+1==controller.formattedQuestions.length){
                      controller.isUpdating.value=true;
                      controller.loadMoreData(questionIndex: controller.currentQuestionIndex.value,
                          answerIndex: controller.currentAnswerIndex.value);
                    }else{
                      controller.loadNextQuestion(
                          questionIndex: controller.currentQuestionIndex.value,
                          answerIndex: controller.currentAnswerIndex.value);
                      controller.currentQuestionIndex.value++;
                      controller.currentAnswerIndex.value = -1;
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeaderText(
                          text: "Next",
                          color: AppColors.appSecondaryColor,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.appSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            //submit btn
                :Expanded(
              child: IgnorePointer(
                ignoring: controller.isUpdating.value,
                child: IgnorePointer(
                  ignoring: controller.isUpdating.value,
                  child: AppButton(
                    offset: const Offset(0, 3),
                    shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
                    bgColor: Colors.white,
                    onTap: () {
                      showDialog(
                          barrierDismissible: false,
                          context: Get.context!,
                          builder: (context) {
                            return CustomDialog(
                                showHeaderImage: true,
                                image: "assets/icons/test.png",
                                titleText: "Attention!",
                                confirmText: "Submit",
                                headerText: "Your going to submit your paper.",
                                bodyText:
                                "Do you really want to submit it now?",
                                onConfirm: () {
                                  controller.isUpdating.value = true;
                                  Get.back();
                                  controller.submitData();
                                },
                                onCancel: () {
                                  Get.back();
                                });
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeaderText(
                            text: "Submit",
                            color: AppColors.appSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )



                : (controller.currentQuestionIndex.value+1 !=
                (controller.responseModelTest.value.data?.total ?? 0))?
            //next btn
              Expanded(
                child: IgnorePointer(
                  ignoring: controller.isUpdating.value,
                  child: AppButton(
                    offset: const Offset(0, 3),
                    shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
                    bgColor: Colors.white,
                    onTap: () {
                      if(controller.currentQuestionIndex.value+1==controller.formattedQuestions.length){
                        controller.isUpdating.value=true;
                        controller.loadMoreData(questionIndex: controller.currentQuestionIndex.value,
                            answerIndex: controller.currentAnswerIndex.value);
                      }else{
                        controller.loadNextQuestion(
                            questionIndex: controller.currentQuestionIndex.value,
                            answerIndex: controller.currentAnswerIndex.value);
                        controller.currentQuestionIndex.value++;
                        controller.currentAnswerIndex.value = -1;
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeaderText(
                            text: "Next",
                            color: AppColors.appSecondaryColor,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.appSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )

            //submit btn
              :Expanded(
                child: IgnorePointer(
                  ignoring: controller.isUpdating.value,
                  child: IgnorePointer(
                    ignoring: controller.isUpdating.value,
                    child: AppButton(
                      offset: const Offset(0, 3),
                      shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
                      bgColor: Colors.white,
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: Get.context!,
                            builder: (context) {
                              return CustomDialog(
                                  showHeaderImage: true,
                                  image: "assets/icons/test.png",
                                  titleText: "Attention!",
                                  confirmText: "Submit",
                                  headerText: "Your going to submit your paper.",
                                  bodyText:
                                  "Do you really want to submit it now?",
                                  onConfirm: () {
                                    controller.isUpdating.value = true;
                                    Get.back();
                                    controller.submitData();
                                  },
                                  onCancel: () {
                                    Get.back();
                                  });
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeaderText(
                              text: "Submit",
                              color: AppColors.appSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            SizedBox(
              width: AppDimensions.contentPaddingHor,
            ),

            //quit test btn

            IgnorePointer(
              ignoring: controller.isUpdating.value,
              child: AppButton(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: Get.context!,
                      builder: (context) {
                        return CustomDialog(
                          confirmText: "Save and Quit",
                            cancelText: "Quit",
                            showHeaderImage: true,
                            image: "assets/icons/warning.png",
                            imagePadding: 15.r,
                            titleText: "Warning!",
                            headerText: "Your going to Quit this test.",
                            bodyText:
                                "Do you really want to quit it?",
                            onConfirm: () {
                              controller.isUpdating.value = true;
                              Get.back();
                              controller.submitData();
                              //controller.submitData();
                            },
                            onCancel: () {
                              Get.back();
                              Get.back();
                            });
                      });
                },
                bgColor: Colors.white,
                splashColor: Colors.red,
                shadowColor: Colors.red.shade100,
                offset: const Offset(0, 0),
                // blurRadius: 20,
                child: HeaderText(
                  text: "Quit",
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
