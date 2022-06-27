import 'package:get/get.dart';

// to make our app responsive
// to use this we need to change our matrialApp Widget to GetMaterialApp
class Dimensions{
  static double screenHeight=Get.context!.height;// acess the height of device
   static double screenWidth=Get.context!.width;
//784/220=3.56
  //////**************Dynamic Size*****************
  static double pageView=screenHeight/2.45; // height odf 1st Container
   static double pageViewContainer=screenHeight/3.56;// height of 1st scrool view container 884/220
  static double pageViewTextContainer=screenHeight/6.53;

  // dynamic height paddding and margin.......
  static double height10= screenHeight/78.4;
  static double height20= screenHeight/39.2;
  // for padding and etc....
  static double height15= screenHeight/52.26;
  static double height30= screenHeight/26.13;
  static double height45= screenHeight/17.44;
  static double height50= screenHeight/15.68;



  // dynamic width padding and margin
  static double width10=  screenHeight/78.4;
  static double width20=screenHeight/39.2;
  // for padding and etc....
  static double width15=  screenHeight/52.26;
  static double width30=  screenHeight/26.13;
  static double width45= screenHeight/17.44;



  //for optimizing font size for devices. smaller fonts for smaller devices
  static double font20=  screenHeight/39.2;
  static double font26=  screenHeight/30.15;
  static double font16=  screenHeight/49;


  // for radius of the container
  static double radius20=  screenHeight/39.2;
  static double radius30=  screenHeight/26.13;
  static double radius15= screenHeight/52.26;


  /// iconn size
/// // default size of icon is 24
  static double iconsize24=  screenHeight/32.66;
  static double iconsize16=  screenHeight/49;

  // List view size screen width =360 & container size of image is 120.. ==3
  static double listViewImgSize= screenWidth/3;
  static double listViewTextContSize= screenWidth/3.6; // 360/100

  // popular food
  static double popularFoodImgSize=screenHeight/2.24;

  // bottom height
  static double bottomheightbar =screenHeight/6.53;

  // splash screen
  static double splashImg=screenHeight/3.14;

}