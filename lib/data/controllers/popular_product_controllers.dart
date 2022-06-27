import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/app_constants.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;// instance of repo
  // variable passes repo so that repo can pass data to controller
  // we need instance of the repo so that we call function
  PopularProductController({
    required this.popularProductRepo,
});

  List<dynamic> _popularProductList=[];// call the from here and  repo return the data and saves into list
  List<dynamic> get popularProductList=> _popularProductList;// _ in this means private variable . wu cant call directly
  // we can call this in List in UI
  late CartController _cart; // late is intialized to before use

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  int _quantity=0;
  //since this is private variable so we need to create getter method to acess
  int get quantity=>_quantity;// called arrow function
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;// this would be responsible for total item added in cart from different pages


   Future<void> getPopularProductList() async{
     // repo return response
     Response response=await popularProductRepo.getPopularProductList();// repo me .method hai use call kr rha
     // data is ready at this point , data return is in form of json
     // json data is then conveted by model. we ll create model to conert json data
     if(response.statusCode==200){
       // saves data into list
        print("got product");
       _popularProductList=[];// this list we can acces in UI anywhwere
      // Map rawData = jsonDecode(response.body);
       _popularProductList.addAll(Product.fromJson(response.body).products);// models build will be fetched here
        print(_popularProductList);
        _isLoaded=true;
       update();
     }else{


     }
   }

   // funcn for incresing and decresing quantity in cart
   void setQuantity(bool isIncrement){
     if(isIncrement){
       _quantity=checkQuantity(_quantity+1);
     }else{
       _quantity=checkQuantity(_quantity-1);
     }
     update();
   }

   // loacl scope so its get more priority than global
   int checkQuantity(int quantity){
     if((quantity+_inCartItems)<0) {
       Get.snackbar("Item Count", "You Cant reduce more !",backgroundColor: AppColors.mainColor,
           colorText: Colors.white);
       if(_inCartItems>0){
         _quantity=-_inCartItems;
         return _quantity;
       }
       return 0;}
     else if((quantity+_inCartItems)>20){
       Get.snackbar("Item Count", "You Cant add more !",backgroundColor: AppColors.mainColor,colorText: Colors.white);
       return 20;}
     else return quantity;
   }

   // check the default count of quanity is not previous one evrytime we open
   void initProduct(ProductModel product,CartController cart){
     _quantity=0;
     _inCartItems=0;
     _cart=cart;
     var exist=false;
     exist=_cart.existInCart(product);
     // if exist
     // get from storage _incartItems=3

     print("exist or not "+ exist.toString());

     if(exist){
       _inCartItems=_cart.getQuantity(product);

     }
     print(" the quantity in the cart is"+ _inCartItems.toString());

   }
   
   void addItem(ProductModel product){
       _cart.addItem(product, _quantity);
       _quantity=0; // for updating we need to set quantity =0 . so that when they update it desnot take previous added
       _inCartItems=_cart.getQuantity(product);
       _cart.items.forEach((key, value) {
         print("The id is "+ value.id.toString()+"The qantity is"+value.quantity.toString());
       });

     update();

   }

    // ******************* to show added items into cart Section
  int get totalItems{
     return _cart.totalItems;

  }
  // to return list pof models in cart

  List<CartModel> get getItems{
    return _cart.getItems;
  }


}