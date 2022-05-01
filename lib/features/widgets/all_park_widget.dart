import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
 import 'package:maps_launcher/maps_launcher.dart';
 import 'package:sizer/sizer.dart';
import 'package:urbanspaces/costumcomponents/home_components/comment.dart';

import '../../utils/localization/app_localizations.dart';
import '../pages/activity/activity_screen.dart';
import '../providers/home_provider.dart';

class AllParkWidget extends StatefulWidget {
  late HomePageProvider homePageProvider;
  AllParkWidget({required this.homePageProvider});
  @override
  _AllParkWidgetState createState() => _AllParkWidgetState();
}

class _AllParkWidgetState extends State<AllParkWidget> {
 late HomePageProvider _homePageProvider;
  @override
  void initState() {
    // TODO: implement initState
    _homePageProvider=widget.homePageProvider;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        /*
        ///filters
        Padding(
          padding:  EdgeInsets.only(left:4.w,bottom: 4.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children:List.generate(titles.length, (index) => Padding(
                  padding:  EdgeInsets.all(3.0.w),
                  child: activity_type_button(
                    id:index,name: titles[index],iconName: "asset/ehepsi.png",
                    onpressed: (){
                      _homePageProvider.selectId=index;
                    },
                    selectedId: _homePageProvider.selectId,
                  ),
                ),)
            ),
          ),
        ),

         */
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left:7.0.w,bottom: 2.w,top:2.w),
              child: Text("Tüm parklar",style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),),
            ),
            Column(
              children: List.generate(_homePageProvider.park.length, (index) {
                return  Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top:4.w,bottom:5.w),
                        child: Container(
                          width: 90.0.w,
                          decoration:
                          BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(-3,3),blurRadius: 10)],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            children: [
                              Row(

                                children: [
                                  ///photo
                                  Padding(
                                    padding:  EdgeInsets.all(3.0.w),
                                    child: Container(
                                      height: 10.h,
                                      width: 22.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          image: DecorationImage(image: NetworkImage(  _homePageProvider.park[index].photo!=""?_homePageProvider.park[index].photo!:"https://firebasestorage.googleapis.com/v0/b/yesil-ea967.appspot.com/o/yildiz-parki-1.jpg?alt=media&token=09388921-6388-428c-8c73-fffa6e603749"), fit: BoxFit.cover)),
                                    ),
                                  ),
                                  ///other content
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ///title
                                      Text(
                                        _homePageProvider.park[index].title!.toUpperCase(),
                                        style:   TextStyle(
                                            fontSize:6.0.sp, fontWeight: FontWeight.w800),
                                      ),
                                      ///star
                                      Row(
                                        children: [
                                            Icon(Icons.star,color: Colors.orange,size: 4.w,),
                                          Text(_homePageProvider.ortRating!=null?_homePageProvider.ortRating.ceilToDouble().toString():'null',style: TextStyle(fontSize: 12,color: Colors.grey),),

                                        ],
                                      ),

                                      ///icons
                                      Container(
                                        width: 35.0.w,
                                        height: 4.0.h,
                                        child: filterIconsInfo(homePageProvider: _homePageProvider,index: index,),
                                      ),
                                       SizedBox(height: 2.0.w,),
                                      ///adress
                                      Wrap(
                                        children: [
                                          Icon(Icons.location_on,size: 5.w,),
                                          Container(
                                            width: 30.0.w,

                                            child: Text(
                                              _homePageProvider.park[index].description!.toUpperCase(),
                                              style:   TextStyle(
                                                  fontSize:6.0.sp, fontWeight: FontWeight.w500,color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2.0.w,),
                                  ///take me here
                                  InkWell(
                                    onTap: (){
                                      print(double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords1!));
                                      MapsLauncher.launchCoordinates(
                                          double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords1!),double.parse(_homePageProvider.park[_homePageProvider.parkListPosition].coords2!),_homePageProvider.park[_homePageProvider.parkListPosition].title);
                                    },
                                    child: Container(
                                     child: Center(child: Text(AppLocalizations.getString('take_me_here'),style:   TextStyle(color: Colors.white,fontSize: 7.sp),)),
                                     decoration: BoxDecoration(
                                         color: const Color(0xff00524E),
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                     height: 4.5.h,
                                     width: 20.w,
                                      ),
                                  )


                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 3.w),
                                child: Comment(homePageProvider: _homePageProvider,pageType: PageType.AllParks,index: index,),
                              )

                            ],
                          ),
                        ),
                      ),
                    )


                  ],
                );


              }),
            ),
          ],
        )
      ],
    );
  }
}

class filterIconsInfo extends StatelessWidget {
  const filterIconsInfo({
    Key? key,
    required HomePageProvider homePageProvider,required this.index,
  }) : _homePageProvider = homePageProvider, super(key: key);

  final HomePageProvider _homePageProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Visibility(
          visible: _homePageProvider.park[index].engellidostu==true?true:false,
          child: Padding(
            padding:   EdgeInsets.all(2.0),
            child: Icon(Icons.accessible,color:Color(0xff00524E),size: 4.w,),
          ),
        ),

        Visibility(
          visible: _homePageProvider.park[index].tuvalet==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.wc,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible:_homePageProvider.park[index].yemeicme==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.free_breakfast,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].kultureloge==true?true:false,
          child: Padding(
            padding:   EdgeInsets.all(2.0),
            child: Icon(Icons.museum,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].otopark==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.directions_car,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].oturmaalani==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.airline_seat_recline_normal,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].basketbol==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.sports_basketball_rounded,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].sporalani==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.sports_mma_sharp,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].bisikletyolu==true?true:false,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.directions_bike_outlined,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].kosuparkuru==true?true:false,
          child:  Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.directions_run_outlined,color:Color(0xff00524E),size: 4.w),
          ),
        ),
        Visibility(
          visible: _homePageProvider.park[index].wifi==true?true:false,
          child:   Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.wifi,color:Color(0xff00524E),size: 4.w),
          ),
        ),
      ],);
  }
}
