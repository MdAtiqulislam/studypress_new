import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/app_strings.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/mcq_report_controller.dart';
import '../../controllers/user_profile_controller.dart';
import '../../utilities/utils.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/circular_button.dart';
import '../widgets/single_result_list_item.dart';
import '../widgets/sliver_app_bar_background.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);

 final UserProfileController controller = Get.put(UserProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
         // drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 40.sp,
            //collapsedHeight: 40.sp,
            title: HeaderText(
              text: "Profile",
              color: AppColors.appHeaderTextColor,
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
          ),
          body: controller.isLoading.value
              ? const LoadingScreen()
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        //color: AppColors.appPrimaryColor,
                        height: 230,
                        child: Stack(
                          children: [
                            Container(
                                height: 200,
                                color:
                                    AppColors.appPrimaryColor.withOpacity(.3),
                                child: const SliverAppBarBackground()),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        minRadius: 40.sp,
                                        maxRadius: 40.sp,
                                        backgroundColor: AppColors.appPrimaryColor,
                                        child: Text(
                                          getInitials(controller.userData.value.data?.name ?? ""),
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.sp),
                                        ),
                                      ),

                                     /* CircleAvatar(
                                        backgroundColor: Colors.grey.shade100,
                                        minRadius: 70,
                                        maxRadius: 70,
                                        child: const CircleAvatar(
                                          maxRadius: 67,
                                          minRadius: 67,
                                          backgroundImage: AssetImage(
                                              "assets/images/man.png"),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          right: 0,
                                          child: CircularButton(
                                            width: 36,
                                            height: 36,
                                            offset: const Offset(0, 0),
                                            callback: () {},
                                            child: const Icon(Icons.camera_alt),
                                          )),*/
                                    ],
                                  ),
                                  SizedBox(width: AppDimensions.contentPaddingHor.w,),
                                  Expanded(
                                    child: HeaderText(
                                      text:
                                          controller.userData.value.data?.name ??
                                              "",
                                      align: TextAlign.start,
                                      size: 20,
                                      maxLine: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.leftPadding),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                color: AppColors.appPrimaryColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.leftPadding,
                                      vertical: AppDimensions.contentPaddingVer),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderText(
                                        text: "About",
                                        color: Colors.white,
                                      ),
                                      CircularButton(
                                          offset: const Offset(0, 0),
                                          bgColor: AppColors.appPrimaryColor,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          callback: () {
                                            Get.bottomSheet(
                                              profileUpdateForm(),
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              ignoreSafeArea: true,
                                              enterBottomSheetDuration:
                                                  const Duration(milliseconds: 700),
                                              exitBottomSheetDuration:
                                                  const Duration(milliseconds: 700),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.r),
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppDimensions.widgetPaddingVer,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Joining Date",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/calendar.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle:
                                      DateFormat('EEEE MMMM dd, yyyy').format(
                                    controller.userData.value.data?.createdAt ??
                                        DateTime.now(),
                                  ),
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              // SizedBox(
                              //   height: Dimensions.widgetPaddingVer,
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Email",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/email.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle:
                                      controller.userData.value.data?.email ??
                                          "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
/*                              SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Phone",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/contact_us.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.phone ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              /*  SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Study Level",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/progress_report.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.studyLevel ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Institute Name",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/university.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.instituteName ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              /*  SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Class",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/moc_icons/moc_icons_3.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.className ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              /* SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Department Group",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/group.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.deptGroup ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              /* SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Session",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/exam-results.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.session ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                              const Divider(),
                              /* SizedBox(
                                height: Dimensions.widgetPaddingVer,
                              ),*/
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Address",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/location.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: controller.userData.value.data
                                          ?.details?.address ??
                                      "",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),
                    ),
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
                                //height: 55,
                                color: AppColors.appPrimaryColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.leftPadding,
                                      vertical: AppDimensions.contentPaddingVer),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderText(
                                        text: "My Model Tests",
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                          .modelTestData.value.data?.length ??
                                      0,
                                  itemBuilder: (buildContext, index) {
                                    return SingleResultListItem(
                                      title:
                                          "Test Name: ${controller.modelTestData.value.data?[index]?.name ?? ""}",
                                      date: controller.modelTestData.value
                                              .data?[index]?.quizDate ??
                                          DateTime.now(),
                                      totalQuestion: controller.modelTestData
                                              .value.data?[index]?.totalQues ??
                                          0,
                                      totalRight: controller.modelTestData.value
                                              .data?[index]?.totalCorrect ??
                                          0,
                                      totalWrong: controller.modelTestData.value
                                              .data?[index]?.totalWrong ??
                                          0,
                                      totalTimeTaken: controller.modelTestData
                                              .value.data?[index]?.timeTaken ??
                                          0,
                                      callback: () {
                                        MCQReportController
                                            resultDataController =
                                            Get.put(MCQReportController());
                                        resultDataController.title.value =
                                            controller.modelTestData.value
                                                    .data?[index]?.name ??
                                                "";
                                        resultDataController.quizId.value= (controller.modelTestData.value
                                            .data?[index]?.quizId ??
                                            "");
                                        resultDataController.endPoint.value=AppStrings
                                            .getModelTestResultDetailsByIdEndPoint;
                                        resultDataController.fetchModelTestData();
                                      },
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),
                    ),
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
                                height: 55,
                                color: AppColors.appPrimaryColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.leftPadding,
                                      vertical: AppDimensions.contentPaddingVer),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderText(
                                        text: "Password",
                                        color: Colors.white,
                                      ),
                                      CircularButton(
                                          offset: const Offset(0, 0),
                                          bgColor: AppColors.appPrimaryColor,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          callback: () {
                                            Get.bottomSheet(
                                              passwordUpdateForm(),
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              ignoreSafeArea: true,
                                              enterBottomSheetDuration:
                                                  const Duration(milliseconds: 700),
                                              exitBottomSheetDuration:
                                                  const Duration(milliseconds: 700),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.r),
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.widgetPaddingHor),
                                child: BasicGridItem(
                                  imageSize: 36,
                                  gapBetween: AppDimensions.widgetPaddingVer,
                                  index: 0,
                                  title: "Password",
                                  titleTextColor: AppColors.appHeaderTextColor,
                                  image: "assets/icons/reset-password.png",
                                  bgColor: Colors.white,
                                  isGradientColour: false,
                                  subTitle: "********",
                                  subTitleTextColor: AppColors.appBodyTextColor,
                                  subTitleSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPaddingVer * 2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget profileUpdateForm() {
    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    top: AppDimensions.topPadding,
                    bottom: AppDimensions.sectionPaddingVer,
                    left: AppDimensions.leftPadding,
                    right: AppDimensions.leftPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Center(
                              child: HeaderText(text: "Update Profile"),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: CircularButton(
                                  offset: const Offset(0, 0),
                                  width: 40,
                                  height: 40,
                                  child:
                                      const Icon(Icons.keyboard_arrow_down_outlined),
                                  callback: () {
                                    Get.back();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),

                      nameTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      phoneTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      emailTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      studyLevelTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      instituteNameTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      classNameTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      departmentNameTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      sessionNameTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      addressTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),

                      AppButton(
                          shadowColor: AppColors.appPrimaryColor,
                          offset: const Offset(0, 2),
                          bgColor: AppColors.appPrimaryColor,
                          child: HeaderText(
                            text: "Submit".toUpperCase(),
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.updateProfile();
                            }
                          }),
                      //SizedBox(height: Dimensions.widgetPaddingVer,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (controller.isUpdating.value) const LoadingScreen()
        ],
      ),
    );
  }

  Widget nameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.nameController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your full name";
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Name",
            hintText: "Enter Your Name",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
          child: TextFormField(
        controller: controller.phoneController,
        validator: (value) {
          if (value!.length > 2 &&
              (value.isEmpty ||
                  !value.startsWith("0") ||
                  value[1] != "1" ||
                  value[2] == "1" ||
                  value[2] == "2" ||
                  !value.isNumericOnly ||
                  value.length < 11)) {
            return 'Please enter valid phone number';
          }
          return null;
        },
        maxLength: 11,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.phone,
        // cursorColor: AppColors.mainColorRed,
        cursorWidth: .5,
        decoration: InputDecoration(
          /* border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),*/
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appSecondaryColor),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(height: 24.h, image: const AssetImage("assets/flag.png")),
                SizedBox(
                  width: 20.w,
                ),
                HeaderText(
                  text: "+88 ",
                  align: TextAlign.start,
                  size: 18,
                )
              ],
            ),
          ),
          // labelText: "login with your phone",
          hintText: "login with your phone",
          // labelStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.red,
          hoverColor: Colors.red,
        ),
      )),
    );
  }

  Widget emailTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.emailController,
          validator: (value) {
            if (value!.isEmpty || !value.isEmail) {
              return "Please enter valid Email";
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Email",
            hintText: "example@abc.com",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget studyLevelTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.studyLevelController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Study Level",
            hintText: "Enter your study level",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget instituteNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.instituteController,
          // controller: loginEmailController.emailController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Institute name",
            hintText: "Enter your institute name",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget classNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.classNameController,
          // controller: loginEmailController.emailController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Class name",
            hintText: "Enter your class name",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget departmentNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.departmentController,
          // controller: loginEmailController.emailController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Department or Group",
            hintText: "Enter your department name",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget sessionNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.sessionController,
          // controller: loginEmailController.emailController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Session",
            hintText: "Session",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget addressTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.addressController,
          // controller: loginEmailController.emailController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          minLines: 5,
          maxLines: 10,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Address",
            hintText: "Enter your full address",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget oldPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.oldPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your old password";
            }
            return null;
          },
          obscureText: true,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "Old Password",
            hintText: "Enter your old password",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget newPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryAccentColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller.newPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your new password";
            }
            return null;
          },
          obscureText: true,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.appSecondaryColor,
          cursorWidth: .5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
            labelText: "New Password",
            hintText: "Enter your new password",
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelStyle: TextStyle(
                color: AppColors.appSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            fillColor: Colors.red,
            hoverColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget passwordUpdateForm() {
    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    top: AppDimensions.topPadding,
                    bottom: AppDimensions.sectionPaddingVer,
                    left: AppDimensions.leftPadding,
                    right: AppDimensions.leftPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Center(
                              child: HeaderText(text: "Update Password"),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: CircularButton(
                                  offset: const Offset(0, 0),
                                  width: 40,
                                  height: 40,
                                  child:
                                      const Icon(Icons.keyboard_arrow_down_outlined),
                                  callback: () {
                                    Get.back();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppDimensions.sectionPaddingVer,
                      ),
                      oldPasswordTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      newPasswordTextField(),
                      SizedBox(
                        height: AppDimensions.topPadding,
                      ),
                      AppButton(
                          shadowColor: AppColors.appPrimaryColor,
                          offset: const Offset(0, 2),
                          bgColor: AppColors.appPrimaryColor,
                          child: HeaderText(
                            text: "Submit".toUpperCase(),
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.updatePassword();
                            }
                          }),
                      SizedBox(
                        height: AppDimensions.widgetPaddingVer * 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (controller.isUpdating.value)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                color: Colors.grey.withOpacity(.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
