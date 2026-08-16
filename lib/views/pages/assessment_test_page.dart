import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/assessment_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';

class AssessmentTestPage extends StatelessWidget {
  AssessmentTestPage({super.key});
  AssessmentController controller = Get.put(AssessmentController());

  var isClicked = false.obs;
  var clickedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const LoadingScreen()
            : Scaffold(
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           SizedBox(
                            height: 50.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.leftPadding,
                                vertical: AppDimensions.topPadding),
                            child: BodyText(
                                text:
                                    "Please answer 15 questions so that we can assess how you can improve your learning."),
                          ),
                          HeaderText(
                            text:
                                "Completed: ${controller.assessmentCount.value}/15",
                            color: AppColors.appSecondaryColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.r),
                            child: LinearPercentIndicator(
                              // width: 140.0,
                              barRadius: Radius.circular(10.r),
                              lineHeight: 20,
                              percent:
                                  (1 / 20) * (controller.assessmentCount.value),
                              linearGradient: LinearGradient(colors: [
                                AppColors.appSecondaryColor.withOpacity(.2),
                                AppColors.appSecondaryColor.withOpacity(.8)
                              ]),
                              backgroundColor: Colors.grey,
                              //progressColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPaddingVer,
                          ),
                          Center(
                            child: Card(
                              color: AppColors.appPrimaryColor,
                              elevation: 5,
                              shadowColor: AppColors.appSecondaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, top: 10, left: 10, right: 10),
                                child: SizedBox(
                                  width: 130.sp,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${(controller.time.value) ~/ 3600}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.sp,
                                            fontFamily: "clock"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppDimensions.contentPaddingHor),
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.sp,
                                              fontFamily: "clock"),
                                        ),
                                      ),
                                      Text(
                                        "${((controller.time.value) % 3600) ~/ 60}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.sp,
                                            fontFamily: "clock"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppDimensions.contentPaddingHor),
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.sp,
                                              fontFamily: "clock"),
                                        ),
                                      ),
                                      Text(
                                        "${((controller.time.value) % 3600) % 60}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.sp,
                                            fontFamily: "clock"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPaddingVer,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                              semanticContainer: false,
                              shadowColor: AppColors.appSecondaryColor,
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  Container(
                                    color: AppColors.appPrimaryColor,
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Html(
                                          data: controller.assessmentData.value
                                                  .data?[0].question ??
                                              "",
                                          style: {
                                            "body": Style(color: Colors.white,fontSize: FontSize(12.sp))
                                          },
                                        )),
                                  ),
                                   SizedBox(
                                    height: 30.h,
                                  ),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.formattedOption.length,
                                    shrinkWrap: true,
                                    itemBuilder: (buildContext, index) {
                                      return InkWell(
                                          /* onTap: () {
                                    practiseChapterController
                                        .optionClicked(
                                        questionIndex: index,
                                        optionIndex: index_2);
                                  },*/
                                          child: singleOption(index: index));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: .5,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppButton(
                              bgColor: AppColors.appPrimaryColor,
                              offset: const Offset(0, 2),
                              child: HeaderText(
                                text: "Next".toUpperCase(),
                                color: Colors.white,
                              ),
                              onTap: () {
                                controller.stopCounting.value = true;
                                isClicked.value = false;
                                clickedIndex.value = (-1);
                                controller.submitAssessmentData();
                              }),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                    ),
                    if (controller.isUpdating.value) const LoadingScreen()
                  ],
                ),
              ),
      ),
    );
  }

  Widget singleOption({required int index}) {
    return Obx(
      () => IgnorePointer(
        ignoring: isClicked.value,
        child: InkWell(
          onTap: () {
            isClicked.value = true;
            clickedIndex.value = index;
            controller.isCorrect.value =
                (index == controller.correctAnsIndex.value);
          },
          child: AnimatedContainer(
            padding: isClicked.value && clickedIndex.value == index
                ? const EdgeInsets.symmetric(vertical: 10)
                : const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: isClicked.value && clickedIndex.value == index
                    ? (controller.isCorrect.value
                        ? Colors.green.shade50
                        : Colors.red.shade50)
                    : isClicked.value &&
                            index == controller.correctAnsIndex.value
                        ? Colors.green.shade50
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
                  width: 20.sp,
                  height: 20.sp,
                  offset: const Offset(0, 0),
                  shadowOpacity: isClicked.value ? 1 : .2,
                  callback: null,
                  //shadowColor: color.value,
                  child: Center(
                    child: HeaderText(
                      text: controller.optionsIndex[index],
                      size: 14,
                      // color: color.value,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppDimensions.leftPadding,
                ),
                Expanded(
                  child: Html(
                    data: "${controller.formattedOption[index]}",
                    style: {
                      "body": Style(
                          //color: color.value,
                          fontSize: isClicked.value
                              ? FontSize(14.sp)
                              : FontSize(12.sp),
                          fontWeight: isClicked.value
                              ? FontWeight.bold
                              : FontWeight.normal)
                    },
                  ),
                ),
                if (isClicked.value &&
                    index == controller.correctAnsIndex.value)
                   Icon(
                    Icons.check_circle_outline,
                    color: AppColors.appSuccessColor,
                    size: 20.sp,
                  ),
                if (isClicked.value &&
                    !controller.isCorrect.value &&
                    clickedIndex.value == index)
                   Icon(
                    Icons.cancel_outlined,
                    color: AppColors.appErrorColor,
                    size: 20.sp,
                  ),
                if (!isClicked.value ||
                    (isClicked.value &&
                        index != clickedIndex.value &&
                        index != controller.correctAnsIndex.value))
                  Icon(
                    Icons.circle_outlined,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
