import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/subject_list_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class SubjectListPage extends StatelessWidget {
 final String categoryId = Get.arguments[0];

  SubjectListPage({Key? key}) : super(key: key);

  final SubjectListController controller =
  Get.put(SubjectListController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Obx(() => Scaffold(
        drawer: MyDrawer(),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 40.sp,
                  collapsedHeight: 40.sp,
                  iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
                  // automaticallyImplyLeading: false,
                  pinned: true,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                 // collapsedHeight: 30.sp,
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
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: HeaderText(
                      text: "Study Material",
                      color: AppColors.appHeaderTextColor,
                    ),
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      children: const [
                       SliverAppBarBackground(),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.leftPadding,
                      vertical: AppDimensions.bottomPadding),
                    child:Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r),),),
                      elevation: 5,
                      shadowColor:
                      AppColors.appSecondaryColor.withOpacity(.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          BasicGridItem(
                              index: 0,
                              title: controller.response.value.subjectItem?.name??"",
                              image: "assets/moc_icons/moc_icons_1.png",
                            gapBetween: 30.w,
                            resizeable: true,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.response.value.dataList?.length??0,
                            itemBuilder: (buildContext, index) {
                              return Padding(
                                padding:  EdgeInsets.all(5.r),
                                child: BasicGridItem(
                                  callback: (){
                                    Get.toNamed("/chapters_page",
                                        arguments: [controller.response.value.dataList?[index].id.toString(),categoryId]);
                                  },
                                  index: index,
                                  isGradientColour: false,
                                  bgColor: Colors.transparent,
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  titleFontWight: FontWeight.normal,
                                  title: controller.response.value.dataList?[index].name??"",
                                  image: "assets/moc_icons/moc_icons_${index%10}.png",
                                  resizeable: true,
                                  //titleTextSize: 10,

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
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            if(controller.isLoading.value)const LoadingScreen()
          ],
        ),
      ),),
    );
  }
}
