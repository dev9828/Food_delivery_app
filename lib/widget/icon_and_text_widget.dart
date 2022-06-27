// building reusable widget for icon and text as a paramter

import 'package:flutter/cupertino.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/widget/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,),
        SizedBox(width: 0,),
        SmallText(text: text),
      ],
    );
  }
}
