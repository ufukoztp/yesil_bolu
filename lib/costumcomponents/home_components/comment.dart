import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:urbanspaces/costumcomponents/expansion_tile.dart';
import 'package:urbanspaces/domain/models/comments.dart';
import 'package:urbanspaces/features/providers/home_provider.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:urbanspaces/utils/localization/app_localizations.dart';

enum PageType{
  AllParks,
  HomePage
}

class Comment extends StatefulWidget {
  late HomePageProvider homePageProvider;
  late int? index;
  late PageType pageType;

  Comment({Key? key, required this.homePageProvider,required this.pageType,this.index}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> with AfterLayoutMixin<Comment>{
   late HomePageProvider _homePageProvider;
   late int index;
   GlobalKey<AppExpansionTileState> expansionKey =GlobalKey<AppExpansionTileState>();
   TextEditingController controller =TextEditingController();
   bool expansionState=false;



   @override
  void initState() {
    _homePageProvider=widget.homePageProvider;
    widget.pageType==PageType.HomePage?
    index=_homePageProvider.parkListPosition:
    index=widget.index!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommentModel>>(
      stream: _homePageProvider.productRepository.getComment(_homePageProvider.park[widget.pageType==PageType.HomePage?_homePageProvider.parkListPosition:widget.index!].title!),
      builder: (context, snapshot) {
        _homePageProvider.comments=snapshot.data??[];
        if(snapshot.hasData){
          return Column(
              children: [
                ///input comment
                Form(child:
                Container(
                  width:90.w ,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(left:3.0.w,right: 3.0.w),
                    child: TextFormField(
                      controller:controller,
                      keyboardAppearance: Brightness.dark,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(hintText: AppLocalizations.getString('have_an_idea'),border: InputBorder.none,
                        suffixIcon: Padding(
                          padding:  EdgeInsets.only(top:4.0.w),
                          child: InkWell(
                              onTap: ()async{
                                if(_homePageProvider.auth.currentUser==null){
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
                                                    _homePageProvider.signIn(context).then((value) => Navigator.pop(context));

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
                                      });
                                }else{
                                  await  _homePageProvider.sendComment(controller.text, _homePageProvider.park[index].title!);
                                  controller.clear();
                                }
                              },
                              child: Text(AppLocalizations.getString('share'),style: const TextStyle(color: Color(0xff00524E),fontWeight: FontWeight.w800,fontSize: 14),)),
                        ),
                      ),
                    ),
                  ),
                )),
                snapshot.hasData&&snapshot.data?.length!=0?
                widget.pageType==PageType.HomePage?
                Padding(
                  padding: EdgeInsets.only(top:5.0.w),
                  child: SingleChildScrollView(
                    child: Column(children: List.generate(_homePageProvider.comments.length, (index) {
                      return Column(
                        children: [
                          ListTile(
                              title:Text(_homePageProvider.comments[index].author!),
                              subtitle: Text(_homePageProvider.comments[index].text!),
                              leading: Container(
                                  height: 13.w,
                                  width: 13.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey.shade200,
                                      border: Border.all(color: Colors.grey.shade400)
                                  ),
                                  child: Icon(Icons.person)),

                              trailing: _homePageProvider.comments[index].authorId==_homePageProvider.auth.currentUser?.uid&&_homePageProvider.auth.currentUser!=null?
                              PopupMenuButton(itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(child: Text('Yorumu sil'),onTap: (){
                                    Future.delayed(
                                        const Duration(seconds: 0),
                                            () =>       showDialog(context: context,
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
                                                        child: Text("Silmek istediğinize emin misiniz?",style: TextStyle(fontWeight: FontWeight.w700),),
                                                      ),
                                                      InkWell(
                                                        onTap: ()async{
                                                          _homePageProvider.deleteComment(_homePageProvider.comments[index].docId!).then((value) {
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          child:Center(child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [

                                                              const Text("Sil",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
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
                                        ));



                                  },)

                                ];
                              },):null
                          ),
                          Divider()

                        ],
                      );

                    }),),
                  ),
                ):Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    collapsedIconColor: const Color(0xff00524E),
                    key: expansionKey,
                    title: Text('Yorumları gör (${snapshot.data!.length})',style: TextStyle(color: Colors.grey),),
                    children: [
                      Column(children: List.generate(_homePageProvider.comments.length, (index) {
                        return Column(
                          children: [
                            ListTile(
                              title:Text(_homePageProvider.comments[index].author!),
                              subtitle: Text(_homePageProvider.comments[index].text!),
                              leading: Container(
                                  height: 13.w,
                                  width: 13.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey.shade200,
                                      border: Border.all(color: Colors.grey.shade400)
                                  ),
                                  child: Icon(Icons.person)),
                              trailing: _homePageProvider.comments[index].authorId==_homePageProvider.auth.currentUser?.uid&&_homePageProvider.auth.currentUser!=null?
                              PopupMenuButton(itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(child: Text('Yorumu sil'),onTap: (){
                                    Future.delayed(
                                        const Duration(seconds: 0),
                                            () =>       showDialog(context: context,
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
                                                        child: Text("Silmek istediğinize emin misiniz?",style: TextStyle(fontWeight: FontWeight.w700),),
                                                      ),
                                                      InkWell(
                                                        onTap: ()async{
                                                          _homePageProvider.deleteComment(_homePageProvider.comments[index].docId!).then((value) {
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          child:Center(child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [

                                                              const Text("Sil",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
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
                                        ));



                                  },)

                                ];
                              },):null,
                            ),
                            Divider()

                          ],
                        );

                      }),),
                    ],
                  ),
                ):
                widget.pageType==PageType.HomePage?
                Padding(
                  padding:  EdgeInsets.only(top:8.0.w),
                  child: Center(child: Text('İlk yorum yapan ol!',style: TextStyle(color: Colors.grey),),),
                ):SizedBox(height: 4.0.w,)


              ]
          );
        }else{
          return Center(child: CircularProgressIndicator(color:Color(0xff00524E) ,),);
        }

      }
    );
  }

  @override
  void afterFirstLayout(BuildContext context)async {
   //await _homePageProvider.getComment(_homePageProvider.park[_homePageProvider.parkListPosition].title!);
   }
}
