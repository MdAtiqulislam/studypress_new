import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/vocabulary_app_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_button.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class VocabularyPractisePage extends StatelessWidget {
  VocabularyPractisePage({Key? key}) : super(key: key);
  final VocabularyAppController controller = Get.put(VocabularyAppController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
        drawer: MyDrawer(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: controller.isRefine.value
                ? AppButton(
                    bgColor: AppColors.appPrimaryColor,
                    onTap: () {
                      controller.isRefine.value = false;
                      controller.fetchQuestion(
                          level:
                              (controller.vocabularyUserInfo.value.userLevel ??
                                      0)
                                  .toString());
                      Get.toNamed("/vocabulary_practice_page");
                    },
                    child: HeaderText(
                      text: "Go to Vocabulary App",
                      color: Colors.white,
                    ),
                  )
                : const Text(""),
            body: controller.isLoading.value
                ? const LoadingScreen()
                : Stack(
                    children: [
                      CustomScrollView(
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
                                text: "StudyPress Vocabulary App",
                                maxLine: 2,
                              ),
                              background: Stack(
                                children: [
                                  const SliverAppBarBackground(),
                                  if (controller.isRefine.value)
                                    Positioned(
                                      top: 40.h,
                                      right: 20,
                                      child: HeaderText(
                                        text:
                                            "${controller.vocabularyMistakeCountData.value.mistakeCount} Mistakes to Refine",
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
                            expandedHeight: 200.h,
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.leftPadding),
                              child: Card(
                                color: Colors.green.shade50,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.widgetPaddingHor,
                                      vertical: AppDimensions.sectionPaddingVer),
                                  child: Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        HeaderText(
                                            text:
                                                "Level: ${controller.vocabularyUserInfo.value.userLevel ?? "0"}/4"),
                                        Row(
                                          children: [
                                            CircularButton(
                                              width: 25,
                                              height: 25,
                                              offset: const Offset(0, 0),
                                              callback: null,
                                              bgColor: Colors.white,
                                              child: const Icon(
                                                Icons.star,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppDimensions.widgetPaddingHor,
                                            ),
                                            HeaderText(
                                                text: (controller
                                                            .vocabularyUserInfo
                                                            .value
                                                            .point ??
                                                        "0")
                                                    .toString(),
                                                color: Colors.red)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!controller.isClicked.value)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.leftPadding),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          color: AppColors.appPrimaryColor,
                                          child: Html(
                                            data: controller.vocabularyQueData
                                                    .value.list?[0].question ??
                                                "",
                                            style: {
                                              "body": Style(
                                                  fontSize: FontSize(18.sp),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: AppDimensions.sectionPaddingVer,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.formattedOption.length,
                                          itemBuilder: (buildContext, index) {
                                            return singleOption(index: index);
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (controller.isClicked.value &&
                              controller.correctAnswerIndex.value ==
                                  controller.myAnswerIndex.value)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.leftPadding),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        color: Colors.green.shade50,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  AppDimensions.sectionPaddingVer),
                                          child: HeaderText(
                                            text: "Correct",
                                            color: AppColors.appSuccessColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      ),
                                      if (!controller.isDetailed.value)
                                        Column(
                                          children: [
                                            BodyText(
                                              text: "5 points Added.",
                                              size: 16,
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.contentPaddingVer,
                                            ),
                                            //BodyText(text: "Correct Answer: ${controller.formattedOption.value[controller.correctAnswerIndex.value]}"),
                                            BodyText(
                                                text:
                                                    "Meaning : ${controller.vocabularyQueData.value.list?[0].word?.meaning}"),
                                          ],
                                        ),
                                      if (controller.isDetailed.value)
                                        detailsSection(),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!controller.isDetailed.value)
                                            AppButton(
                                                offset: const Offset(0, 0),
                                                bgColor:
                                                    AppColors.appSuccessColor,
                                                child: HeaderText(
                                                  text: "View Details",
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  controller.isDetailed.value =
                                                      true;
                                                }),
                                          SizedBox(
                                            width: AppDimensions.sectionPaddingHor,
                                          ),
                                          if ((controller.isRefine.value &&
                                                  controller
                                                          .vocabularyMistakeCountData
                                                          .value
                                                          .mistakeCount! >=
                                                      1) ||
                                              !controller.isRefine.value)
                                            AppButton(
                                                offset: const Offset(0, 0),
                                                bgColor:
                                                    AppColors.appPrimaryColor,
                                                child: HeaderText(
                                                  text: "Next Question",
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  controller.fetchQuestion(
                                                      level: (controller
                                                                  .vocabularyUserInfo
                                                                  .value
                                                                  .userLevel ??
                                                              1)
                                                          .toString());
                                                }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (controller.isClicked.value &&
                              controller.correctAnswerIndex.value !=
                                  controller.myAnswerIndex.value)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.leftPadding),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        color: Colors.red.shade50,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  AppDimensions.sectionPaddingVer),
                                          child: HeaderText(
                                            text: "Wrong!!!",
                                            color: AppColors.appErrorColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      ),
                                      if (!controller.isDetailed.value)
                                        Column(
                                          children: [
                                            BodyText(
                                              text: "2 points Deducted.",
                                              size: 16,
                                            ),
                                            //BodyText(text: "Correct Answer: ${controller.formattedOption.value[controller.correctAnswerIndex.value]}"),
                                            BodyText(
                                                text:
                                                    "Correct Answer: ${controller.formattedOption[controller.correctAnswerIndex.value]}"),
                                          ],
                                        ),
                                      if (controller.isDetailed.value)
                                        detailsSection(),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!controller.isDetailed.value)
                                            AppButton(
                                                offset: const Offset(0, 0),
                                                bgColor:
                                                    AppColors.appSuccessColor,
                                                child: HeaderText(
                                                  text: "View Details",
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  controller.isDetailed.value =
                                                      true;
                                                }),
                                          SizedBox(
                                            width: AppDimensions.sectionPaddingHor,
                                          ),
                                          AppButton(
                                              offset: const Offset(0, 0),
                                              bgColor:
                                                  AppColors.appPrimaryColor,
                                              child: HeaderText(
                                                text: "Next Question",
                                                color: Colors.white,
                                              ),
                                              onTap: () {
                                                controller.fetchQuestion(
                                                    level: (controller
                                                                .vocabularyUserInfo
                                                                .value
                                                                .userLevel ??
                                                            1)
                                                        .toString());
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (controller.isUpdating.value) const LoadingScreen()
                    ],
                  ),
          )),
    );
  }

  Widget singleOption({required int index}) {
    return Obx(
      () => Material(
        color: Colors.white,
        child: InkWell(
          splashColor: AppColors.appPrimaryColor,
          onTap: () {
            controller.isClicked.value = true;
            controller.myAnswerIndex.value = index;
            if (index == controller.correctAnswerIndex.value) {
              controller.storeAnswer(
                  id: controller.vocabularyQueData.value.list![0].wordId
                      .toString(),
                  type: "correct");
            } else {
              HapticFeedback.vibrate();
              controller.storeAnswer(
                  id: controller.vocabularyQueData.value.list![0].wordId
                      .toString(),
                  type: "incorrect");
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPaddingHor,
                vertical: AppDimensions.widgetPaddingVer),
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
                    shadowOpacity: 1,
                    shadowColor: Colors.grey.withOpacity(.5),
                    callback: null,
                    child: Center(
                      child: HeaderText(
                        text: controller.optionIndexes[index],
                        color: AppColors.appHeaderTextColor,
                        resizeable: false,
                      ),
                    )),
                SizedBox(
                  width: AppDimensions.leftPadding,
                ),
                Expanded(
                  child: Html(
                    data: "${controller.formattedOption[index]}",
                    style: {
                      "body": Style(
                          color: AppColors.appHeaderTextColor,
                          fontSize: FontSize(14.sp),
                          fontWeight: FontWeight.normal)
                    },
                  ),
                ),
                Icon(
                  controller.myAnswerIndex.value == index &&
                          controller.myAnswerIndex.value ==
                              controller.correctAnswerIndex.value
                      ? Icons.check_circle_outline
                      : controller.myAnswerIndex.value == index &&
                              controller.myAnswerIndex.value !=
                                  controller.correctAnswerIndex.value
                          ? Icons.cancel_outlined
                          : Icons.circle_outlined,
                  color: controller.myAnswerIndex.value == index &&
                          controller.myAnswerIndex.value ==
                              controller.correctAnswerIndex.value
                      ? AppColors.appSuccessColor
                      : controller.myAnswerIndex.value == index &&
                              controller.myAnswerIndex.value !=
                                  controller.correctAnswerIndex.value
                          ? AppColors.appErrorColor
                          : Colors.grey,
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

  Widget detailsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
      child: Column(
        children: [
          HeaderText(
              text:
                  controller.vocabularyQueData.value.list?[0].word?.word ?? ""),
          // SizedBox(height: Dimensions.contentPaddingVer,),
          HeaderText(
              text: controller.vocabularyQueData.value.list?[0].word?.meaning ??
                  ""),
          SizedBox(
            height: AppDimensions.contentPaddingVer,
          ),
          if ((controller.vocabularyQueData.value.list?[0].word?.synonyms ?? "")
              .isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.contentPaddingVer),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BodyText(
                  text:
                      "Synonyms: ${controller.vocabularyQueData.value.list?[0].word?.synonyms ?? ""}",
                  align: TextAlign.start,
                ),
              ),
            ),
          if ((controller.vocabularyQueData.value.list?[0].word?.antonyms ?? "")
              .isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.contentPaddingVer),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BodyText(
                  text:
                      "Antonyms: ${controller.vocabularyQueData.value.list?[0].word?.antonyms ?? ""}",
                  align: TextAlign.start,
                ),
              ),
            ),
          if ((controller.vocabularyQueData.value.list?[0].word?.example ?? "")
              .isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: BodyText(
                text:
                    "Example: ${controller.vocabularyQueData.value.list?[0].word?.example ?? ""}",
                align: TextAlign.start,
              ),
            ),
        ],
      ),
    );
  }
}
