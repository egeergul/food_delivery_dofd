import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular%20_product_controller.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/recommended_food_detail.dart';
import "package:get/get.dart";
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

    Get.find<PopularProductController>( ).getPopularProductList();
    Get.find<RecommendedProductController>( ).getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:   MainFoodPage(),
      initialRoute: RouteHelper.getInitial() ,
      getPages: RouteHelper.routes ,
    );
  }
}
