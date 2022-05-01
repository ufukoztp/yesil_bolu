import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../costumcomponents/onboard_button.dart';
import '../../../utils/localization/app_localizations.dart';
import '../../../utils/routes.dart';




class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
    key: introKey,
    globalBackgroundColor: Colors.white,
    pages: [
      ///page 1
      PageViewModel(
        title: ' ',
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///image
            Container(
              height: 48.0.h,
              width: 100.0.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image:AssetImage("asset/OnBoardBir.png")
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(1.0.w),
              child:  Text(AppLocalizations.getString('onb_descp_1'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            ///buttons
            onboardButton(text:  AppLocalizations.getString('next'),colorBackround:Color(0xffffde6d),onTap:()async {introKey.currentState!.controller.jumpToPage(1);},colorText: Colors.black),
            onboardButton(text: AppLocalizations.getString('skip'),colorText: Colors.grey,colorBackround:Colors.transparent,onTap:()async {introKey.currentState!.controller.jumpToPage(2);},),
          ],
        ),
        decoration: pageDecoration,
      ),
      ///page 2
      PageViewModel(
        title: ' ',
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///image
            Container(
              height: 48.0.h,
              width: 100.0.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/OnBoardIki.png")
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(1.0.w),
              child:  Text(AppLocalizations.getString('onb_descp_2'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
             ///buttons
             onboardButton(text: AppLocalizations.getString('next'),colorBackround:Color(0xffffde6d),onTap:()async {introKey.currentState!.controller.jumpToPage(2);},colorText: Colors.black),
            onboardButton(text: AppLocalizations.getString('skip'),colorText: Colors.grey,colorBackround:Colors.transparent,onTap:()async {introKey.currentState!.controller.jumpToPage(2);},),
          ],
        ),decoration: pageDecoration,
      ),

      ///page 3
      PageViewModel(
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 48.0.h,
              width: 100.0.w,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/OnBoardUc.png")
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(2.0.w),
              child:  Text(AppLocalizations.getString('onb_descp_3'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            onboardButton(text: AppLocalizations.getString('start') ,colorText: Colors.black,colorBackround:const Color(0xFffFDE6D),onTap:()async {
                 Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },),
          ],
        ),
        title: " ",
        decoration: pageDecoration,
      ),
    ],
    //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
    showSkipButton: false,
    skipFlex: 0,
    showNextButton: false,
    showDoneButton: false,
    nextFlex: 0,
    //rtl: true, // Display as right-to-left
       // skip: const Text('Skip'),
       // done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
    curve: Curves.fastLinearToSlowEaseIn,
    dotsDecorator: const DotsDecorator(
      size: Size(10.0, 10.0),
      color: Color(0xFFBDBDBD),
      activeSize: Size(22.0, 10.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    ),
      );
  }
}


