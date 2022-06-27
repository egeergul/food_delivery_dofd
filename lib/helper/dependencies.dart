import 'package:dofd_user_panel/controllers/auth_controller.dart';
import 'package:dofd_user_panel/controllers/cart_controller.dart';
import 'package:dofd_user_panel/controllers/location_controller.dart';
import 'package:dofd_user_panel/controllers/order_controller.dart';
import 'package:dofd_user_panel/controllers/popular%20_product_controller.dart';
import 'package:dofd_user_panel/controllers/user_controller.dart';
import 'package:dofd_user_panel/data/repository/auth_repo.dart';
import 'package:dofd_user_panel/data/repository/cart_repo.dart';
import 'package:dofd_user_panel/data/repository/location_repo.dart';
import 'package:dofd_user_panel/data/repository/order_repo.dart';
import 'package:dofd_user_panel/data/repository/popular_product_repo.dart';
import 'package:dofd_user_panel/data/repository/user_repo.dart';
import 'package:dofd_user_panel/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/recommended_food_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/recommended_food_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // api
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(
      () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
