import 'package:flutter/material.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  // everytime we click on button then key value pair is saved on map
  // since we dont have any integer in product model
  // therefore creat CartModel
  Map<int,CartModel> _items={};
  Map<int,CartModel> get items=>_items;

  void addItem(ProductModel product, int quantity){
    var totalQuantity=0;
    print("length of item is"+ _items.length.toString());
    // int -> referenced to id &&& CartModel -> referenced to CartModel
    if(_items.containsKey(product.id!)){ // to update if added and then want to update and change the quantity
      _items.update(product.id!, (value)  {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          //this.description,
          price: value.price,
          //this.stars,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else{ // added to list first time
      if(quantity>0){
        _items.putIfAbsent(product.id!,()
        {
          // print("Adding Item to the cart id" + product.id!.toString() + "quantity" +
          //     quantity.toString());
          // _items.forEach((key, value) {
          //   print("quantity is "+ value.quantity.toString());
          // });
          return CartModel(
            id: product.id,
            name: product.name,
            //this.description,
            price: product.price,
            //this.stars,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,

          );
        });
      }
      else{
        Get.snackbar(
            "Item Count", "You should atleast add an item in the cart!",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
     update();
  }


  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }

  //****************** get total cart added items and show in cart section *******************
   int get totalItems{ // getter doesnot return funcn it return fields ()--> not needed
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity+=value.quantity!;
    });
    return totalQuantity;
   }

      // to return list of models in cart ie return CartModel from map instead of key

      List<CartModel> get getItems{
    // e-> 0,1,2,3,..... from map key value
       return  _items.entries.map((e) {
          return e.value;
        }).toList();
      }


      //// to Add totalamount of products in cart list
      int get totalAmount{
       var total=0;
      _items.forEach((key, value) {
        total+=value.quantity!*value.price!;// rotal of 1 all item
      });

    return 0;
      }

      List<CartModel> storageItems=[];

  // this is called when our app first time open, it chceks if something there previously
      List<CartModel> getCartData(){

         setCart=cartRepo.getCartList();
        return storageItems;
      }

      // with get we have to return something
  // with set we have to accept something
      set setCart(List<CartModel> items){
        storageItems=items;
        for(int i=0;i<storageItems.length;i++){
          _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
        }
      }

      void addToHistory(){
        cartRepo.addToCartHistoryList();
        clear();
      }

      void clear(){
        _items={};
        update();
      }

      // methods to design data inside local database
      List<CartModel> getCartHistoryList(){
        return cartRepo.getCartHistoryList();
      }

      set setitems(Map<int,CartModel> setItems){
        _items={};
        _items=setItems;
      }

      void addToCartList(){
        cartRepo.addToCartList(getItems);
        update();
      }

}