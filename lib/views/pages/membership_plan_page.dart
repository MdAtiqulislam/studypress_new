import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/header_text.dart';

class MemberShipPlanPage extends StatelessWidget {
  const MemberShipPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: HeaderText(text: "Pricing Plans"),
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_outlined,color: AppColors.appHeaderTextColor,))],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderText(text: "Choose the best plan to fit your needs.",),
                SizedBox(height: 40,),
                Container(
                  height: 400,
                  child: Swiper(
                    layout: SwiperLayout.DEFAULT,
                    indicatorLayout: PageIndicatorLayout.SCALE,
                    viewportFraction: .70,
                    scale: .8,
                    itemCount: 3,
                    itemBuilder: (buildContext,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Card(
                          elevation: 5,
                          shadowColor: AppColors.appSecondaryColor,
                        ),
                      );
                    },

                    pagination:  SwiperPagination(
                      margin: EdgeInsets.all(0),
                      alignment: Alignment.bottomCenter,
                      builder:  DotSwiperPaginationBuilder(
                          color: Colors.grey, activeColor: AppColors.appSecondaryColor,),
                    ),
                    /*control: new SwiperControl(
                      color: Color(0xff38547C),
                    ),*/
                    ),

                  ),
              ],
            ),
          ),
        )
        ),
    );
  }
}
