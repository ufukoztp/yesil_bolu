import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget detailCard({ required  String title, required  IconData icon,  required bool enabled,required  String content,required BuildContext context}){
  return Padding(
    padding:  EdgeInsets.only(left:5.0.w,right: 5.0.w),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black45,offset: Offset(-2,4),blurRadius: 10)]
      ),
      height: 10.0.h,
      width: 410.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 4.0.w,),
          Icon(icon,color: enabled==false?Colors.grey: const Color(0xff00524E),size: 26.0.sp,),
          SizedBox(width: 4.0.w,),
          Expanded(child: Text(title,style: TextStyle(fontSize: 15.0.sp,fontWeight: FontWeight.w500,color: enabled==false?Colors.grey: Color(0xff00524E)),)),
          Padding(
            padding:  EdgeInsets.only(bottom:5.0.h,left: 10.0.w,right: 5.0.w),
            child: InkWell(
              onTap: ()async{
                await   showDialog(context: context,
                    builder:(context){
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Container(
                          color: Colors.white,
                          height: 300,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:150.0,left: 10,right: 10),
                                child: Text(content !=null?content:title,style: TextStyle(fontWeight: FontWeight.w700),),
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Container(
                child: const Icon(Icons.info_outline,color: Colors.white,),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40),
                ),
                height: 24,
                width: 24,
              ),
            ),
          )

        ],),

    ),
  );
}
