import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../features/providers/home_provider.dart';

class parkListCard2 extends StatelessWidget {
  const parkListCard2({
    Key? key,
    required HomePageProvider homePageProvider,
    required  this.position,
  }) : _homePageProvider = homePageProvider, super(key: key);

  final HomePageProvider _homePageProvider;
  final int position;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _homePageProvider.pageController,
      builder: (context,  widget) {
        double value = 1;
        if (_homePageProvider.pageController.position.haveDimensions) {
          value = (_homePageProvider.pageController.page! - position);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);

        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 250.0.h,
            width: Curves.easeInOut.transform(value) * 450.0.h,
            child: widget,
          ),
        );

      },
      child: InkWell(
          onTap: () async{

            _homePageProvider.moveCamera();

          },
          child: _homePageProvider.park[0].title!=""?
          Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                  height: 405.0.h,
                  width: 80.0.w,
                  child: Container(
                    width: 90.0.w,
                    decoration:
                    BoxDecoration(
                        boxShadow:const [ BoxShadow(color: Colors.black38,offset: Offset(-3,3),blurRadius: 20)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      children: [
                         InkWell(
                             onTap: ()async{
                               _homePageProvider.pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
                             },
                             child: Icon(Icons.chevron_left,color: Colors.grey,)),
                        Padding(
                          padding:  EdgeInsets.all(3.0.w),
                          child: Container(
                            height: 90,
                            width: 22.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20),
                                image: DecorationImage(
                                    image: NetworkImage( _homePageProvider.park[_homePageProvider.parkListPosition].photo! !=""?_homePageProvider.park[_homePageProvider.parkListPosition].photo! :"https://firebasestorage.googleapis.com/v0/b/yesil-ea967.appspot.com/o/yildiz-parki-1.jpg?alt=media&token=09388921-6388-428c-8c73-fffa6e603749"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        ///icons
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _homePageProvider.park[_homePageProvider.parkListPosition].title!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize:8.0, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,color: Colors.orange,size: 18,),
                                Text(_homePageProvider.ortRating!=null?_homePageProvider.ortRating.ceilToDouble().toString():'null',style: const TextStyle(fontSize: 12,color: Colors.grey),),

                              ],
                            ),
                            Container(
                              width: 35.0.w,
                              height: 4.0.h,
                              child: Wrap(
                                children: [
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].engellidostu==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.accessible,color:Color(0xff00524E),size: 15,),
                                    ),
                                  ),

                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].tuvalet==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.wc,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible:_homePageProvider.park[_homePageProvider.parkListPosition].yemeicme==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.free_breakfast,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].kultureloge==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.museum,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].otopark==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.directions_car,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].oturmaalani==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.airline_seat_recline_normal,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].basketbol==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.sports_basketball_rounded,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].sporalani==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.sports_mma_sharp,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].bisikletyolu==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.directions_bike_outlined,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].kosuparkuru==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.directions_run_outlined,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _homePageProvider.park[_homePageProvider.parkListPosition].wifi==true?true:false,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.wifi,color:Color(0xff00524E),size: 15),
                                    ),
                                  ),
                                ],),
                            ),
                            Wrap(
                              children: [
                                const Icon(Icons.location_on,size: 17,),
                                Container(
                                  width: 30.0.w,

                                  child: Text(
                                    _homePageProvider.park[_homePageProvider.parkListPosition].description!.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize:8.0, fontWeight: FontWeight.w500,color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                          Expanded(child: InkWell(
                            onTap: ()async{

                              _homePageProvider.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
                            },
                            child: Icon(Icons.chevron_right,color: Colors.grey,))),


                      ],
                    ),
                  ),
                ),
              )


            ],
          ): Stack(
            children: [
              Center(
                child: InkWell(
                  onTap: ()async{
                    _homePageProvider.filterIsClear();

                    await _homePageProvider.checkFilter2();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    height: 405.0.h,
                    width: 90.0.w,

                    child: Container(
                      decoration:
                      BoxDecoration(
                          boxShadow: [const BoxShadow(color: Colors.black38,offset: Offset(-3,3),blurRadius: 20)],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child:Container(
                        child: const Center(child: Text(' Bu özellikleri barındıran bir park bulunamadı \n Filtre seçeneklerini sıfırlamak için tıklayınız.',style: TextStyle(color: Colors.grey),)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
