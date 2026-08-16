import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studypress_new/views/widgets/sliver_app_bar_background.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/header_text.dart';

class CustomSliverAppBar extends StatelessWidget {

  String title;
  Widget? background;
  double? height;


   CustomSliverAppBar({
    Key? key,
    required this.title,
    this.background,
     this.height,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme:
      const IconThemeData(color: AppColors.appSecondaryColor),
      // automaticallyImplyLeading: false,
      pinned: true,
      centerTitle: true,
      floating: false,
      snap: false,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: HeaderText(
          text: title,
          maxLine: 2,
        ),
        background: background??SliverAppBarBackground(),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.appSecondaryColor,
          ),
        ),
      ],
      expandedHeight: height??200.h,
    );
  }
}
