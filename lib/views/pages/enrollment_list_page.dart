import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/header_text.dart';
import '../../controllers/enrollment_list_page_controller.dart';
import '../../utilities/show_snack_bar.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/sliver_app_bar_background.dart';

class EnrollmentListPage extends StatelessWidget {
  EnrollmentListPage({super.key});
  final EnrollmentListPageController enrollmentListPageController =
      Get.put(EnrollmentListPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                child: AppButton(
                    bgColor: AppColors.appSecondaryColor,
                    splashColor: Colors.white,
                    child: HeaderText(
                      text: "Continue",
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (enrollmentListPageController
                          .userSelected.isEmpty) {
                        CustomSnackBar(
                                msg: 'You have to select minimum one category!',
                                isWarning: true)
                            .showSnackBar();
                      } else {
                        enrollmentListPageController.saveData();

                      }
                    }),
              ),
              body: bodyContent(),
            ),
            if (enrollmentListPageController.isLoading.value) const LoadingScreen()
          ],
        ),
      ),
    );
  }

  Widget bodyContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 40.sp,
          collapsedHeight: 40.sp,
          iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
          pinned: true,
          centerTitle: true,
          expandedHeight: 180.sp,
         // collapsedHeight: 40.sp,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: HeaderText(
              text: "My Enrollments",size: 18,
              color: AppColors.appHeaderTextColor,
            ),
            background:
             Padding(
               padding: const EdgeInsets.all(20),
               child: Stack(
                 children: [
                   //Center(child: Image.asset("assets/logo2.png")),
                   const SliverAppBarBackground(),
                   Container(color: Colors.white.withOpacity(.5),),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       HeaderText(text: "Please select which exam you are preparing For.",maxLine: 5,align: TextAlign.start,color: AppColors.appHeaderTextColor,),
                       SizedBox(height: 10.h,),
                       BodyText(text: "You can select maximum two categories",align: TextAlign.start,),
                     ],
                   ),
                 ],
               ),
             ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: enrollmentListPageController
                      .response.value.data?.categoryList?.length ??
                  0,
              itemBuilder: (buildContext, index) {
                return Obx(
                  () => Card(
                    shadowColor: AppColors.appSecondaryColor,
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedContainer(
                      padding: enrollmentListPageController.userSelected
                              .contains(enrollmentListPageController.response
                                  .value.data!.categoryList![index].value)
                          ? EdgeInsets.all(5.r)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(10),),
                        color: enrollmentListPageController.userSelected
                                .contains(enrollmentListPageController.response
                                    .value.data!.categoryList![index].value)
                            ? AppColors.appSecondaryColor.withOpacity(.1)
                            : Colors.white,
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                        activeColor: AppColors.appPrimaryHeaderColor,
                        value: enrollmentListPageController.userSelected.contains(enrollmentListPageController.response
                                .value.data!.categoryList![index].value),
                        onChanged: (bool? value) {
                          enrollmentListPageController.onSelectedItems(
                              value!,
                              enrollmentListPageController.response.value.data!
                                  .categoryList![index].value!);
                        },
                        title: HeaderText(
                          text: enrollmentListPageController.response.value.data
                                  ?.categoryList?[index].text ??
                              "",
                          color: enrollmentListPageController.userSelected.contains(enrollmentListPageController
                                      .response
                                      .value
                                      .data!
                                      .categoryList![index]
                                      .value)
                              ? AppColors.appPrimaryHeaderColor
                              : AppColors.appHeaderTextColor,
                          align: TextAlign.start,
                          fontWeight: enrollmentListPageController
                                  .userSelected
                                  .contains(enrollmentListPageController
                                      .response
                                      .value
                                      .data!
                                      .categoryList![index]
                                      .value)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          maxLine: 2,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
