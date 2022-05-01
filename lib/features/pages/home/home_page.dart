import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' show Platform;

import '../../providers/home_provider.dart';
import '../../widgets/home/home_widget.dart';

//import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);


  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with AfterLayoutMixin{
  late HomePageProvider _homePageProvider;

  @override
  void afterFirstLayout(BuildContext context)async {
    _homePageProvider.userRating=1;
    await _homePageProvider.getParkList().then((value) {
    });
  }

  @override
  Widget build(BuildContext context) {
    _homePageProvider=Provider.of<HomePageProvider>(context);
    return Scaffold(
      body: Stack(children:[
         Visibility(
           visible: !_homePageProvider.isLoading,
            child: const Center(child: CircularProgressIndicator(backgroundColor:Color(0xff00524E) ,))),

        Visibility(
       visible: _homePageProvider.isLoading,
            child: HomePageWidget(homePageProvider: _homePageProvider))]),
    );
  }





}