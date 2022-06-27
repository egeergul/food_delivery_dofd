import 'package:dofd_user_panel/data/api/api_client.dart';
import 'package:dofd_user_panel/models/address_model.dart';
import 'package:dofd_user_panel/models/place_order_model.dart';
import 'package:dofd_user_panel/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(
        AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }

  Future<Response> getAllOrders() async {
    Response response = await apiClient.getData(
      AppConstants.ALL_ORDERS_LIST_URI,
    );
    return response;
  }
}
