


// for recommended food we have to ceate new controoler
// and controller should have its own repo


//and we need to load them as dependencies in our project file
// load them in dependencies



import 'dart:convert';

import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

import '../repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;// instance of repo
  // variable passes repo so that repo can pass data to controller
  // we need instance of the repo so that we call function
  RecommendedProductController({
    required this.recommendedProductRepo,
  });

  List<dynamic> _recommendedProductList=[];// call the from here and  repo return the data and saves into list
  List<dynamic> get recommendedProductList=> _recommendedProductList;// _ in this means private variable . wu cant call directly
  // we can call this in List in UI

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  Future<void> getRecommendedProductList() async{
    // repo return response
    Response response=await recommendedProductRepo.getRecommendedProductList();// repo me .method hai use call kr rha
    // data is ready at this point , data return is in form of json
    // json data is then conveted by model. we ll create model to conert json data
    if(response.statusCode==200){
      // saves data into list
      print("got product recommended");
      _recommendedProductList=[];// this list we can acces in UI anywhwere
      // Map rawData = jsonDecode(response.body);
      _recommendedProductList.addAll(Product.fromJson(response.body).products);// models build will be fetched here
      print(_recommendedProductList);
      _isLoaded=true;
      update();
    }else{

      print("could not got product recommended");
    }
  }
}