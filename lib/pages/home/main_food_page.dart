import 'package:flutter/material.dart';
import 'package:dofd_user_panel/utils/dimensions.dart';
import 'package:dofd_user_panel/widgets/small_text.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:dofd_user_panel/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular _product_controller.dart';
import '../../controllers/recommended_food_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "U.S.A",
                          color: AppColors.mainColor,
                          size: 30,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Virginia",
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                        ],
                      ),
                    )
                        //end of get builder
                        ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            ))
          ],
        ),
        onRefresh: _loadResources);
  }
}
