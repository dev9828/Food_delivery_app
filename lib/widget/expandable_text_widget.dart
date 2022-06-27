import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/widget/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;// using late coz intializing them later
  // intialize before using
  late String secondHalf;

  bool hiddenText=true;
  double textHeigh=Dimensions.screenHeight/6;

  @override
  void initState() {
    // TODO: implement initState
    // to check length of text
    if(widget.text.length>textHeigh){
      firstHalf=widget.text.substring(0,textHeigh.toInt());
      secondHalf=widget.text.substring(textHeigh.toInt()+1,widget.text.length);
    }else{// if text is not that too long
      firstHalf=widget.text;
      secondHalf="";// intialized coz late


    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color:AppColors.paraColor,size:Dimensions.font16,text: firstHalf):Column(
        children: [

          SmallText(height:1.8,color:AppColors.paraColor,size:Dimensions.font16,text: hiddenText?(firstHalf+"...."): (firstHalf+secondHalf)),
          InkWell(
            onTap: (){
                setState(() {
                  hiddenText=!hiddenText;
                });
            },
            child: Row(
              children: [
                SmallText(text: "Show more",color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down: Icons.arrow_drop_up,color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
