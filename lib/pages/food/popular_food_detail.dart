import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app_constants.dart';
import 'package:food_app/data/controllers/cart_controller.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/pages/home/Main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/widget/app_column.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../colors.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text_widget.dart';
import '../../widget/small_text.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
   PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];// match index with list with contoller
    //print("page id is"+pageId.toString());
    //print("product name is "+product.name.toString());
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());// with this on new page defaylt quantity  value is 0;
    // PopularProductController will call CartController
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image:DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(
                         // "assets/image/food3.png"
                        AppConstants.BASE_URl+AppConstants.UPLOAD_URL+product.img!
                      ),
                  ),

                ),

          )),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                GestureDetector(
                    onTap:(){
                     // Get.to(()=>MainFoodPage());
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.cartPage);
                      }
                      else{
                        Get.toNamed(RouteHelper.getintial());
                      }
                    },
                  child: AppIcon(icon: Icons.arrow_back_ios,)),
                  // GestureDetector(
                  //     onTap:(){
                  //       Get.to(()=>MainFoodPage());
                  //     },

                GetBuilder<PopularProductController>(builder: (contoller){
                  return GestureDetector(
                    onTap: (){
                      if(contoller.totalItems>=1){
                        Get.toNamed(RouteHelper.getCartPage());
                      }

                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        // for conditional check if qnuantuty is >0 we call
                        // to get mthods of Popularfoodcontoller to use in here
                        // DYNAMIC
                        contoller.totalItems>=1?
                        Positioned(
                          right:0,top:0,
                            child: AppIcon(icon: Icons.circle,size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,),

                        ):
                        Container(),

                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:3,top:3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size:12,color: Colors.white,),
                        ):
                        Container(),
                      ],
                    ),
                  );
                },)

            ],
          )),
          //intoductions of widgets
          Positioned(
            left: 0,right: 0,bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
               padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    // Expandable
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text:  product.description!)))
                  ],
                )// reusable Widget
          )),
          
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
          child: Row(
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
                    GestureDetector(
                        onTap: (){
                          // for calling some method from controller we need some instance so we wrap around first GetBuilder
                          // now we call controller we can use instance now
                          popularProduct.setQuantity(false);

                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          // for calling some method from controller we need some instance so we wrap around first GetBuilder
                          // now we call controller we can use instance now
                          popularProduct.setQuantity(true);

                        },
                        child: Icon(Icons.add,color: AppColors.signColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.radius20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                      child: BigText(text: "\$ ${product.price!} | Add to Cart",color: Colors.white,),
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
