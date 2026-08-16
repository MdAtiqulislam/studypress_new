import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import '../../controllers/iap_service_controller.dart';
import '../../controllers/my_subscription_controller.dart';
import '../../models/membership_plan_model.dart';
import '../screens/loading_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/basic_grid_item.dart';
import '../widgets/circular_button.dart';
import '../widgets/custom_sliver_app_bar.dart';
import '../widgets/my_drawer.dart';
import '../widgets/sliver_app_bar_background.dart';

class MySubscriptionsPage extends StatelessWidget {
  MySubscriptionsPage({super.key});

  final MySubscriptionController controller = Get.put(
    MySubscriptionController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Obx(
          () => Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppDimensions.sectionPaddingVer),
                  ),
                  _buildSubscriptionList(),
                  _buildComparisonTable(),
                ],
              ),
              if (controller.isUpdating.value) const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return CustomSliverAppBar(
      title: "My Subscription",
      height: 150.h,
      background: Stack(
        children: [
          const SliverAppBarBackground(),
          Positioned(
            bottom: 10,
            right: 10,
            child: CircularButton(
              callback: () {
                Get.toNamed("/enrollment_list_page");
              },
              child: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount:
              controller.myEnrollmentData.value.userEnrollment?.length ?? 0,
          (context, index) {
            final userEnrollment =
                controller.myEnrollmentData.value.userEnrollment?[index];
            final category = controller
                .myEnrollmentData
                .value
                .enrollmentCategoryList
                ?.firstWhere(
                  (cat) => cat.id == userEnrollment?.categoryId,
                  orElse: () => EnrollmentCategoryList(
                    id: 0,
                    name: "Unknown",
                    priceList: [],
                  ),
                );

            final matchedPrice = category?.priceList?.firstWhere(
              (price) => price.id == userEnrollment?.categoryPriceId,
              orElse: () => PriceList(duration: 0, price: 0),
            );

            return Card(
              margin: EdgeInsets.symmetric(
                vertical: AppDimensions.contentPaddingVer,
              ),
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeaderText(
                            text: category?.name ?? "Unknown",
                            align: TextAlign.start,
                            color: AppColors.appSecondaryColor,
                            maxLine: 3,
                          ),
                          const SizedBox(height: 5),
                          BodyText(
                            text:
                                "Membership Plan: ${userEnrollment?.subscriptionType ?? ''}",
                            align: TextAlign.start,
                          ),
                          const SizedBox(height: 2),
                          if (userEnrollment?.membershipType == 0)
                            BodyText(
                              text: "Current Package: Free",
                              align: TextAlign.start,
                              color: Colors.green,
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text:
                                      "Current Package: ৳${matchedPrice?.price ?? 0}/ ${matchedPrice?.duration ?? 0} month(s)",
                                  align: TextAlign.start,
                                  color: Colors.green,
                                ),
                                BodyText(
                                  text:
                                      "Expires on: ${userEnrollment?.subcriptionEndDate ?? ''}",
                                  align: TextAlign.start,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    AppButton(
                      bgColor: AppColors.appSecondaryColor,
                      onTap: () {
                        Get.bottomSheet(
                          Platform.isAndroid
                              ? _pricingCard(
                                  id:
                                      userEnrollment?.categoryId?.toString() ??
                                      "",
                                )
                              : _pricingCardIos(
                                  id:
                                      userEnrollment?.categoryId?.toString() ??
                                      "",
                                ),
                          clipBehavior: Clip.hardEdge,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          ignoreSafeArea: true,
                          enterBottomSheetDuration: const Duration(
                            milliseconds: 700,
                          ),
                          exitBottomSheetDuration: const Duration(
                            milliseconds: 700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                            ),
                          ),
                        );
                      },
                      offset: const Offset(0, 0),
                      child: const HeaderText(
                        text: "Change Plan",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    Widget cell(String text, {Color? color, Color? textColor}) => Container(
      height: 50,
      color: color ?? Colors.transparent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPaddingHor,
          ),
          child: BodyText(text: text, color: textColor),
        ),
      ),
    );

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
        child: Column(
          children: [
            SizedBox(height: AppDimensions.sectionPaddingVer),
            _buildRow(
              cell("Free", color: Colors.green.shade200),
              cell(
                "Premium",
                color: AppColors.appSecondaryColor,
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell("Limited Model Tests", color: Colors.green.shade50),
              cell(
                "No limits on number of model tests",
                color: AppColors.appSecondaryColor.withAlpha(204),
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell(
                "Access to Limited number of chapters",
                color: Colors.green.shade100,
              ),
              cell(
                "Full Access to all chapters",
                color: AppColors.appSecondaryColor.withAlpha(230),
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell(
                "No AI based suggestions or guidance",
                color: Colors.green.shade50,
              ),
              cell(
                "AI based directions and suggestions",
                color: AppColors.appSecondaryColor.withAlpha(204),
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell("5 Mistakes & reviews", color: Colors.green.shade100),
              cell(
                "Full mistake list and reviews",
                color: AppColors.appSecondaryColor.withAlpha(230),
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell("Contains Ads", color: Colors.green.shade50),
              cell(
                "No ads",
                color: AppColors.appSecondaryColor.withAlpha(204),
                textColor: Colors.white,
              ),
            ),
            _buildRow(
              cell("No pdf download option", color: Colors.green.shade100),
              cell(
                "Pdf download available",
                color: AppColors.appSecondaryColor.withAlpha(230),
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: AppDimensions.sectionPaddingVer),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        Expanded(child: right),
      ],
    );
  }

  /// Reusable feature builder
  Widget _buildFeature(String title) {
    return BasicGridItem(
      index: 0,
      title: title,
      resizeable: true,
      titleTextColor: AppColors.appPrimaryColor,
      titleFontWight: FontWeight.normal,
      titleTextSize: 14,
      image: "",
      isGradientColour: false,
      bgColor: Colors.transparent,
      icon: Icon(
        Icons.check_circle,
        color: AppColors.appPrimaryColor,
        size: 16.sp,
      ),
    );
  }

  /// Android Pricing Card
  Widget _pricingCard({required String id}) =>
      Obx(() => _pricingCardCommon(id: id, isIos: false));

  /// iOS Pricing Card
  Widget _pricingCardIos({required String id}) =>
      Obx(() => _pricingCardCommon(id: id, isIos: true));

  Widget _pricingCardCommon({required String id, required bool isIos}) {
    final priceList = controller.priceList[id] ?? [];
    return SizedBox(
      height: MediaQuery.of(Get.context!).orientation == Orientation.landscape
          ? Get.height * .9
          : Get.height * .8,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                Container(
                  color: AppColors.appPrimaryColor,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.leftPadding,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.widgetPaddingVer,
                          ),
                          child: const HeaderText(
                            text: "Choose your plan",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Swiper
                SizedBox(
                  height: 500.h,
                  width: Get.width, // 400.w,
                  child: Swiper(
                    layout: SwiperLayout.TINDER,
                    itemHeight: Get.height,
                    //460.h,
                    itemWidth: Get.width,
                    //400.w,
                    itemCount: priceList.length,
                    itemBuilder: (_, index) {
                      final item = priceList[index];
                      final priceText = isIos
                          ? "${item.usdPrice?.round() ?? 0}"
                          : "${item.price}";
                      final currency = isIos ? "\$" : "৳";
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                        color: Colors.green.shade200,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.leftPadding,
                            vertical: AppDimensions.topPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeaderText(
                                text: item.category?.name ?? "",
                                maxLine: 5,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch, // Row full height
                                    children: [
                                      // Currency ($) top
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          HeaderText(
                                            text: currency,
                                            size: 18,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          HeaderText(
                                            text: priceText,
                                            size: 30,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                        ],
                                      ),

                                      // Price center
                                      SizedBox(width: 8),
                                      // Duration bottom (middle with price)
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // price centered
                                        children: [
                                          HeaderText(
                                            text: "${item.duration} Month",
                                            size: 18,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                              ...[
                                "Unlimited Model Test",
                                "Full access to all chapters",
                                "AI based suggestion",
                                "Full Mistake list",
                                "Full Review List",
                                "No Ads",
                                "Pdf download",
                              ].map(_buildFeature),
                              SizedBox(height: AppDimensions.sectionPaddingVer),
                              AppButton(
                                bgColor: AppColors.appPrimaryColor,
                                offset: const Offset(0, 3),
                                child: const HeaderText(text: "Enroll Now", color: Colors.white),
                                onTap: () {

                                  if (isIos) {

                                    final iap = Get.find<IAPService>();

                                    final product = iap.getById("premium_${id}_${item.id}_${item.duration}_month");

                                    if (product != null) {
                                      iap.buy(product);
                                    } else {
                                      Get.snackbar("Error", "Product not found");
                                    }


                                    /*  final iapService = Get.put(IAPService());

                                    print(iapService.productIds);

                                    final product = iapService.getProductById("premium_${id}_${item.id}_${item.duration}_month");

                                    print(product);
                                    if (product != null) {
                                      iapService.buyProduct(product);
                                    } else {
                                      Get.snackbar("Error", "Product not found");
                                    }*/
                                  } else {
                                    // Android: Quick payment via server API
                                    controller.isUpdating.value = true;
                                    controller.quickPayment(id: item.id);
                                  }
                                },
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                    pagination: SwiperPagination(
                      margin: EdgeInsets.only(bottom: 20.h),
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: AppColors.appSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.isUpdating.value) const LoadingScreen(),
        ],
      ),
    );
  }
}
