import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/practise_chapter_controller.dart';
import '../../controllers/review_list_controller.dart';
import '../../models/single_question_model.dart';
import 'circular_button.dart';

class OptionWidgetInPractise extends StatelessWidget {
  SingleQuestionModel formattedQuestions;
  int index;
  VoidCallback? optionClicked;

  OptionWidgetInPractise(
      {super.key, required this.formattedQuestions, required this.index,this.optionClicked});

  var color = Colors.white.obs;
  var isCorrect = false.obs;
  var isClicked = false.obs;
  var optionsIndex=["A", "B", "C", "D", "E","F"];


  ReviewListController reviewListController=Get.put(ReviewListController());
  PractiseChapterController practiseChapterController=Get.put(PractiseChapterController());

  @override
  Widget build(BuildContext context) {

    reviewListController.getReviewList();
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Card(
        clipBehavior: Clip.hardEdge,
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
                              "${index + 1}. ${formattedQuestions.question}",
                          style: {
                            "body": Style(color: Colors.white),
                          },
                        ),
                      ),
                      if (reviewListController.myReviewList.contains(
                          formattedQuestions.id))
                        CircularButton(
                            offset: Offset(0, 0),
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
                                  children: [
                                    /* Image.asset(
                                                      "assets/icons/bookmark.png",
                                                      fit: BoxFit.fill,
                                                    ),*/
                                    Icon(
                                      Icons.bookmark_added,
                                      color: AppColors.appSuccessColor,
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
                              if (!reviewListController.isUpdating.value) {
                                reviewListController.removeFromReviewList(
                                    qid: formattedQuestions.id
                                        .toString());
                              }
                            }),
                      if (!reviewListController.myReviewList.contains(
                          formattedQuestions.id))
                        CircularButton(
                            offset: Offset(0, 0),
                            splashColor: AppColors.appPrimaryColor,
                            bgColor: Colors.red.shade50,
                            shadowColor: Colors.transparent,
                            height: 40,
                            width: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.bookmark_add,
                                size: 30,
                                color: AppColors.appPrimaryColor,
                              ) /*Image.asset(
                                                  "assets/icons/bookmark.png",
                                                  fit: BoxFit.fill,
                                                )*/
                              ,
                            ),
                            callback: () {
                              print(reviewListController.isUpdating.value);
                              if (!reviewListController.isUpdating.value) {
                                reviewListController.addToReviewList(
                                    qid:formattedQuestions.id
                                        .toString(),
                                  chapterId: formattedQuestions.chapter??""
                                );
                              }
                            }),
                      SizedBox(
                        width: AppDimensions.widgetPaddingHor,
                      )
                    ],
                  ),),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formattedQuestions.formattedOptions?.length ??0,
              shrinkWrap: true,
              itemBuilder: (buildContext, index_2) {
                return InkWell(
                    onTap: () {

                      practiseChapterController.optionClicked(
                          questionIndex: index, optionIndex: index_2);
                    },
                    child: singleOption(quesIndex: index, index: index_2));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: .5,
                  color: Colors.grey,
                );
              },
            ),
            if ((formattedQuestions.hints ??
                        "")
                    .isNotEmpty &&
                practiseChapterController.myAnswers.contains(index))
              Container(
                  color: Colors.red.shade50,
                  child: Obx(
                    () => Column(
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            data: formattedQuestions.hints,
                          ),
                        ),
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  Widget singleOption({required quesIndex, required int index}) {
    if (formattedQuestions.myOptions!
        .contains(index)) {
      if (index ==formattedQuestions.correctAnswerIndex) {
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
        practiseChapterController.optionClicked(
            questionIndex: quesIndex, optionIndex: index);
      },
      child: AnimatedContainer(
        padding: isClicked.value
            ? EdgeInsets.symmetric(vertical: 10)
            : EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: isClicked.value && isCorrect.value
                ? Colors.green.shade50
                : isClicked.value && !isCorrect.value
                    ? Colors.red.shade50
                    : Colors.white
            // border: Border.all(color: isClicked.value?color.value:Colors.transparent)
            ),
        duration: Duration(milliseconds: 500),
        child: Row(
          children: [
            SizedBox(
              width: AppDimensions.widgetPaddingHor,
            ),
            CircularButton(
                //bgColor: ,
                width: 30,
                height: 30,
                offset: Offset(0, 0),
                shadowOpacity: isClicked.value ? 1 : .2,
                shadowColor: color.value,
                child: Center(
                    child: HeaderText(
                  text: "${optionsIndex[index]}",
                  color: color.value,
                )),
                callback: null),
            SizedBox(
              width: AppDimensions.leftPadding,
            ),
            Expanded(
              child: Html(
                data:
                    "${formattedQuestions.formattedOptions?[index]}",
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
              Icon(
                Icons.check_circle_outline,
                color: AppColors.appSuccessColor,
              ),
            if (isClicked.value && !isCorrect.value)
              Icon(
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
}
