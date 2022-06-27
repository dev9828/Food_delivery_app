// for recommended food we have to ceate new controoler
// and controller should have its own repo



import 'package:food_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../app_constants.dart';
// since to load data from server required internet service ie why extends GetxService
class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;// repository acess to api client
  RecommendedProductRepo({
    required this.apiClient
  });

  // sends response from the server from method getPopularProductList
  Future<Response> getRecommendedProductList() async{
    // call the api from apiclient to return response got from server
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
    // after getting data from the server , repository will send data back to controller
    // create a controller

  }
}