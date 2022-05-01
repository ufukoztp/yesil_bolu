
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
 import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:urbanspaces/features/providers/profile_provider.dart';

import '../../utils/localization/app_localizations.dart';
import '../../utils/routes.dart';

class Profile_Widget extends StatefulWidget {
 final ProfilePageProvider profileProvider;


 const Profile_Widget({Key? key,   required this.profileProvider,}) : super(key: key);

  @override
  _Profile_WidgetState createState() => _Profile_WidgetState();
}

class _Profile_WidgetState extends State<Profile_Widget> {

/*
  _loadAsset({task,taskName,task2})async{
    List<String> responseLabel= [];

    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

    FirebaseVisionImage image =FirebaseVisionImage.fromFile(File(imageFile.path));
    ImageLabeler label =FirebaseVision.instance.imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.50));

    List<ImageLabel> labels= await label.processImage(image);

    for(ImageLabel label in labels){
      responseLabel.add(label.text);
    }

    responseLabel.forEach((element) {
      print(element);
      if(element==task){
        showDialog(context: context, builder:(context){
          return AlertDialog(
            title: Container(
              height: 30.0.h,
              width: 30.0.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("asset/tebrikler.png"),fit: BoxFit.cover)
              ),
            ),
            content: Padding(
              padding:  EdgeInsets.only(left:25.0.w),
              child: Text("Nice Work!",style: TextStyle(fontWeight: FontWeight.w700,fontSize:19),),
            ),

            actions: [
              Center(
                child: Padding(
                  padding:   EdgeInsets.only(left:6.0.w,right:1.0.w,bottom:20),
                  child: Text("We've added your rewars to your acount \n"
                      "After youe've finished gazing at your hardearned trophy \n"
                      "you can close this page by pressing done"
                  ),
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(right:15.0.w),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Center(child:Text("Done ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Color(0xff00524E),

                    ),
                    height: 60,
                    width: 200,
                  ),
                ),
              ),
            ],


          );
        }).then((value)async {
          await _profile_provider.setTaskState(uid: _user.uid,taskName: task);
          await _profile_provider.setLevel(uid: _user.uid,level: _profile_provider.userlevel);
        });
      }

      if(element==task2){
        showDialog(context: context, builder:(context){
          return AlertDialog(
            title: Container(
              height: 30.0.h,
              width: 30.0.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("asset/tebrikler.png"),fit: BoxFit.cover)
              ),
            ),
            content: Padding(
              padding:  EdgeInsets.only(left:25.0.w),
              child: Text("Nice Work!",style: TextStyle(fontWeight: FontWeight.w700,fontSize:19),),
            ),

            actions: [
              Center(
                child: Padding(
                  padding:   EdgeInsets.only(left:6.0.w,right:1.0.w,bottom:20),
                  child: Text("We've added your rewars to your acount \n"
                      "After youe've finished gazing at your hardearned trophy \n"
                      "you can close this page by pressing done"
                  ),
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(right:15.0.w),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Center(child:Text("Done ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Color(0xff00524E),

                    ),
                    height: 60,
                    width: 200,
                  ),
                ),
              ),
            ],


          );
        }).then((value)async {
          await _profile_provider.setTaskState(uid: _user.uid,taskName: task);
          await _profile_provider.setLevel(uid: _user.uid,level: _profile_provider.userlevel);
        });
      }
    });


  }



 */

     late ProfilePageProvider _profileProvider;

     late List rozetInfoPhoto;
     late List rozetInfoContent;
     late List rozetInfoTitle;


  @override
  void initState() {
    _profileProvider=widget.profileProvider;

    // TODO: DEMO VERSİYON ROZET LİST FİREBASE'E BAĞLANACAK
     rozetInfoPhoto=[];
    rozetInfoContent=[];
    rozetInfoTitle=[];
    rozetInfoPhoto.add("asset/kedigorevrozet.png");
    rozetInfoContent.add("En yakın yeşil alana gidip, minik dostlarımızı besleyin");
    rozetInfoTitle.add("Engelli Dostu");

    super.initState();
  }

  // TODO : WİDGET YAPISI GÖZDEN GEÇİRİLECEK
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:4.0.w,left: 2.0.w,right: 2.0.w ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:()async{
                            await showDialog(context: context,
                              builder: (context){
                                return  AlertDialog(
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
                                          child: Text("Çıkış yapmak istediğinize emin misiniz?",style: TextStyle(fontWeight: FontWeight.w700),),
                                        ),
                                        InkWell(
                                          onTap: ()async{
                                            await _profileProvider.auth.signOut();
                                            await _profileProvider.googleSignIn.signOut().then((value) {

                                              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.init_language, (route) => false);

                                            });

                                          },
                                          child: Container(
                                            child:Center(child: Text("ÇIKIŞ YAP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),)),
                                            width: MediaQuery.of(context).size.width,
                                            height: 60,
                                            color: Colors.green.shade700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(Icons.login,size: 30,color: Colors.red.shade900,)),
                      Text(_profileProvider.auth.currentUser!.email!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.clear,size: 20.0.sp,color: Colors.grey,))
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 17.0.h,
                        width: 32.0.w,
                        child: Image.asset("asset/avatar_daire.png",))),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                            image: NetworkImage(_profileProvider.auth.currentUser!.photoURL!,)

                        ),
                        borderRadius: BorderRadius.circular(100)),
                    height: 11.2.h,
                    width: 20.0.w,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            labelColor: Colors.grey,
              unselectedLabelColor: Colors.grey,

              indicator:UnderlineTabIndicator(borderSide: BorderSide(width: 0.8.w)) ,
              indicatorColor: Colors.black,
              controller: _profileProvider.tabController,
              tabs: [
                Container(
                    height: 6.0.h,
                    child: Center(child: Text(AppLocalizations.getString('profile'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),))),
                Container(
                    height: 6.0.h,
                    child: Center(child: Text(AppLocalizations.getString('basarimlar'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),))),
              ]),
          Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height-190,
            child: TabBarView(
              controller:  _profileProvider.tabController
              ,children: [
              Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.only(right: 7.0.w,top:5.0.h),
                        child: Text(AppLocalizations.getString('level')+'  '+_profileProvider.userlevel.toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),

                      ),
                    ],
                  ),
                  /*
                      Padding(padding: EdgeInsets.only(left: 4.8.w,top:0),
                      child:Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0),
                            child: Container(
                                height: 10.0.h,
                                width: 13.0.w,
                                child: Image.asset("asset/profil_fidan.png")),
                          ),
                          SizedBox(width: 8.0.w,),
                          Expanded(child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(2,2),blurRadius: 20)]
                            ),
                            child: GFProgressBar(
                              backgroundColor: Colors.white,
                              progressBarColor: Colors.green.shade600,
                              percentage: 0.2,
                              width: 63.0.w,
                              radius: 90,
                              lineHeight: 25,
                            ) ,
                          ),

                          ) ], ) ),
                      */
                  Padding(padding: const EdgeInsets.only(top:30,bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,right: 16),
                          child: Container(
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset("asset/YesilMarker.png")),
                                    const SizedBox(width: 20,),
                                    Text("0",style: TextStyle(fontSize: 40,color: Colors.green.shade900,fontWeight: FontWeight.w700),)
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text(AppLocalizations.getString('green_areas_discovered'),style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700),)
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black26,offset: Offset(2,2),blurRadius: 10)],

                                borderRadius: BorderRadius.circular(20)
                            ),
                            height: 20.0.h,
                            width: 43.0.w,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:6.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20,),

                                    Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset("asset/profil_dag.png")),
                                    SizedBox(width: 20,),
                                    Text(_profileProvider.userlevel.toString(),style: TextStyle(fontSize: 40,color: Colors.blue.shade900,fontWeight: FontWeight.w700),)
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(AppLocalizations.getString('completed_tasks'),style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700),)
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black26,offset: Offset(2,2),blurRadius: 10)],
                                borderRadius: BorderRadius.circular(20)
                            ),
                            height: 20.0.h,
                            width: 43.0.w,

                          ),
                        ),
                      ],
                    )
                    ,

                  ),

                  Padding(padding: EdgeInsets.only(left:20,right:13,top:30),
                      child:    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,

                            boxShadow: [BoxShadow(color: Colors.black26,offset: Offset(2,2),blurRadius: 10)],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: double.infinity,
                        height: 80,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _profileProvider.photoList.length,itemBuilder: (context,index)  {



                          return Padding(padding: EdgeInsets.all(10),
                              child:   Container(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey.withOpacity(0.6),

                                    ),

                                    height: 30,
                                    width: 60,
                                    child: Center(child: Icon(Icons.check,color: Colors.green,size: 30.0.sp,),)),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(_profileProvider.photoList[index].photo!,)
                                    ),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                height: 30,
                                width: 60,

                              )

                          );



                        }),

                      ))
                ],
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Column(
                      children: List.generate(_profileProvider.photoList.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left:7.0.w,right:7.0.w,top:7.0.w),
                          child:            Container(
                              child: Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height:70,
                                        width:70,
                                        child: Image.network(_profileProvider.photoList[index].photo!)),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding:  EdgeInsets.only(left:2.0.h),
                                      child: RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text:_profileProvider.photoList[index].title! +"\n",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),),
                                          TextSpan(text: _profileProvider.photoList[index].preview_description,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),

                                        ]
                                      )),
                                    ),
                                  ),


                                ],
                              ),
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(2,2),blurRadius: 10)]
                              ))
                          ,
                        );







                      })
                  ),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}
