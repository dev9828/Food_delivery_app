import 'package:flutter/material.dart';
import 'package:food_app/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({Key? key,  this.color=const Color(0xFF332d2b),
    required this.text,
    this.size=0,
    this.overflow=TextOverflow.ellipsis// if text overflow it will print ....
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
          fontSize: size==0?Dimensions.font20: size, // taking dynamic font size according to scrren size of devcice
          fontFamily: 'RobotoMono',
      ),
    );
  }
}
