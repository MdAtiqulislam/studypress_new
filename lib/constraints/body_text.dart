import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;
  final bool resizeable;
  final double size;
  final int maxLine;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  const BodyText({super.key,
    required this.text,
    this.color=const Color(0xff4A4063),
    this.size=12,
    this.textOverflow=TextOverflow.ellipsis,
    this.fontWeight=FontWeight.normal,
    this.align=TextAlign.center,
    this.maxLine=3,
    this.resizeable=true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: resizeable?size.sp:size,
        fontWeight: fontWeight,
      ),
    );
  }
}