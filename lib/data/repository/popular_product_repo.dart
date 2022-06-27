import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:get/get.dart';
// since to load data from server required internet service ie why extends GetxService
class PopularProductRepo extends GetxService{
   final ApiClient apiClient;// repository acess to api client
   PopularProductRepo({
     required this.apiClient
});

   // sends response from the server from method getPopularProductList
  Future<Response> getPopularProductList() async{
    // call the api from apiclient to return response got from server
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    // after getting data from the server , repository will send data back to controller
    // create a controller

  }
}