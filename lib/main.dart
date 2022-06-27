import 'package:flutter/material.dart';
import 'package:food_app/data/controllers/cart_controller.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_detail.dart';
import 'package:food_app/pages/home/Main_food_page.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'data/controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  // before try to load our app try to load dependencies
  WidgetsFlutterBinding.ensureInitialized();// it will make sure that dependencies are loaded correctly
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     // everytime we have to call here if we want data from server
    //Get.find<PopularProductController>().getPopularProductList();
    // Get.find<PopularProductController>().getPopularProductList();// token should be intialized in api.client
    // Get.find<RecommendedProductController>().getRecommendedProductList();// call for recommended product
    // call the request from server and then after it gets it will saves in the list, then you have to show in the ui
    // we have to find controller in UI to get acess of list in UI from server

    Get.find<CartController>().getCartData(); // call for setter of data into local database
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      },);
    },);
  }
}

///// since differnt devices have differtent size ,
// since we are hardcoding height , row,column size.
// which might effect other evice if we run ,
// so we want everything dyNAMIC, IE, IT TAKES VALUES OF HARDCODED VALUE ACCORDING TO DEVICE


