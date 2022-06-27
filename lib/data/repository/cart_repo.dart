import 'dart:convert';

//import 'package:shared_preferences/shared_preferences.dart';

import 'package:dofd_user_panel/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);//DEBUGGING PURPOSES
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);//DEBUGGING PURPOSES
    //return;
    var time = DateTime.now().toString();
    cart = [];
    /*cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });*/

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      //print("HİSTORY " + cart[i]);
      cartHistory.add(cart[i]);
    }

    cart = [];

    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    /*print(
        "the length of history list is " + getCartHistory().length.toString());
    for(int i = 0; i < getCartHistory().length; i++){
      print("The time of  the order is " + getCartHistory()[i].time.toString());
    }*/
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

  void removeCartSharedPreference(){
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
