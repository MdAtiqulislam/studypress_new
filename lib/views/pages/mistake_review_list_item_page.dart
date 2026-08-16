import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mistake_and_review_list_item_page_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/empty_card.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class MistakeAndReviewListItemPage extends StatelessWidget {
  MistakeAndReviewListItemPage({super.key});
  final MistakeAndReviewController controller =
      Get.put(MistakeAndReviewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          drawer: MyDrawer(),
          body: controller.isLoading.value
              ? const LoadingScreen()
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
                          text: controller.title.value ,
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



                    if ((controller.categoryList.value.data?.isEmpty ?? true) &&
                        !(controller.categoryList.value.hasCurrentAffairs ??
                            false))
                      SliverToBoxAdapter(
                          child: EmptyCard(title: "Your List is Empty")),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.leftPadding,
                            vertical: AppDimensions.bottomPadding),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                          elevation: 5,
                          shadowColor:
                              AppColors.appSecondaryColor.withOpacity(.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if(controller.categoryList.value.data?.isNotEmpty??true)BasicGridItem(
                                index: 0,
                                title: "Please Select One",
                                image: "assets/moc_icons/moc_icons_1.png",
                                gapBetween: 30.w,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: (controller
                                        .categoryList.value.data?.length ??
                                    0),
                                itemBuilder: (buildContext, index) {
                                  //  print("controller.enrollmentData.value.enrollmentCategoryList?.length??0");
                                  return Obx(
                                    () => Padding(
                                      padding: EdgeInsets.all(5.r),
                                      child: BasicGridItem(
                                        callback: () {
                                          controller.isCurrentWorld.value =
                                              false;
                                          controller.openPage(index: index);
                                        },
                                        index: index,
                                        isGradientColour: false,
                                        bgColor: Colors.transparent,
                                        titleTextColor:
                                            AppColors.appHeaderTextColor,
                                        titleFontWight: FontWeight.normal,
                                        title: controller.categoryList.value
                                                .data?[index].name ??
                                            "",
                                        image:
                                            "assets/moc_icons/moc_icons_${index % 10}.png",
                                        //height: 40,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    height: .5,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                              if(controller.categoryList.value.data?.isNotEmpty??true)Container(
                                height: .5,
                                color: Colors.grey,
                              ),
                              if(controller.categoryList.value.hasCurrentAffairs??false)Padding(
                                padding:  EdgeInsets.all(5.r),
                                child: BasicGridItem(
                                  index: 1,
                                  isGradientColour: false,
                                  bgColor: Colors.transparent,
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  titleFontWight: FontWeight.normal,
                                  title: "Current World",
                                  image: "assets/moc_icons/moc_icons_${5 % 10}.png",
                                  callback: () {
                                    controller
                                            .isCurrentWorld
                                            .value = true;
                                        controller.openPage(
                                            index: 315);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
