import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app_constants.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/data/controllers/cart_controller.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/pages/home/Main_food_page.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';

import '../../data/controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // stack used in placed of column since it give extra to pplace and control objects
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconsize24,),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      //Get.to(()=> MainFoodPage());
                      Get.toNamed(RouteHelper.getintial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconsize24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconsize24,),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child:Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding( // to remove padding given in Listview.builder
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList=cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                                height: Dimensions.height20*5,
                                width: double.maxFinite,
                                // margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        // find the index in the list which have been clicked
                                        var popularIndex=Get.find<PopularProductController>().
                                        popularProductList.indexOf(_cartList[index].product!);
                                        if(popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                        }else{
                                          var recommendedIndex=Get.find<RecommendedProductController>().
                                          recommendedProductList.indexOf(_cartList[index].product!);

                                          if(recommendedIndex<0){
                                            Get.snackbar(
                                                "History product", "Product review is not available for history product",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white);
                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.width20*5,
                                        height: Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                //"assets/image/food0.png"
                                                  AppConstants.BASE_URl+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                              )
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        ),
                                        // color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(child: // a container inside expanded widget take all available space of parent container
                                    Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                          SmallText(text: "Spicy"),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          // for calling some method from controller we need some instance so we wrap around first GetBuilder
                                                          // now we call controller we can use instance now
                                                          // popularProduct.setQuantity(false);
                                                          cartController.addItem(_cartList[index].product!, -1);

                                                        },
                                                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartList[index].quantity.toString() ),//popularProduct.inCartItems.toString()),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          // for calling some method from controller we need some instance so we wrap around first GetBuilder
                                                          // now we call controller we can use instance now
                                                          //  popularProduct.setQuantity(true);
                                                          cartController.addItem(_cartList[index].product!, 1);

                                                        },
                                                        child: Icon(Icons.add,color: AppColors.signColor,)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                )
                            );
                          });
                    },),
                  ),
                ) ):NoDataPage(text: "Your Cart is Empty!");
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.bottomheightbar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.radius20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "\$"+cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    // popularProduct.addItem(product);
                    print("tapped");
                    cartController.addToHistory();

                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.radius20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                    child: BigText(text: "Check out ",color: Colors.white,),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ):Container(),
          );
        },)
    );
  }
}
