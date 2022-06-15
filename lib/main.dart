import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular%20_product_controller.dart';

import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/auth/sing_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/order/orders_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'controllers/recommended_food_controller.dart';
import 'helper/dependencies.dart' as dep;


void main() async   {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          home: SplashScreen(),
          //home: OrdersPage(),

          //initialRoute:   RouteHelper.getSplashPage(),  //SIGNUP() ÇEVİR BORA DEĞİŞTİRDİ
          //initialRoute: RouteHelper.getInitial() ,
          getPages: RouteHelper.routes ,

          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: 'Lato '
          ),
        );
      });
    });
  }
}

