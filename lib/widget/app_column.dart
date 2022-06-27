import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widget/small_text.dart';

import '../colors.dart';
import '../dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            // wrap put things in horizontal
            Wrap(children: List.generate(5, (index) => Icon(Icons.star,color:AppColors.mainColor,size: 15,)),),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "12344"),
            SizedBox(width: 10,),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // reusable widget used
            IconAndTextWidget(icon: Icons.circle_sharp, text: "Noraml", iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
          ],
        ),

      ],
    );
  }
}