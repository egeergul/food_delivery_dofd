import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:dofd_user_panel/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/popular _product_controller.dart';
import '../../controllers/recommended_food_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3), () {
      if (Get.find<AuthController>().userLoggedIn()) {
        Get.offNamed(RouteHelper.getInitial());
      } else {
        Get.toNamed(RouteHelper.getSignInPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/image/logo_pink.jpg",
                width: Dimensions.splashImage,
              ))),
        ],
      ),
    );
  }
}
