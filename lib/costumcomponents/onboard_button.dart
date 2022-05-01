import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
Widget onboardButton({required VoidCallback? onTap,required String text,required Color? colorBackround,required Color colorText}){
  return   InkWell(
    onTap:onTap,
    child: Padding(
      padding:   EdgeInsets.only(top:5.0.h),
      child: Container(
        child:  Center(child:Text(text,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: colorText),)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorBackround,
        ),
        height: 7.0.h,
        width: 50.0.w,
      ),
    ),
  );
}
