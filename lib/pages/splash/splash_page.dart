import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/popular_product_controllers.dart';
import '../../data/controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation <double> animation;
 late  AnimationController controller;

 Future<void> _loadResource() async {

   // everytime we have to call here if we want data from server
   //Get.find<PopularProductController>().getPopularProductList();
   await Get.find<PopularProductController>().getPopularProductList();// token should be intialized in api.client
   await Get.find<RecommendedProductController>().getRecommendedProductList();// call for recommended product
   // call the request from server and then after it gets it will saves in the list, then you have to show in the ui
   // we have to find controller in UI to get acess of list in UI from server
 }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResource();
    controller=new AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    //controller=controller.forward(); ==== ...forward()
    animation=new CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
        const Duration(seconds:3),
        ()=>Get.offNamed(RouteHelper.getintial()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/logo 1.jpeg",width: Dimensions.splashImg,))),
           //Center(child: Image.asset("assets/image/logo 1.jpeg",width: 250,))

        ],
      ),
    );
  }
}
