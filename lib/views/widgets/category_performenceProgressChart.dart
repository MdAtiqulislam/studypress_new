
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studypress_new/views/widgets/score_time_line.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/home_page_data_controller.dart';
import 'app_button.dart';



class CategoryPerformanceProgressCart extends StatefulWidget {
 //final List<CategoryPerformancesProgress> data;

 const CategoryPerformanceProgressCart({/*required this.data, */super.key});

  @override
  State<CategoryPerformanceProgressCart> createState() =>
      _CategoryPerformanceProgressCartState();
}

class _CategoryPerformanceProgressCartState
    extends State<CategoryPerformanceProgressCart> {
  //late List<TestData> _dataSource;


  @override
  void initState() {
    // TODO: implement initState
/*   if(widget.data.isNotEmpty) {
     _dataSource = getDataSource(index: 0);
   }*/
    super.initState();
  }

  HomePageDataController homePageController = Get.put(HomePageDataController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? 350.h
            : 180.w,
        child: Swiper(
                loop: false,
                itemCount: homePageController.enrolledGrades.length,//homePageController.dashBoardData.value.userGrades?.length??0,
                /*onIndexChanged: (index){
                  _dataSource=getDataSource(index:index);
                },*/
                itemBuilder: (buildContext, index) {
                  return Card(
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HeaderText(text: "Performance: ${homePageController.enrolledGrades[index].categoryName}"),
                        SizedBox(height: AppDimensions.sectionPaddingVer.h,),
                        ScoreTimeLine(
                            score: homePageController.enrolledGrades[index].score??0
                           // score:0
                        ),
                        SizedBox(height: AppDimensions.widgetPaddingVer,),
                        (homePageController.enrolledGrades[index].inEnrollment??false)
                            ?AppButton(
                            bgColor: AppColors.appPrimaryColor,
                            onTap: (){
                              Get.toNamed("/subject_list_page",
                                  arguments: [
                                  homePageController.enrolledGrades[index].categoryId.toString()
                                  ]);
                            },
                            child: HeaderText(text: "Start Learning",color: Colors.white,))
                            :AppButton(
                          shadowColor: Colors.grey.withOpacity(.5),
                            bgColor: Colors.grey,
                            onTap: null,
                            child: HeaderText(text: "Not Enrolled",color: Colors.white,))

                      ],
                    ),
                  );
                },
                pagination:  const SwiperPagination(
                  builder:  DotSwiperPaginationBuilder(
                      color: Colors.grey,
                      activeColor: AppColors.appPrimaryColor),
                ),
                // loop: false,
              )



/*            : Card(
                child: Stack(
                  children: [
                    const SliverAppBarBackground(),
                    Center(
                      child: HeaderText(
                        text:AppStrings.performanceMessage,
                        maxLine: 5,
                      ),
                    )
                  ],
                ),
              )*/
        );
  }

/*  Widget chart(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: Get.width*.5,
          height: 280,
          child: SfCircularChart(
            title: ChartTitle(text: "Performance"),
            margin: EdgeInsets.zero,
            enableMultiSelection: true,
            legend: Legend(
                height: "150",
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.bottom

            ),
            series: <CircularSeries< TestData, String>>[
              DoughnutSeries<TestData,String>(
                //maximumValue: 100,
                // enableTooltip: true,
                //radius: "100",
                // strokeWidth: 49,
                  dataSource: _dataSource,
                  xValueMapper: (TestData _,__)=>_.title,
                  yValueMapper: (TestData _,__)=>_.value,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.inside,
                    // alignment: ChartAlignment.near
                  )

              )],
          ),
        ),
        Container(
          // color: Colors.blue,
          width: Get.width*.5,
          height: 280,
          child: SfCircularChart(
            title: ChartTitle(text: "Progress"),
            margin: EdgeInsets.zero,
            enableMultiSelection: true,
            legend: Legend(
                height: "150",
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.bottom

            ),
            series: <CircularSeries< TestData, String>>[
              DoughnutSeries<TestData,String>(
                //maximumValue: 100,
                // enableTooltip: true,
                //radius: "100",
                // strokeWidth: 49,
                  dataSource: _dataSource,
                  xValueMapper: (TestData _,__)=>_.title,
                  yValueMapper: (TestData _,__)=>_.value,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.inside,
                    // alignment: ChartAlignment.near
                  )

              )],
          ),
        ),
      ],
    );
  }*/

/*  List<TestData> getDataSource({required int index}) {
    final List<TestData> dataSource = [];
   if((widget.data[index].subjectPerformances??[]).isNotEmpty){
     widget.data[index].subjectPerformances?.forEach((element) {
       dataSource
           .add(TestData(element.subject?.name ?? "", element.performance ?? 0));
     });
   }

    return dataSource;
  }

  List<TestData> getDataSource_2() {
    final List<TestData> dataSource = [
      TestData("01/11/22", 30),
      TestData("02/11/22", 70),
      TestData("03/11/22", 30),
      TestData("04/11/22", 7),
      TestData("05/11/22", 55),
      TestData("06/11/22", 65),
      TestData("07/11/22", 85),
      TestData("08/11/22", 0),
      TestData("09/11/22", 44),
      TestData("10/11/22", 50),
      TestData("11/11/22", 80),
      TestData("12/11/22", 99),
      TestData("13/11/22", 69),
      TestData("14/11/22", 0),
      TestData("15/11/22", 90),
      TestData("16/11/22", 99),
    ];
    return dataSource;
  }*/
}

class TestData {
  String title;
  int value;

  TestData(this.title, this.value);
}
