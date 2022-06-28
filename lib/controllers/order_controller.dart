import 'dart:convert';

import 'package:dofd_user_panel/data/repository/order_repo.dart';
import 'package:dofd_user_panel/models/address_model.dart';
import 'package:dofd_user_panel/models/order_model.dart';
import 'package:dofd_user_panel/models/place_order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;
  List<OrderModel> orders = [];
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  var orderList1;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

      String mailContent = "<h1>New order has arrived!</h1></br>"
          "<p>Order created at: ${formattedDate}</p></br>"
          "<p>Name: ${placeOrder.contactPersonName}</p></br>"
          "<p>Phone: ${placeOrder.contactPersonNumber}</p></br>"
          "<p>Address: ${placeOrder.address}</p></br>"
          "";

      callback(true, message, orderID, mailContent);
    } else {
      callback(false, response.statusText, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
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
    _orderList = [];
    Response response = await orderRepo.getAllOrders();
    if (response.statusCode == 200) {
      orderList1 = json.decode(response.bodyString.toString()) as List;
      for (var o in orderList1) {
        AddressModel ordersAddress =
            AddressModel.fromJson(o["delivery_address"]);
      }
      response.body.forEach((order) {
        _orderList.add(OrderModel.fromJson(order));
        _isLoaded = true;
        update();
      });
    } else {
      _orderList = [];
    }
    return orderList;
  }

  void acceptOrder(int index) {}


}
