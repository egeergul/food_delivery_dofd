import 'package:dofd_user_panel/controllers/order_controller.dart';
import 'package:dofd_user_panel/controllers/popular%20_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dofd_user_panel/base/custom_button.dart';
import 'package:dofd_user_panel/routes/route_helper.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:dofd_user_panel/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controllers/cart_controller.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;

  OrderSuccessPage({required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {});
    } 
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_outlined,
                size: 100,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Text(
                status == 1
                    ? 'You placed the order successfully'
                    : 'Your order failed',
                style: TextStyle(fontSize: Dimensions.font20),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height10),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failed Order',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: CustomButton(
                    buttonText: 'Back to home',
                    onPressed: () => Get.offAllNamed(RouteHelper.getInitial())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
