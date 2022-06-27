import 'package:flutter/cupertino.dart';
import 'package:food_app/app_constants.dart';
import 'package:get/get.dart';
// {}--->> map
//[]--->> list
// late means intialize that variable before using
class ApiClient extends GetConnect implements GetxService{
  late String token;// talking to server we need token
  final String appBaseUrl;//server url
  late Map<String,String> _mainHeaders;
  ApiClient({
    required this.appBaseUrl
}){
    baseUrl=appBaseUrl;
    timeout=Duration(seconds: 30);// how long should request should try
    token=AppConstants.TOKEN;
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',// tells server that data is send in form of json
      'Authorization': 'Bearer $token',// bearer type token for authentication
    };

  }

  /// creating get method
   Future<Response> getData(String uri,) async {
    try{
      // try calling something from server
      Response response=await get(uri); //get response from server ie. https
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
   }

}