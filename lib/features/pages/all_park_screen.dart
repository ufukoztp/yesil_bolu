
import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
 import 'package:sizer/sizer.dart';


import '../../costumcomponents/expansion_tile.dart';
import '../providers/home_provider.dart';
import '../widgets/all_park_widget.dart';


class AllPark extends StatefulWidget {
  @override
  _AllParkState createState() => _AllParkState();
}

class _AllParkState extends State<AllPark> with AfterLayoutMixin<AllPark> {
  late HomePageProvider _homePageProvider;

  @override
  Widget build(BuildContext context) {

    _homePageProvider=Provider.of<HomePageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AllParkWidget(homePageProvider: _homePageProvider,),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async{
    await _homePageProvider.getParkList().then((value) {
      _homePageProvider.park.forEach((element) {
        _homePageProvider.expansionTileList2.add(GlobalKey<AppExpansionTileState>());
        _homePageProvider.expansionChange.add(false);
      });

    });
  }
}
