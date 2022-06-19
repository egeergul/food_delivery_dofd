import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
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

  Future <void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {

    print("Page height is: " + MediaQuery.of(context).size.height.toString());

    return RefreshIndicator(
        child: Column(
        children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(top:Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Column(
                  children: [
                    BigText(text: "U.S.A", color: AppColors.mainColor, size: 30, ),
                    Row(
                      children: [
                        SmallText(text: "Virginia", color: Colors.black54,),

                      ],
                    ),

                  ],
                ),
                Center(
                  child:
                  //GetBuilder<PopularProductController>(builder: (controller) {
                    //return GestureDetector(
                     GestureDetector(
                      onTap: () {
                        //if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        //}
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                         /* controller.totalItems >= 1

                              ? Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),
                          )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                            right: 3,
                            top: 3,
                            child: BigText(
                              text: Get.find<PopularProductController>()
                                  .totalItems
                                  .toString(),
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                              : Container() */
                        ],
                      ),
                    )//; KONULACAK
                  //}) //AÇILACAK
                      //end of get builder
                ),

              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody( ),
        ))
      ],
    ),

        onRefresh: _loadResources);
  }
}
