import 'dart:ui';


import 'package:after_layout/after_layout.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urbanspaces/costumcomponents/home_components/comment.dart';

import '../../../costumcomponents/expansion_tile.dart';
import '../../../costumcomponents/home_components/detail_card.dart';
import '../../../costumcomponents/home_components/filter_bar.dart';
import '../../../costumcomponents/home_components/info_card.dart';
import '../../../costumcomponents/home_components/park_card.dart';
import '../../../costumcomponents/home_components/zoom_buttons.dart';
import '../../../utils/localization/app_localizations.dart';
import '../../../utils/localization/bloc_localization.dart';
import '../../../utils/localization/pref_language.dart';
import '../../../utils/routes.dart';
import '../../providers/home_provider.dart';
import '../../../utils/localization/bloc_localization.dart';


class HomePageWidget extends StatefulWidget {
  final HomePageProvider homePageProvider;

  HomePageWidget({  required this.homePageProvider}):super();

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}
class parkList {
  final String name;
  final String avatar;
  parkList({ required  this.name,  required  this.avatar});
}
class _HomePageWidgetState extends State<HomePageWidget> with AfterLayoutMixin {
  late HomePageProvider _homePageProvider;
   late bool expansionState;



  @override
  void afterFirstLayout(BuildContext context) async{
    _homePageProvider.auth.authStateChanges().listen((event)async {
      if(event!=null){
        _homePageProvider.user= event;
        _homePageProvider.userState=true;
        await  _homePageProvider.getUserRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!,_homePageProvider.user.uid);

      }else{_homePageProvider.userState=false;}});

    await _homePageProvider.getRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!);


  }



  @override
  void initState() {
    ///initail variable
    expansionState=false;
    _homePageProvider=widget.homePageProvider;

    _homePageProvider.pageController = PageController(initialPage: 1, viewportFraction: 0.8)..addListener(()async{
      print(_homePageProvider.pageController.page!.toInt().toString()+"listeners");
      int a =_homePageProvider.pageController.page!.toInt();
      try{
        _homePageProvider.parkListPosition =  a;
      }catch(e){
        print(e.toString());
        _homePageProvider.parkListPosition = a;
      }
      _homePageProvider.scroll();
      _homePageProvider.moveCamera();
      await _homePageProvider.getRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!);
    }
    );

    _homePageProvider.filter.add(AppLocalizations.getString('sit_field'));
    _homePageProvider.filter.add(AppLocalizations.getString('accessible'));
    _homePageProvider.filter.add(AppLocalizations.getString('eat'));
    _homePageProvider.filter.add(AppLocalizations.getString('wc'));
    _homePageProvider.filter.add(AppLocalizations.getString('culture'));
    _homePageProvider.filter.add(AppLocalizations.getString('car_park'));
    _homePageProvider.filter.add(AppLocalizations.getString('basketball'));
    _homePageProvider.filter.add(AppLocalizations.getString('sport_field'));
    _homePageProvider.filter.add(AppLocalizations.getString('bicycle_path'));
    _homePageProvider.filter.add(AppLocalizations.getString('running_track'));
    _homePageProvider.filter.add(AppLocalizations.getString('wifi'));
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(visible:!_homePageProvider.isLoading,child: const Center(child: CircularProgressIndicator(backgroundColor:Color(0xff00524E) ,))),
        Visibility(
          visible: _homePageProvider.isLoading,
          child: Stack(children: [
            ///map
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                trafficEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: _homePageProvider.onMapCreated,
                markers: Set<Marker>.of(_homePageProvider.markers),
                initialCameraPosition:  CameraPosition(target: LatLng(double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords1!),double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords2!)),zoom: 15),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:6.5.h,left: 2.0.w),
              child: Visibility(
                  visible: !_homePageProvider.menu_visibility,
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: (){
                            if(expansionState==false){
                              _homePageProvider.expansionTileList.currentState!.expand();
                            }else{
                              _homePageProvider.expansionTileList.currentState!.collapse();

                            }
                          },
                          child: filterBar()),

                      ///menü bar
                      Padding(
                        padding:  EdgeInsets.only(top:0.8.h,left:4.5.w,right: 0),
                        child: RotationTransition(
                          turns:  const AlwaysStoppedAnimation(-180 / 360),
                          child: SpeedDial(
                            child: const Icon(Icons.menu),
                            closedForegroundColor:Colors.black,
                            openForegroundColor: Colors.white,
                            closedBackgroundColor: Colors.white,
                            openBackgroundColor: const Color(0xff00524E),
                            speedDialChildren: <SpeedDialChild>[
                              SpeedDialChild(
                                child:  RotationTransition(
                                    turns:  AlwaysStoppedAnimation(-180 / 360),
                                    child: Icon(_homePageProvider.auth.currentUser==null?Icons.person:Icons.logout)),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                onPressed: ()async {
                                  if(_homePageProvider.auth.currentUser==null){
                                    await _homePageProvider.signIn(context).then((value) => Navigator.pop(context));
                                  }else{
                                    await _homePageProvider.auth.signOut();
                                    await _homePageProvider.googleSignIn.signOut();
                                  }
                                  _homePageProvider.notifyListeners();

                                },
                                closeSpeedDialOnPressed: false,
                              ),
                              SpeedDialChild(
                                child: RotationTransition(
                                    turns: new AlwaysStoppedAnimation(-180 / 360),

                                    child: const Icon(Icons.park)),
                                foregroundColor: const Color(0xff00524E),
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/allparks").then((value)
                                  {
                                    setState(() {});
                                    _homePageProvider.moveCamera();
                                  });

                                },
                              ),
                              SpeedDialChild(
                                child: const RotationTransition(
                                    turns:  AlwaysStoppedAnimation(-180 / 360),
                                    child: Icon(Icons.calendar_today)),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/activity").then((value)
                                  {
                                    setState(() {});
                                    _homePageProvider.moveCamera();
                                  });

                                },
                              ),
                              //  Your other SpeeDialChildren go here.
                            ],
                          ),
                        ),
                      ),

                    ],
                  )),
            ),
            ///slide panel
            Opacity(
              opacity: !_homePageProvider.menu_visibility==false?1:0.8,
              child: Visibility(
                  visible: expansionState==true?false:true,
                  child:_homePageProvider.park.isNotEmpty?
                  SlidingUpPanel(
                    borderRadius: BorderRadius.circular(30),
                    onPanelOpened: (){
                      _homePageProvider.menu_visibility=true;
                    },
                    onPanelClosed: (){
                      _homePageProvider.menu_visibility=false;
                    },
                    controller:_homePageProvider.panelController ,
                    minHeight: 32.0.h,
                    maxHeight: 85.0.h,
                    collapsed: Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding:   EdgeInsets.only(top:3.0.h),
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              Container(
                                height:0.6.w,
                                width: 13.w,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 2.w,),
                                Text(AppLocalizations.getString('swipe_details'),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top:Radius.circular(30))
                      ),
                    ),
                    panelBuilder: (scrollCntrl){
                      print(scrollCntrl.initialScrollOffset);
                      return  _homePageProvider.park[_homePageProvider.parkListPosition].title!=null?

                      SingleChildScrollView(
                        controller: scrollCntrl,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                )
                            ),
                             child:
                            InkWell(
                              onTap: (){

                                if( _homePageProvider.detailvisiblity==true){
                                  _homePageProvider.detailvisiblity=false;
                                  _homePageProvider.opacity=0.6;
                                }
                                else{
                                  _homePageProvider.opacity=1;
                                  _homePageProvider.detailvisiblity=true;
                                }
                              },
                              child: Visibility(
                                visible: true,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Padding(
                                      padding:   EdgeInsets.only(top:3.0.h),
                                      child: Container(
                                        height:0.6.w,
                                        width: 13.w,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    ///header
                                    detailInfo( _homePageProvider.parkListPosition),
                                    const Padding(
                                      padding:  EdgeInsets.all(8.0),
                                      child: Divider(color: Colors.black45,indent: 30,endIndent: 30,),
                                    ),
                                    Stack(
                                      children: [
                                        Visibility(
                                            visible:_homePageProvider.commentVisible,
                                            child: Comment(homePageProvider: _homePageProvider,pageType: PageType.HomePage,)),

                                        Visibility(
                                            visible:!_homePageProvider.commentVisible,
                                            child: infoCard(context: context, homePageProvider: _homePageProvider)),
                                      ],
                                    ),

                                  ],),
                                ),
                              ),

                            ) ,

                          ),
                        ),
                      ):Container();

                    },
                  )
                      :Container()
              ),
            ),

            ///park card
            Visibility(
              visible: !_homePageProvider.menu_visibility,
              child: Positioned(
                  bottom: 5.0.h,
                  child: Container(
                    height: 39.0.w,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      key: const PageStorageKey('index'),
                      itemCount:_homePageProvider.park.length,
                      itemBuilder: (context, position) {
                        return parkListCard2(position:position,homePageProvider: _homePageProvider,);
                      },
                      controller: _homePageProvider.pageController,
                    ),
                  )),
            ),


            ///zoom  buttons
            Visibility(
              visible: expansionState==true?false:true,
              child: Visibility(
                  visible: !_homePageProvider.menu_visibility,
                  child: zoomButtons(homePageProvider: _homePageProvider,context: context,)),
            ),


          ],),
        ),
      ],
    );
  }

  Widget  filterBar(){
    return Padding(
        padding:  EdgeInsets.only(left:22.0.w,right: 5.0.w),
        child: expansionState==false?Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          elevation: 20,
          child: SizedBox(
            height:15.0.w,
            child: Stack(
              children: [
                AppExpansionTile(
                  onExpansionChanged: (value){
                    setState(() {
                      expansionState=value;
                    });
                  },
                  key: _homePageProvider.expansionTileList,
                  backgroundColor: Colors.transparent,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0.sp)
                        ),
                        height: 40.0.h,
                        width: 250.0.w,
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              const Divider(color: Colors.black38,),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.airline_seat_recline_normal,index: 0,homePageProvider: _homePageProvider,select: _homePageProvider.oturmaalani,name1: _homePageProvider.filter[0],),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.accessible,index: 1,select: _homePageProvider.engellidostu,name1: _homePageProvider.filter[1],homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.free_breakfast,index:2,select: _homePageProvider.yemek,name1: _homePageProvider.filter[2],homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon:Icons.wc,select: _homePageProvider.wc,name1: _homePageProvider.filter[3],index: 3,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.museum,select: _homePageProvider.kultureloge,name1: _homePageProvider.filter[4],index: 4,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.directions_car,select: _homePageProvider.otopark,name1: _homePageProvider.filter[5],index: 5,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.sports_basketball_rounded,select: _homePageProvider.basketboll,name1: _homePageProvider.filter[6],index: 6,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.sports_mma_sharp,select: _homePageProvider.sports_fields,name1: _homePageProvider.filter[7],index: 7,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.directions_bike_outlined,select: _homePageProvider.bicycle_path,name1: _homePageProvider.filter[8],index: 8,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.directions_run,select: _homePageProvider.running_track,name1: _homePageProvider.filter[9],index: 9,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.wifi,select: _homePageProvider.wifi,name1: _homePageProvider.filter[10],index: 10,homePageProvider: _homePageProvider,),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        )
                    )
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 4.0.w,right: 4.0.w,top:0.0.w,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 4.0.w,right: 4.0.w,top:5.6.w,),
                            child: Text(AppLocalizations.getString('filter'),style:TextStyle(color:_homePageProvider.oturmaalani==true||
                                _homePageProvider.otopark==true||
                                _homePageProvider.kultureloge==true||
                                _homePageProvider.yemek==true||_homePageProvider.wc==true||
                                _homePageProvider.engellidostu==true||
                                _homePageProvider.spor==true||_homePageProvider.basketboll==true ||_homePageProvider.sports_fields==true||_homePageProvider.bicycle_path==true||_homePageProvider.running_track==true||_homePageProvider.wifi==true?Colors.white:Colors.grey),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:8.0,top:2.0.w),
                            child: Container(
                              height: 5.0.h,
                              width: 49.0.w,
                              child: SingleChildScrollView(
                                scrollDirection:Axis.horizontal,
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: _homePageProvider.engellidostu,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.accessible,color:Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.spor,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.fitness_center,color:Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.wc,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.wc,color:Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.yemek,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.free_breakfast,color:Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.kultureloge,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.museum,color:Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.otopark,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.directions_car,color:const Color(0xff00524E)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.oturmaalani,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.airline_seat_recline_normal,color:Color(0xff00524E),),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.basketboll,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.sports_basketball_rounded,color:const Color(0xff00524E),),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.sports_fields,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.sports_mma_sharp,color:Color(0xff00524E),),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.bicycle_path,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.directions_bike_outlined,color:Color(0xff00524E),),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.running_track,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.directions_run_outlined,color:Color(0xff00524E),),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _homePageProvider.wifi,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: const Icon(Icons.wifi,color:Color(0xff00524E),),
                                      ),
                                    ),
                                  ],),
                              ),
                            ),
                          ),

                        ],
                      ),
                      Row(children: [
                        Padding(
                          padding:  EdgeInsets.only(top:3.0.w),
                          child: Container(height: 5.0.h,width: 1,color: Colors.grey.shade400,),
                        ),
                        SizedBox(width: 2.0.w,),
                        Padding(
                          padding:  EdgeInsets.only(top:3.0.w),
                          child: const Icon(Icons.filter_list,color: Color(0xff545857),),
                        ),
                      ],)
                    ],
                  ),
                ),
                Visibility(
                  visible: expansionState==true?true:false,
                  child: Padding(
                    padding:  EdgeInsets.only(top:47.0.h),
                    child: InkWell(
                      onTap: ()async{
                        _homePageProvider.expansionTileList.currentState!.collapse();
                        await _homePageProvider.checkFilter2();
                        setState(() {

                        });

                      },
                      child: Container(
                        child: Center(child: Text(AppLocalizations.getString('apply'),style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.w700,fontSize: 18.0.sp),)),
                        width: 80.0.w,
                        height: 7.0.h,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,

                            borderRadius: BorderRadius.only()
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ):Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          elevation: 20,
          child: Stack(
            children: [
              Positioned(
                child: AppExpansionTile(
                  onExpansionChanged: (value){
                    setState(() {
                      expansionState=value;
                    });
                  },
                  key: _homePageProvider.expansionTileList,
                  backgroundColor: Colors.transparent,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0.sp)
                        ),
                        height: 40.0.h,
                        width: 250.0.w,
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              const Divider(color: Colors.black38,),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.airline_seat_recline_normal,index: 0,homePageProvider: _homePageProvider,select: _homePageProvider.oturmaalani,name1: _homePageProvider.filter[0],),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.accessible,index: 1,select: _homePageProvider.engellidostu,name1: _homePageProvider.filter[1],homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.free_breakfast,index:2,select: _homePageProvider.yemek,name1: _homePageProvider.filter[2],homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon:Icons.wc,select: _homePageProvider.wc,name1: _homePageProvider.filter[3],index: 3,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.museum,select: _homePageProvider.kultureloge,name1: _homePageProvider.filter[4],index: 4,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.directions_car,select: _homePageProvider.otopark,name1: _homePageProvider.filter[5],index: 5,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.sports_basketball_rounded,select: _homePageProvider.basketboll,name1: _homePageProvider.filter[6],index: 6,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.sports_mma_sharp,select: _homePageProvider.sports_fields,name1: _homePageProvider.filter[7],index: 7,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.directions_bike_outlined,select: _homePageProvider.bicycle_path,name1: _homePageProvider.filter[8],index: 8,homePageProvider: _homePageProvider,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0,top:16),
                                    child: FilterButton(icon: Icons.directions_run,select: _homePageProvider.running_track,name1: _homePageProvider.filter[9],index: 9,homePageProvider: _homePageProvider,),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:16.0,left:2),
                                    child: FilterButton(icon: Icons.wifi,select: _homePageProvider.wifi,name1: _homePageProvider.filter[10],index: 10,homePageProvider: _homePageProvider,),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: 4.0.w,right: 4.0.w,top:3.0.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Stack(
                      children: [
                        Text(AppLocalizations.getString('filter'),
                          style: TextStyle(color:_homePageProvider.oturmaalani==true||
                              _homePageProvider.otopark==true||
                              _homePageProvider.kultureloge==true||
                              _homePageProvider.yemek==true||_homePageProvider.wc==true||
                              _homePageProvider.engellidostu==true||
                              _homePageProvider.spor==true||_homePageProvider.basketboll==true ||_homePageProvider.sports_fields==true||_homePageProvider.bicycle_path==true||_homePageProvider.running_track==true||_homePageProvider.wifi==true?Colors.white:Colors.grey),),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,top:0),
                          child: Container(
                            height: 5.0.h,
                            width: 49.0.w,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(

                                children: [
                                  Visibility(
                                    visible: _homePageProvider.engellidostu,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.accessible,color:Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.spor,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.fitness_center,color:Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.wc,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.wc,color:Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.yemek,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.free_breakfast,color:Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.kultureloge,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.museum,color:Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.otopark,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.directions_car,color:const Color(0xff00524E)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.oturmaalani,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.airline_seat_recline_normal,color:Color(0xff00524E),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.basketboll,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.sports_basketball_rounded,color:Color(0xff00524E),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.sports_fields,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.sports_mma_sharp,color:Color(0xff00524E),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.bicycle_path,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.directions_bike_outlined,color:Color(0xff00524E),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.running_track,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.directions_run_outlined,color:Color(0xff00524E),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.wifi,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: const Icon(Icons.wifi,color:const Color(0xff00524E),),
                                    ),
                                  ),
                                ],),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Container(height: 5.0.h,width: 1,color: Colors.grey.shade400,),
                      SizedBox(width: 2.0.w,),
                      const Icon(Icons.filter_list,color: Color(0xff545857),),
                    ],)
                  ],
                ),
              ),
              Visibility(
                visible: expansionState==true?true:false,
                child: Padding(
                  padding:  EdgeInsets.only(top:47.0.h),
                  child: InkWell(
                    onTap: ()async{
                      _homePageProvider.expansionTileList.currentState!.collapse();
                      await _homePageProvider.checkFilter2();
                      setState(() {

                      });

                    },
                    child: Container(
                      child: Center(child: Text(AppLocalizations.getString('apply'),style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.w700,fontSize: 18.0.sp),)),
                      width: 80.0.w,
                      height: 8.0.h,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,

                          borderRadius: const BorderRadius.only()
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        )
    );
  }

  Widget detailInfo(int posinited){
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child:   Padding(
            padding: EdgeInsets.only(top:6.0.h,left: 4.w),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:NetworkImage(_homePageProvider.park[_homePageProvider.parkListPosition].photo! !=""?_homePageProvider.park[_homePageProvider.parkListPosition].photo!:"https://firebasestorage.googleapis.com/v0/b/yesil-ea967.appspot.com/o/yildiz-parki-1.jpg?alt=media&token=09388921-6388-428c-8c73-fffa6e603749"),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30)
                  )
              ),
              height: 20.0.h,
              width: 42.0.w,
            ),
          ),
        ),
        SizedBox(width: 1.0.w,),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.only(top:6.0.h),
            child: Column(
              children: [
                Text(_homePageProvider.park[_homePageProvider.parkListPosition].title!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                Padding(
                    padding:  EdgeInsets.only(left:0.0,top: 2.w),
                    child:Column(
                      children: [
                        ///rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFRating(
                              value: _homePageProvider.userRating,
                              onChanged: (value)async{
                                if(_homePageProvider.userState==false){
                                  showDialog(context: context,
                                      builder:(context){
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
                                                    _homePageProvider.signIn(context);


                                                  },
                                                  child: Container(
                                                    child:Center(child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                            height: 30,
                                                            width: 30,
                                                            child: Image.asset("asset/google_icon.png")),

                                                        const Text("GİRİŞ YAP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
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
                                  );
                                }else{

                                  setState(() {
                                    _homePageProvider.userRating=value;

                                  });
                                  _homePageProvider.userRating=value;


                                  await _homePageProvider.setRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!, _homePageProvider.user.uid, value).then((value) =>print("başarılı"));

                                  await _homePageProvider.getRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!);
                                  await _homePageProvider.getUserRating(_homePageProvider.park[_homePageProvider.parkListPosition].title!,_homePageProvider.user.uid);

                                }




                              },
                              borderColor: Colors.orange,
                              color: Colors.orange,
                              size: 27,
                            ),
                            SizedBox(width: 2.w,),
                            _homePageProvider.ortRating!=null?
                            Text(_homePageProvider.ortRating.ceilToDouble().toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),)
                                :  Text(AppLocalizations.getString('no_point'))
                          ],
                        ),

                      ],
                    )
                ),
                Text(AppLocalizations.getString('rating_comment_tap'),style: TextStyle(color: Colors.grey,fontSize: 8.sp),),
                InkWell(
                  onTap: (){
                    widget.homePageProvider.commentVisible = !widget.homePageProvider.commentVisible;
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(left:11.0.w,top: 2.w),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [const BoxShadow(color: Colors.black26,blurRadius: 10)],
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: const Center(child: Icon(Icons.person,color: Colors.grey,),),
                        ),
                        Positioned(
                          left: 6.w,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [const BoxShadow(color: Colors.black26,blurRadius: 10)],
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: const Center(child: Icon(Icons.person,color: Colors.grey,),),
                          ),
                        ),
                        Positioned(
                          left: 12.w,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [const BoxShadow(color: Colors.black26,blurRadius: 10)],
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: const Center(child: Icon(Icons.person,color: Colors.grey,),),
                          ),

                        ),
                        Positioned(
                          left: 18.w,
                          child:Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [const BoxShadow(color: Colors.black26,blurRadius: 10)],
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: const Center(child: const Icon(Icons.person,color: Colors.grey,),),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    print(double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords1!));
                    MapsLauncher.launchCoordinates(
                        double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords1!),double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords2!),_homePageProvider.park[_homePageProvider.parkListPosition].title);
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(right:3.h),
                    child: Container(
                      child: Center(child: Text(AppLocalizations.getString('take_me_here'),style: const TextStyle(color: Colors.white),)),
                      decoration: BoxDecoration(
                          color: const Color(0xff00524E),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 5.5.h,
                      width: 32.w,
                    ),
                  ),
                )
              ],
            ),
          ),
        )

      ],
    );
  }


}






