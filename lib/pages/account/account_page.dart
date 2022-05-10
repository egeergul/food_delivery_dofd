import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }

    _deleteAccount(String email){
      if (Get.find<AuthController>()
          .userLoggedIn()) {


        Get.find<AuthController>()
            .clearSharedData();

        Get.find<AuthController>().deleteAccount(email);
        Get.find<CartController>().clear();
        Get.find<CartController>()
            .clearCartHistory();
        Get.find<LocationController>().clearAddressList();

        //Get.offNamed(
          //  RouteHelper.getSignInPage());
      } else {
        Get.offNamed(
            RouteHelper.getSignInPage());
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          // profile
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            size: Dimensions.height15 * 10,
                            iconSize: Dimensions.height15 * 5,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //name
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.name,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //phone
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.phone,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //email
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.email,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //address
                                  GetBuilder<LocationController>(
                                      builder: (locationController) {
                                    if (_userLoggedIn &&
                                        locationController
                                            .addressList.isEmpty) {
                                      return GestureDetector(
                                        onTap: (){
                                          Get.offNamed(RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor: AppColors.mainColor,
                                            iconColor: Colors.white,
                                            size: Dimensions.height10 * 5,
                                            iconSize: Dimensions.height10 * 5 / 2,
                                          ),
                                          bigText: BigText(
                                            text: "Fill in your address",
                                          ),
                                        ),
                                      );
                                    }else{
                                      return GestureDetector(
                                        onTap: (){
                                          Get.offNamed(RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor: AppColors.mainColor,
                                            iconColor: Colors.white,
                                            size: Dimensions.height10 * 5,
                                            iconSize: Dimensions.height10 * 5 / 2,
                                          ),
                                          bigText: BigText(
                                            text: "Your address",
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //message
                                  /**AccountWidget(
                                      appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                      text: "Messages",
                                      ),
                                      ),
                                      SizedBox(
                                      height: Dimensions.height20,
                                      ),*/
                                  // log out
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.find<LocationController>().clearAddressList();
                                        print("inside if");

                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                        print("you logged out");
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                        text: "Logout",
                                      ),
                                    ),
                                  ),

                                  // delete my account
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      print("Deleting account...");
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Warning!"),
                                            content: Text("Are you sure you want to delete this account?"),
                                              actions: <Widget>[
                                                TextButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      _deleteAccount(userController.userModel!.email.toString());

                                                    }),
                                                TextButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    })
                                              ]

                                          );
                                        }
                                      );
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.delete_forever,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                        text: "Delete my account",
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/image/signintocontinue.png"))),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign in",
                              color: Colors.white,
                              size: Dimensions.font20,
                            )),
                          ),
                        )
                      ],
                    )),
                  ),
                );
        }));


  }
}
