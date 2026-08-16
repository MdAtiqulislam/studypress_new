import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mistake_and_review_list_item_page_controller.dart';
import '../../controllers/vocabulary_app_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/circular_button.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class VocabularyAppPage extends StatelessWidget {
  VocabularyAppPage({Key? key}) : super(key: key);

  final VocabularyAppController controller = Get.put(VocabularyAppController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingScreen()
              : CustomScrollView(
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.leftPadding),
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Swiper(
                                index: (controller
                                            .vocabularyMistakeCountData
                                            .value
                                            .userVocabularyInfo
                                            ?.userLevel ??
                                        1) -
                                    1,
                                layout: SwiperLayout.TINDER,
                                loop: false,
                                itemWidth: Get.width,
                                itemHeight: 200.0.h,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Card(
                                        color: index == 0
                                            ? Colors.green
                                            : index == 1
                                                ? Colors.orange
                                                : index == 2
                                                    ? Colors.deepOrange
                                                    : Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: AppDimensions
                                                      .widgetPaddingVer,
                                                  horizontal: AppDimensions
                                                      .widgetPaddingHor),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HeaderText(
                                                    text: controller.userInfo
                                                            .value.data?.name ??
                                                        "",
                                                    color: Colors.white,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircularButton(
                                                        width: 25,
                                                        height: 25,
                                                        offset:
                                                            const Offset(0, 0),
                                                        callback: null,
                                                        bgColor: Colors.white,
                                                        child: Icon(
                                                          Icons.star,
                                                          color: index == 0
                                                              ? Colors.green
                                                              : index == 1
                                                                  ? Colors
                                                                      .orangeAccent
                                                                  : index == 2
                                                                      ? Colors
                                                                          .deepOrange
                                                                      : Colors
                                                                          .red,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: AppDimensions
                                                            .widgetPaddingHor,
                                                      ),
                                                      HeaderText(
                                                          text: (controller
                                                                      .vocabularyUserInfo
                                                                      .value
                                                                      .point ??
                                                                  0)
                                                              .toString(),
                                                          color: Colors.white)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.contentPaddingVer,
                                            ),
                                            if (index == 0)
                                              HeaderText(
                                                text: "Easy",
                                                color: Colors.white,
                                                size: AppDimensions.titleTextSize,
                                              ),
                                            if (index == 1)
                                              HeaderText(
                                                text: "Medium",
                                                color: Colors.white,
                                                size: AppDimensions.titleTextSize,
                                              ),
                                            if (index == 2)
                                              HeaderText(
                                                text: "Hard",
                                                color: Colors.white,
                                                size: AppDimensions.titleTextSize,
                                              ),
                                            if (index == 3)
                                              HeaderText(
                                                text: "Very Hard",
                                                color: Colors.white,
                                                size: AppDimensions.titleTextSize,
                                              ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.widgetPaddingVer,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Obx(
                                                () => LinearProgressIndicator(
                                                  value: (controller
                                                                  .vocabularyMistakeCountData
                                                                  .value
                                                                  .userVocabularyInfo
                                                                  ?.point ??
                                                              0) >=
                                                          (index + 1) * 500
                                                      ? 1
                                                      : 1 /
                                                          500 *
                                                          ((controller
                                                                      .vocabularyMistakeCountData
                                                                      .value
                                                                      .userVocabularyInfo
                                                                      ?.point ??
                                                                  0) -
                                                              (index * 500)),
                                                  minHeight: 20,
                                                  color: Colors.white,
                                                  backgroundColor: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.contentPaddingVer,
                                            ),
                                            if (index == 0)
                                              BodyText(
                                                text: "Point Range:0 to 500",
                                                color: Colors.white,
                                              ),
                                            if (index == 1)
                                              BodyText(
                                                text: "Point Range:501 to 1000",
                                                color: Colors.white,
                                              ),
                                            if (index == 2)
                                              BodyText(
                                                text:
                                                    "Point Range:1001 to 1500",
                                                color: Colors.white,
                                              ),
                                            if (index == 3)
                                              BodyText(
                                                text:
                                                    "Point Range:1501 to 2000",
                                                color: Colors.white,
                                              ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.widgetPaddingVer,
                                            ),
                                            AppButton(
                                                bgColor:
                                                    AppColors.appPrimaryColor,
                                                offset: const Offset(0, 0),
                                                child: HeaderText(
                                                  text: "Start Now",
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  controller.isRefine.value =
                                                      false;
                                                  controller.fetchQuestion(
                                                      level: (controller
                                                                  .vocabularyUserInfo
                                                                  .value
                                                                  .userLevel ??
                                                              0)
                                                          .toString());
                                                  Get.toNamed(
                                                      "/vocabulary_practice_page");
                                                })
                                          ],
                                        ),
                                      ),
                                      if (index == 1 &&
                                          (controller
                                                      .vocabularyMistakeCountData
                                                      .value
                                                      .userVocabularyInfo
                                                      ?.point ??
                                                  0) <
                                              500)
                                        SizedBox(
                                          width:Get.width,
                                          child: Card(
                                            color: Colors.black.withOpacity(.6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                ),
                                                HeaderText(
                                                  text:
                                                      "You have need at-least 500 points to unlock this level",
                                                  color: Colors.white,
                                                  maxLine: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (index == 2 &&
                                          (controller
                                                      .vocabularyMistakeCountData
                                                      .value
                                                      .userVocabularyInfo
                                                      ?.point ??
                                                  0) <
                                              1000)
                                        SizedBox(
                                          width: Get.width,
                                          child: Card(
                                            color: Colors.black.withOpacity(.6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                ),
                                                HeaderText(
                                                  text:
                                                      "You have need at-least 1000 points to unlock this level",
                                                  color: Colors.white,
                                                  maxLine: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (index == 3 &&
                                          (controller
                                                      .vocabularyMistakeCountData
                                                      .value
                                                      .userVocabularyInfo
                                                      ?.point ??
                                                  0) <
                                              1500)
                                        SizedBox(
                                          width: Get.width,
                                          child: Card(
                                            color: Colors.black.withOpacity(.6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                ),
                                                HeaderText(
                                                  text:
                                                      "You have need at-least 1500 points to unlock this level",
                                                  color: Colors.white,
                                                  maxLine: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                                itemCount: 4,
                              ),
                              if ((controller.vocabularyMistakeCountData.value
                                          .mistakeCount ??
                                      0) >
                                  0)
                                SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: AppDimensions.sectionPaddingVer,
                                      ),
                                      HeaderText(
                                          text:
                                              "You have ${controller.vocabularyMistakeCountData.value.mistakeCount ?? 0} mistakes to refine"),
                                      SizedBox(
                                        height: AppDimensions.widgetPaddingVer,
                                      ),
                                      AppButton(
                                          offset: const Offset(0, 0),
                                          bgColor: AppColors.appWarningColor,
                                          child: HeaderText(
                                            text: "Refine Now",
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            controller.isRefine.value = true;
                                            controller.fetchQuestion(
                                                level: (controller
                                                            .vocabularyUserInfo
                                                            .value
                                                            .userLevel ??
                                                        0)
                                                    .toString());
                                            Get.toNamed(
                                                "/vocabulary_practice_page");
                                          }),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                height: AppDimensions.sectionPaddingVer,
                              ),
                              HeaderText(
                                text: "Recommended For You",
                                align: TextAlign.start,
                              ),
                              SizedBox(
                                height: AppDimensions.widgetPaddingVer,
                              ),



                              BasicGridItem(
                                  index: 0,
                                  title: "Current Affairs",
                                  image: "assets/icons/worldwide.png",
                                callback: () {
                                  Get.toNamed("/current_affairs_page");
                                },

                              ),
                              SizedBox(
                                height: AppDimensions.widgetPaddingVer,
                              ),
                              BasicGridItem(
                                  index: 4,
                                  title: "Review List",
                                  image: "assets/icons/reviews.png",
                                callback: () {
                                  MistakeAndReviewController controller =
                                  Get.put(MistakeAndReviewController());
                                  controller.isReview.value = true;
                                  controller.isMistake.value = false;
                                  controller.getReviewCategoryList();
                                  //controller.getCurrentWorldReviewList();
                                  controller.title.value = "My Review List";
                                  Get.toNamed("/basic_list_items_page");
                                },
                              ),
                              SizedBox(
                                height: AppDimensions.widgetPaddingVer,
                              ),
                              BasicGridItem(
                                  index: 6,
                                  title: "Mistake List",
                                  image: "assets/icons/mistake_list.png",
                                callback: () {
                                  MistakeAndReviewController controller =
                                  Get.put(MistakeAndReviewController());
                                  controller.isMistake.value = true;
                                  controller.isReview.value = false;
                                  controller.getMistakeCategoryList();
                                  controller.title.value = "My Mistake List";
                                  Get.toNamed("/basic_list_items_page");
                                },
                              ),
                              SizedBox(
                                height: AppDimensions.sectionPaddingVer,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
