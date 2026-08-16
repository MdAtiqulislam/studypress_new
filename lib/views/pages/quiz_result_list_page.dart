import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_report_controller.dart';
import '../../controllers/result_list_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/empty_card.dart';
import '../widgets/my_drawer.dart';
import '../widgets/single_result_list_item.dart';
import '../widgets/sliver_app_bar_background.dart';

class QuizResultListPage extends StatelessWidget {
  QuizResultListPage({Key? key}) : super(key: key);
 // var endPoint = Get.arguments[0]; //enrollment id
  //var title = Get.arguments[1]; //enrollment category name
  //var testType = Get.arguments[2]; //model test or live test
  //var index = Get.arguments[3];

  final ResultListController controller =
      Get.put(ResultListController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
   // controller.getQuizResultList(endPoint: endPoint);

    _scrollController.addListener(() {
      // print("Content Height: ${_globalKey.currentContext?.size?.height}");
      loadMoreData();
    });

    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const Scaffold(
                body: LoadingScreen()
              )
            : Scaffold(
          drawer: MyDrawer(),
                body: CustomScrollView(
                  controller: _scrollController,
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
                          text: "${controller.title.value}: ${controller.testType.value}",
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
                        childCount: (controller
                                    .quizListData.value.data?.data?.length ??
                                0) +
                            1,
                        (buildContext, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.leftPadding),
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.contentPaddingHor),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              //color: Colors.green,
                              child: index == 0
                                  ? Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r),
                                        ),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        children: [
                                          BasicGridItem(
                                            titleTextColor:
                                                AppColors.appHeaderTextColor,
                                            //sGradientColour: false,
                                            borderRadius: 5.r,
                                            bgColor: Colors.white,
                                            index: index,
                                            title: controller.testType.value,
                                            gapBetween: 30.w,
                                            subTitle:
                                                "Total Tests: ${controller.quizListData.value.data?.data?.length ?? 0}",
                                            image:
                                                "assets/moc_icons/moc_icons_${index % 10}.png",
                                          ),
                                          if ((controller
                                                      .quizListData
                                                      .value
                                                      .data
                                                      ?.data
                                                      ?.length ??
                                                  0) <=
                                              0)
                                            EmptyCard(
                                              title:
                                                  "It's seems you didn't participate any Quiz yet!",
                                            )
                                        ],
                                      ),
                                    )
                                  : SingleResultListItem(
                                      callback: () {
                                        MCQReportController
                                            resultDataController =
                                            Get.put(MCQReportController());
                                        resultDataController.title.value =
                                            controller
                                                    .quizListData
                                                    .value
                                                    .data
                                                    ?.data?[index - 1]
                                                    .chapter
                                                    ?.name ??
                                                "";
                                        resultDataController.quizId.value= (controller
                                            .quizListData
                                            .value
                                            .data
                                            ?.data?[index - 1]
                                            .quizId ??
                                            "");
                                        resultDataController.fetchQuizData();
                                      },
                                      title:
                                          "Quiz Name: ${controller.quizListData.value.data?.data?[index - 1].chapter?.name ?? ""}",
                                      date: controller
                                              .quizListData
                                              .value
                                              .data
                                              ?.data?[index - 1]
                                              .quizDate ??
                                          DateTime.now(),
                                      totalQuestion: controller
                                              .quizListData
                                              .value
                                              .data
                                              ?.data?[index - 1]
                                              .totalQuestion ??
                                          0,
                                      totalRight: controller
                                              .quizListData
                                              .value
                                              .data
                                              ?.data?[index - 1]
                                              .totalCorrect ??
                                          0,
                                      totalWrong: controller
                                              .quizListData
                                              .value
                                              .data
                                              ?.data?[index - 1]
                                              .totalWrong ??
                                          0,
                                      totalTimeTaken: controller
                                              .quizListData
                                              .value
                                              .data
                                              ?.data?[index - 1]
                                              .timeTaken ??
                                          0,
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
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void loadMoreData() {
    if (controller.quizListData.value.data?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        controller.loadMoreQuizData();

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

/*  Widget singleCardItem({required int index}) {
    return Visibility(
      visible: true,
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: .5, color: Colors.grey))),
        child: InkWell(
          onTap: () {
            // Get.toNamed("/mcq_report_page");
            ResultDataController resultDataController =
                Get.put(ResultDataController());
            resultDataController.fetchData(
              endPoint: AppStrings.getQuizDetailsByIdEndPoint +
                  (resultListController
                          .response.value.data?[index - 1].quizId ??
                      ""),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widgetPaddingHor,
                vertical: Dimensions.widgetPaddingVer),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: Dimensions.sectionPaddingVer,),
                HeaderText(
                  text:
                      "Quiz Name: ${resultListController.response.value.data?[index - 1].chapter?.name ?? ""}",
                  color: AppColors.appSecondaryColor,
                  maxLine: 10,
                  align: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),

                SizedBox(
                  height: Dimensions.contentPaddingVer,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: AppColors.appPrimaryColor,
                                size: 16,
                              ),
                              SizedBox(
                                width: Dimensions.contentPaddingHor,
                              ),
                              HeaderText(
                                text:
                                    "Date: ${DateFormat('yyyy-MM-dd').format(resultListController.response.value.data![index - 1].quizDate!)}",
                                maxLine: 10,
                                align: TextAlign.start,
                                fontWeight: FontWeight.normal,
                                size: 14,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.ballot_outlined,
                                size: 16,
                                color: AppColors.appPrimaryColor,
                              ),
                              SizedBox(
                                width: Dimensions.contentPaddingHor,
                              ),
                              BodyText(
                                  text:
                                      "Total Questions: ${resultListController.response.value.data?[index - 1].totalQuestion ?? 0}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 16,
                                color: AppColors.appSuccessColor,
                              ),
                              SizedBox(
                                width: Dimensions.contentPaddingHor,
                              ),
                              BodyText(
                                  text:
                                      "Total Right: ${resultListController.response.value.data?[index - 1].totalCorrect ?? 0}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                size: 16,
                                color: AppColors.appErrorColor,
                              ),
                              SizedBox(
                                width: Dimensions.contentPaddingHor,
                              ),
                              BodyText(
                                  text:
                                      "Total Wrong: ${resultListController.response.value.data?[index - 1].totalWrong ?? 0}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: Dimensions.contentPaddingHor,
                              ),
                              BodyText(
                                  text:
                                      "No Answer: ${(resultListController.response.value.data?[index - 1].totalQuestion ?? 0) - (resultListController.response.value.data?[index - 1].totalCorrect ?? 0) - (resultListController.response.value.data?[index - 1].totalWrong ?? 0)}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularButton(
                            shadowColor: AppColors.appSuccessColor,
                            //width: 42,
                            //height: 42,
                            offset: Offset(0, 0),
                            callback: null,
                            child: Center(
                              child: HeaderText(
                                text: ((resultListController
                                                .response
                                                .value
                                                .data?[index - 1]
                                                .totalCorrect ??
                                            0) -
                                        ((resultListController
                                                    .response
                                                    .value
                                                    .data?[index - 1]
                                                    .totalWrong ??
                                                0) *
                                            .25))
                                    .toStringAsFixed(2),
                                size: 14,
                                color: AppColors.appSuccessColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.contentPaddingVer,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: AppColors.appPrimaryColor,
                              ),
                              Row(
                                children: [
                                  Card(
                                    color: AppColors.appPrimaryColor,
                                    //color: Colors.green.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: HeaderText(
                                        text:
                                            "${(resultListController.response.value.data?[index - 1].timeTaken ?? 0) ~/ 3600}",
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  HeaderText(text: ":"),
                                  Card(
                                    color: AppColors.appPrimaryColor,
                                    //color: Colors.green.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: HeaderText(
                                        text:
                                            "${(resultListController.response.value.data?[index - 1].timeTaken ?? 0) ~/ 60}",
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  HeaderText(text: ":"),
                                  Card(
                                    color: AppColors.appPrimaryColor,
                                    //color: Colors.green.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: HeaderText(
                                        text:
                                            "${(resultListController.response.value.data?[index - 1].timeTaken ?? 0) % 60}",
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.widgetPaddingVer,
                )
                //BodyText(text: "Time: ${testController.response.value.data?[index-1].time??0} minutes"),
              ],
            ),
          ),
        ),
      ),
    );
  }*/
}
