import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/merit_list_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class MeritListPage extends StatelessWidget {
  final String title = Get.arguments[0];
  final String qId = Get.arguments[1];

  MeritListPage({Key? key}) : super(key: key);
  final MeritListController controller = Get.put(MeritListController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.qId.value = qId;
    controller.fetchData();
    _scrollController.addListener(() {
      loadMoreData();
    });
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
          child: Obx(
            () => controller.isLoading.value
                ? const LoadingScreen()
                : Stack(
                    children: [
                      CustomScrollView(
                        physics: const BouncingScrollPhysics(),
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
                            backgroundColor: Colors.white,
                            flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              title: HeaderText(
                                text: "Merit List - $title",
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
                            child: Container(
                              height: 40.h,
                              color: Colors.green.shade50,
                              child: Row(
                                // direction: Axis.horizontal,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width: 25.w,
                                      child: HeaderText(
                                        text: "SL",
                                        size: 14,
                                      )),
                                  Expanded(
                                    //flex: 5,
                                    child: HeaderText(text: "Name", size: 14),
                                  ),
                                  SizedBox(
                                      width: 60.w,
                                      child: HeaderText(
                                          text: "Correct", size: 14)),
                                  SizedBox(
                                      width: 60.w,
                                      child:
                                          HeaderText(text: "Wrong", size: 14)),
                                  SizedBox(
                                      width: 50.w,
                                      child:
                                          HeaderText(text: "Time", size: 14)),
                                  SizedBox(
                                      width: 50.w,
                                      child:
                                          HeaderText(text: "Marks", size: 14)),
                                ],
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount:
                                    controller.meritListData.length,
                                (buildContext, index) {
                              return Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.appPrimaryColor
                                            .withOpacity(.5),
                                      ),
                                    ),
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.red.shade50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 25.w,
                                        child: BodyText(
                                            text: (index + 1).toString())),
                                    Expanded(
                                        child: BodyText(
                                            text: controller.meritListData
                                                    [index].fullName ??
                                                "")),
                                    SizedBox(
                                        width: 60.w,
                                        child: BodyText(
                                            text:
                                                "${controller.meritListData[index].totalCorrect}")),
                                    SizedBox(
                                        width: 60.w,
                                        child: BodyText(
                                            text:
                                                "${controller.meritListData[index].totalWrong}")),
                                    SizedBox(
                                        width: 50.w,
                                        child: BodyText(
                                            text:
                                                "${(controller.meritListData[index].timeTaken ?? 0) ~/ 60}:${(controller.meritListData[index].timeTaken ?? 0) % 60}")),
                                    SizedBox(
                                        width: 50.w,
                                        child: BodyText(
                                            text:
                                                "${controller.meritListData[index].marksAchieved}")),
                                  ],
                                ),
                              );
                            }),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppDimensions.sectionPaddingVer,
                            ),
                          ),
                        ],
                      ),
                      if (controller.isLoadingMore.value) const LoadingScreen()
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void loadMoreData() {
    if (controller.response.value.data?.nextPageUrl != null &&
        !controller.isLoadingMore.value) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoadingMore.value = true;
        controller.loadMoreData();
      }
    }
  }
}
