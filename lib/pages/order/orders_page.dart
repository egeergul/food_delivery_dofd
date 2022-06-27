import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dofd_user_panel/base/show_custom_snackbar.dart';
import 'package:dofd_user_panel/controllers/order_controller.dart';
import 'package:dofd_user_panel/models/address_model.dart';
import 'package:dofd_user_panel/models/order_model.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:dofd_user_panel/utils/dimensions.dart';
import 'package:dofd_user_panel/widgets/big_text.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<OrderModel>> ordersList;

  late List<OrderModel> ordersList1;

  @override
  void initState() {
    ordersList = Get.find<OrderController>().getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GetBuilder<OrderController>(builder: (_orderController) {
          Widget timeWidget(int index) {
            var outputDate = DateTime.now().toString();
            if (index < _orderController.orderList1.length) {
              DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                  _orderController.orderList1[index]['created_at'].toString());
              var inputDate = DateTime.parse(parseDate.toString());
              var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a ");
              outputDate = outPutFormat.format(inputDate);
            }
            return BigText(
              text: outputDate,
            );
          }

          return _orderController.orders.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.mainColor,
                    title: BigText(text: "ORDERS"),
                  ),
                  body: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.height30,
                              bottom: Dimensions.height30),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: "CONTACTOR NAME: " +
                                            _orderController.orderList1[index]
                                                    ['delivery_address']
                                                ['contact_person_name']),
                                    BigText(
                                        text: "CREATED AT" +
                                            _orderController.orderList1[index]
                                                ['created_at']),
                                    BigText(
                                        text: "CONTACT NUMBER:" +
                                            _orderController.orderList1[index]
                                                    ['delivery_address']
                                                ['contact_person_number']),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showCustomSnackBar("APPROVED!",
                                            title: "ORDER HANDLING");
                                        _orderController.acceptOrder(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.height10)),
                                        child: BigText(
                                          text: "APPROVE",
                                          color: Colors.white,
                                        ),
                                        height: Dimensions.height30,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCustomSnackBar("REJECTED!",
                                            title: "ORDER HANDLING");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.height10)),
                                        child: BigText(
                                          text: "REJECT",
                                          color: Colors.white,
                                        ),
                                        height: Dimensions.height30,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: _orderController.orderList1.length,
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ));
        }),
      ],
    ));
  }
}
