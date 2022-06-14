import 'dart:convert';

import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  /*
  * BORANINKI
  * */
  List<OrderModel> _orderList = [];

  List<OrderModel> get orderList => _orderList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  var orderList1;
  List<OrderModel> orders = [];

  /*
  ADAMINKI
   */
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  List<OrderModel> get currentOrderList => _currentOrderList;

  List<OrderModel> get historyOrderList => _historyOrderList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    } else {
      callback(false, response.statusText, '-1');
    }
  }

  Future<void> getOrderList() async {
    //ADAMIN METHODU
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      print("PRINTING RESPONSE " + response.bodyString.toString());
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up')
        {
          _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;


    update();
  }

  Future<List<OrderModel>> getAllOrders() async {
    //BORANIN METHODU
    _orderList = [];
    Response response = await orderRepo.getAllOrders();
    if (response.statusCode == 200) {
      orderList1 = json.decode(response.bodyString.toString()) as List;
      for (var o in orderList1) {
        AddressModel ordersAddress =
            AddressModel.fromJson(o["delivery_address"]);
        /*OrderModel orderModel = OrderModel(userId: o["userId"],
            orderAmount: o["orderAmount"],
            deliveryAddress: ordersAddress);
        print("adding");
        orders.add(orderModel);*/
      }
      response.body.forEach((order) {
        //print("FOR EACH INSIDE");

        _orderList.add(OrderModel.fromJson(order));
        _isLoaded = true;
        update();
      });
      //print("RESPONSE IS " + jsonDecode(response.bodyString.toString()));
      //_orderList.add(jsonDecode(response.bodyString!));
    } else {
      print("order adding  FAILED :" + response.statusText.toString());
      _orderList = [];
    }
    //print("ORDER CONTROLLER ordes " + orders[0].toString());

    //print("ORDER CONTROLLER orderList1 " + orderList1.toString());
    return orderList;
  }

  void acceptOrder(int index) {
    print("ORDER " + index.toString() + " ACCEPTED");
  }
}
