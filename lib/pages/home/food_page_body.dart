import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app_constants.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/data/controllers/popular_product_controllers.dart';
import 'package:food_app/data/controllers/recommended_product_controller.dart';
import 'package:food_app/data/repository/recommended_product_repo.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/widget/app_column.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_and_text_widget.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController=PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;// 80% of originial size showing
  // to show left and right of scroll view
  double _height=Dimensions.pageViewContainer;
  @override
  void initState() {
    pageController.addListener(() {setState(() {
      _currPageValue=pageController.page!;
      // to print the fraction of page as we scroll to left or right
      //print("CurrentPage Value is "+ _currPageValue.toString());
    });});
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        // getBuilder method wrap in container to show dATA from server in UI through controller
        //GETBUILDER connects popularProducts which is list to UI**********************
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded?Container(
            // popularProducts List is instance of this container so we can use any methid inside
            //color: Colors.redAccent,
            height: Dimensions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  //itemCount: 5,// postion start from 0 and goes to 4
                  itemCount: popularProducts.popularProductList.length, /// since in api it shows 6 length ,now itll have 6 sliders
                  itemBuilder: (context,position){
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }),
          ):CircularProgressIndicator(
            color: AppColors.mainColor  ,
          );
        }),

          /////// SINCE DOTS INDICATOR WAS IN SYNCHRONOUS WITH SLIDER SO WE DO THE SAME WRAP IN GETBUILDER
          GetBuilder<PopularProductController>(builder: (popularProducts){
            return  DotsIndicator(
              // since data from takes time to load
              dotsCount: popularProducts.popularProductList.length<=0?1:popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },),
        //Popular Text
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recoomended"),
              // for recommended food we have to ceate new controoler
              // and controller should have its own repo
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food paring"),
              ),
            ],
          ),
        ),

        // List of food and images
//////////////RECOMEENDED FOOD****************************
        // since by default Listview require height and column parent class doesnt have height
        // so we wrap Listview around container and give height
         GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
           return recommendedProduct.isLoaded?ListView.builder(
             physics: NeverScrollableScrollPhysics(),// to scroll whole page
             shrinkWrap: true,
             itemCount: recommendedProduct.recommendedProductList.length,
             itemBuilder: (context, index) => GestureDetector(
               onTap: (){
                 Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
               },
               child: Container(
                 margin: EdgeInsets.only(left:Dimensions.width15, right: Dimensions.width20,bottom: Dimensions.height10),
                 child: Row(
                   children: [
                     // image section
                     Container(
                       width: Dimensions.listViewImgSize,
                       height: Dimensions.listViewImgSize,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimensions.radius20),
                         color: Colors.white38,
                         image: DecorationImage(
                             fit: BoxFit.cover,
                             image: NetworkImage(
                                 //"assets/image/food2.png"
                                 AppConstants.BASE_URl+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                             )),
                       ),
                     ),
                     // text Section
                     Expanded(
                       child: Container(
                           height: Dimensions.listViewTextContSize,
                           //width: 200,// expanded will fill all space
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.only(
                               topRight: Radius.circular(Dimensions.radius20),
                               bottomRight: Radius.circular(Dimensions.radius20),
                             ),
                             color: Colors.white,
                           ),
                           child: Padding(
                             padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                 SizedBox(height: Dimensions.height10,),
                                 SmallText(text: "With chinese characterstics"),
                                 SizedBox(height: Dimensions.height10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     // reusable widget used
                                     IconAndTextWidget(icon: Icons.circle_sharp, text: "Noraml", iconColor: AppColors.iconColor1),
                                     IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
                                     IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
                                   ],
                                 ),
                               ],
                             ),
                           )
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ):CircularProgressIndicator(color: AppColors.mainColor,);
         })
      ]
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){

    Matrix4 matrix=new Matrix4.identity();// it has 3 coordinates , x ,y,z
    // to move main page up while scrooling ,the movement
    //// API matrix 4 for x,y,z
    if(index==_currPageValue.floor()){
      var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index==_currPageValue.floor()+1){
      var currScale=_scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      // after doing we need to wrap that widget with TRANSFORM............................
    }
    else if(index==_currPageValue.floor()-1){
      var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      // after doing we need to wrap that widget with TRANSFORM............................
    }
    else{
      var currScale=0.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2,1 );

    }


    return Transform(
      transform: matrix,// to see changes in coordinates while scolling
      child: Stack(
        children: [
        GestureDetector(
          onTap: (){
            //Get.to(()=>PopularFoodDetail());
            Get.toNamed(RouteHelper.getPopularFood(index,"home"));
          },
          child: Container(
          //child container takes the whole height of parent container
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(left: 10,right:10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven? Color(0xFF69c5df): Color(0xFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      //"assets/image/food1.png"
                    AppConstants.BASE_URl+AppConstants.UPLOAD_URL+popularProduct.img! // images from api server
                  )
              )
          ),
      ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              //child container takes the whole height of parent container
              height: 120,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                boxShadow: [
                  // shadow on every side
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0),
                  ),
                ]

              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
                child: AppColumn(
                  text: popularProduct.name!, // name updating from server

                )
              ),
            ),
          ),

        ],
      ),
    );
  }
}
