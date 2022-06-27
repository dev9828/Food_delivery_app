import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app_constants.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/data/controllers/recommended_product_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/cart_controller.dart';
import '../../routes/route_helper.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());// with this on new page defaylt quantity  value is 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    if(page=="cartpage"){
                      Get.toNamed(RouteHelper.cartPage);
                    }
                    else{
                      Get.toNamed(RouteHelper.getintial());
                    }
                   },
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined),
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
                        Get.find<PopularProductController>().totalItems>=1?
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
            child: Container(

              //color: Colors.white, // cannot use color here instead use in boxdecoration
              child: Center(child: BigText(size:Dimensions.font26,text: product.name!,),),
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 5,bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                )
              ),
    ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
               // "assets/image/food1.png",
                AppConstants.BASE_URl+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                    text:  product.description!
                  ),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        // can access methods of PopularProductContoller
        return Column(
          mainAxisSize: MainAxisSize.min,// find min size in the screen and fit there
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconsize24,
                        iconColor:Colors.white,
                        backgroundColor:AppColors.mainColor,icon: Icons.remove),
                  ),
                  BigText(text: "\$ ${product.price!}  X  ${controller.inCartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconsize24,
                        iconColor:Colors.white,
                        backgroundColor:AppColors.mainColor,icon: Icons.add),
                  ),
                ],
              ),
            ),
            Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
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
            ),
          ],
        );
      },)

    );
  }
}
