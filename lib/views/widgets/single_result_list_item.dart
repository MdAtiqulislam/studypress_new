import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import 'circular_button.dart';



class SingleResultListItem extends StatelessWidget {
  VoidCallback? callback;
  String title;
  DateTime date;
  int totalQuestion;
  int totalRight;
  int totalWrong;
  int totalTimeTaken;
  SingleResultListItem(
      {super.key,
      this.callback,
      required this.title,
      required this.date,
      required this.totalQuestion,
      required this.totalRight,
      required this.totalWrong,
      required this.totalTimeTaken});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: .5, color: Colors.grey),),),
      child: InkWell(
        onTap:callback,/* () {
          // Get.toNamed("/mcq_report_page");
          ResultDataController resultDataController =
          Get.put(ResultDataController());
          resultDataController.fetchData(
            endPoint: AppStrings.getQuizDetailsByIdEndPoint +
                (resultListController
                    .response.value.data?[index - 1].quizId ??
                    ""),
          );
        },*/
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.widgetPaddingHor,
              vertical: AppDimensions.widgetPaddingVer),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: Dimensions.sectionPaddingVer,),
              HeaderText(
                text: title,

                //"Quiz Name: ${resultListController.response.value.data?[index - 1].chapter?.name ?? ""}",
                color: AppColors.appSecondaryColor,
                maxLine: 10,
                align: TextAlign.start,
                fontWeight: FontWeight.bold,
                size: 20,
              ),

              SizedBox(
                height: AppDimensions.contentPaddingVer,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           Icon(
                            Icons.date_range_outlined,
                            color: AppColors.appPrimaryColor,
                            size: 16.sp,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPaddingHor,
                          ),
                          HeaderText(
                            text:
                                "Date: ${DateFormat('yyyy-MM-dd').format(date)}",
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
                            size: 16.sp,
                            color: AppColors.appPrimaryColor,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPaddingHor,
                          ),
                          BodyText(text: "Total Questions: $totalQuestion"),
                        ],
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.check_circle_outline,
                            size: 16.sp,
                            color: AppColors.appSuccessColor,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPaddingHor,
                          ),
                          BodyText(text: "Total Right: $totalRight"),
                        ],
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.cancel_outlined,
                            size: 16.sp,
                            color: AppColors.appErrorColor,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPaddingHor,
                          ),
                          BodyText(text: "Total Wrong: $totalWrong"),
                        ],
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.circle_outlined,
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPaddingHor,
                          ),
                          BodyText(
                              text:
                                  "No Answer: ${totalQuestion - (totalRight + totalWrong)}"),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularButton(
                          shadowColor: AppColors.appSuccessColor,
                          width: 60.sp,
                          height: 60.sp,
                          offset: const Offset(0, 0),
                          callback: null,
                          child: Center(
                            child: HeaderText(
                              text: (totalRight - (totalWrong * .25))
                                  .toStringAsFixed(2),
                              size: 14,
                              color: AppColors.appSuccessColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppDimensions.contentPaddingVer,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.appPrimaryColor,
                              size: 16.sp,
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
                                          "${totalTimeTaken ~/ 3600}",
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
                                          "${totalTimeTaken ~/ 60}",
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
                                          "${totalTimeTaken % 60}",
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppDimensions.widgetPaddingVer,
              )
              //BodyText(text: "Time: ${testController.response.value.data?[index-1].time??0} minutes"),
            ],
          ),
        ),
      ),
    );
  }
}
