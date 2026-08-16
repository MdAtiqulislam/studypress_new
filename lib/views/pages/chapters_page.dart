import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/header_text.dart';
import '../../controllers/chapter_list_controller.dart';
import '../screens/loading_screen.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/category_performenceProgressChart.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({Key? key}) : super(key: key);

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  final ChapterListController chapterListController = Get.put(
    ChapterListController(),
  );

  var id = Get.arguments[0];
  var categoryId = Get.arguments[1];

  @override
  void initState() {
    // TODO: implement initState
    chapterListController.fetchChapterListData(id: id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => chapterListController.isLoading.value
            ? const Scaffold(body: LoadingScreen())
            : Scaffold(
                /*appBar: AppBar(
                centerTitle: true,
                title: HeaderText(
                  text:
                      chapterListController.response.value.chapterItem?.name ??
                          "",
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: AppColors.appSecondaryColor),
              ),*/
                drawer: MyDrawer(),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      toolbarHeight: 40.sp,
                      collapsedHeight: 40.sp,
                      iconTheme: const IconThemeData(
                        color: AppColors.appHeaderTextColor,
                      ),
                      // automaticallyImplyLeading: false,
                      pinned: true,
                      centerTitle: true,
                      floating: false,
                      snap: false,
                     // collapsedHeight: 30.sp,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: HeaderText(
                          text:
                              chapterListController
                                  .response
                                  .value
                                  .chapterItem
                                  ?.name ??
                              "",
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
                      expandedHeight: 180.sp,
                    ),
                    SliverToBoxAdapter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            chapterListController
                                .response
                                .value
                                .dataList
                                ?.length ??
                            0,
                        itemBuilder: (buildContext, index) {
                          return Visibility(
                            visible:
                                (chapterListController
                                    .response
                                    .value
                                    .dataList?[index]
                                    .chapters
                                    ?.isNotEmpty ??
                                false),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    BasicGridItem(
                                      titleTextColor:
                                          AppColors.appHeaderTextColor,
                                      // isGradientColour: false,
                                      bgColor: Colors.white,
                                      index: index,
                                      title:
                                          chapterListController
                                              .response
                                              .value
                                              .dataList?[index]
                                              .name ??
                                          "",
                                      gapBetween: 30.w,
                                      subTitle:
                                          "Total Chapters: ${chapterListController.response.value.dataList?[index].chapters?.length ?? 0}",
                                      subTitleSize: 12.sp,
                                      image:
                                          "assets/moc_icons/moc_icons_${index % 10}.png",
                                      resizeable: true,
                                    ),
                                    subChapters(index: index),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  List<TestData> getDataSource() {
    final List<TestData> dataSource = [
      TestData("Right", 33),
      TestData("Wrong", 20),
      TestData("Not Answer", 47),
    ];
    return dataSource;
  }

  Widget subChapters({required int index}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          chapterListController
              .response
              .value
              .dataList?[index]
              .chapters
              ?.length ??
          0,
      itemBuilder: (buildContext, i) {
        return Visibility(
          visible: true,
          child: InkWell(
            onTap: () {
              Get.toNamed(
                "/chapter_details_page",
                arguments: [
                  chapterListController
                      .response
                      .value
                      .dataList?[index]
                      .chapters?[i]
                      .id
                      .toString(),
                  categoryId,
                ],
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: HeaderText(
                    text:
                        chapterListController
                            .response
                            .value
                            .dataList?[index]
                            .chapters?[i]
                            .name ??
                        "",
                    color: AppColors.appHeaderTextColor,
                    maxLine: 10,
                    align: TextAlign.start,
                    fontWeight: FontWeight.normal,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: BodyText(
                    text:
                        "Previous Year Questions: ${chapterListController.response.value.dataList?[index].chapters?[i].previousTestCount ?? 0}",
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: .5, color: Colors.grey);
      },
    );
  }
}
