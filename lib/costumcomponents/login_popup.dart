import 'package:flutter/material.dart';

class LoginPopUp extends StatelessWidget {
  late VoidCallback onTap;
  LoginPopUp({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        color: Colors.white,
        height: 270,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom:150.0,left: 10,right: 10),
              child: Text("Lütfen önce giriş yapınız.",style: TextStyle(fontWeight: FontWeight.w700),),
            ),
            InkWell(
              onTap: ()async{
                onTap;
              },
              child: Container(
                child:Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        child: Image.asset("asset/google_icon.png")),

                    Text("GİRİŞ YAP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
                  ],
                )),
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.green.shade700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
