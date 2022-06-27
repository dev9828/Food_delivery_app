import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print the size of screen
    print("current height "+ MediaQuery.of(context).size.height.toString());
    print("current width "+ MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          // showing header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height50),
              padding: EdgeInsets.only(left:Dimensions.height20,right: Dimensions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /////REUSABLE TEXT
                      BigText(text: "India",color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: "Gkp",color:Colors.black,),
                          Icon(Icons.arrow_drop_down_rounded,),
                          // default size of icon is 24
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search,color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // showing body
          Expanded(
            child: SingleChildScrollView(
                child: FoodPageBody()),
          ),
        ],
      )
    );
  }
}
