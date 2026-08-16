import 'package:flutter/material.dart';
import '../../constraints/app_colors.dart';

class CircularButton extends StatelessWidget {
  double blurRadius;
  Widget child;
  VoidCallback? callback;
  Offset? offset;
  Color? bgColor;
  Color? shadowColor;
  double width;
  double height;
  Color splashColor;
  double shadowOpacity;
  BoxShape shape;

  CircularButton({
    Key? key,
    this.bgColor,
    this.splashColor = AppColors.appSecondaryColor,
    required this.child,
    this.shadowColor = AppColors.appSecondaryColor,
    required this.callback,
   // this.offset = const Offset(-3, 10),
    this.offset = const Offset(0, 3),
    this.blurRadius = 5,
    this.width = 45,
    this.height = 45,
    this.shadowOpacity=.5,
    this.shape=BoxShape.circle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration:
      BoxDecoration(
          shape: shape,
          color: bgColor??Colors.white, boxShadow: [
        BoxShadow(
            color: shadowColor!.withOpacity(shadowOpacity),
            spreadRadius: 0,
            blurRadius: blurRadius,
            offset: offset! // changes position of shadow
            ),
      ]),
      child: Material(
        color: bgColor,
        child: InkWell(
          onTap: callback,
          splashColor: splashColor,
          child: child,
        ),
      ),
    );
  }
}
