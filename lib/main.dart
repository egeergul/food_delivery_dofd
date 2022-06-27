import 'package:flutter/material.dart';
import 'package:dofd_user_panel/controllers/cart_controller.dart';
import 'package:dofd_user_panel/controllers/popular%20_product_controller.dart';
import 'package:dofd_user_panel/pages/splash/splash_page.dart';
import 'package:dofd_user_panel/routes/route_helper.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'controllers/recommended_food_controller.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
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
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
          getPages: RouteHelper.routes,
          theme:
              ThemeData(primaryColor: AppColors.mainColor, fontFamily: 'Lato '),
        );
      });
    });
  }
}
