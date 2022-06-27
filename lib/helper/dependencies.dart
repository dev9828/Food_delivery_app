
// first we craete init method then we careate class for api client. well call this class in init method
import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/controllers/cart_controller.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';
// all the controller should be loaded in dependencies

Future<void> init()async {

  final sharedPreferences=await SharedPreferences.getInstance();// local history of data in phone

  Get.lazyPut(() => sharedPreferences);

   // load the dependencies ie: apiclient,repository,controllers
  // ****************1. first load apiclient *************
   Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URl));

   // ***************2. LOAD REPOSITORY************
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));// Get.find will apiclient
   Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
   Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  /// ***************3. LOAD CONTROLLER************
   Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
   Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
   Get.lazyPut(() => CartController(cartRepo: Get.find()));
}

///////// intit() mathod is called from main.dart  ******************************