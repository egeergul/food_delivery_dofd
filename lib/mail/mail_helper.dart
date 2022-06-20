import 'package:flutter/material.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailHelper{
  sendGmail(OrderModel orderModel) async {
    String username = 'boraaltinok26@gmail.com';
    String password = 'fcthkjswcupoxfdf';
    //print("printing order model " + orderModel.deliveryAddress!.address);
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.
    Map<String, dynamic> json = orderModel.toJson();
    print("PRINTING JSON" + json.toString());
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Notification Service')
      ..recipients.add('egeergull2001@gmail.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'ORDER PLACED :: ${DateTime.now()}'
      ..text = 'Butona bastım geldi mi HE?.\nThis is line 2 of the text part.'
      ..html = "<h1>ORDER HAS PLACED id = ${orderModel.id}</h1>\n<p> ORDER DETAILS!!: AMOUNT ${orderModel.orderAmount}, ADDRESS: ${orderModel.deliveryAddress}   </p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
  }
}