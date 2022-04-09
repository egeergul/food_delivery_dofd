import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
   AppTextField({Key? key, required this.textController, required this.hintText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      //padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1,10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText ,
          prefixIcon: Icon(icon, color: AppColors.yellowColor,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:  BorderSide(
                //color: Colors.white,
                  width: 1.0
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:  BorderSide(
                //color: AppColors.mainColorTransparent,
                  color: Colors.white,
                  width: 1.0
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:  BorderSide(
                //color: AppColors.mainColorTransparent,
                  color: Colors.white,
                  width: 1.0
              )
          ),

        ),
      ),

    );
  }
}
