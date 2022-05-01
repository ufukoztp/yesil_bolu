import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:urbanspaces/domain/models/comments.dart';
import 'package:urbanspaces/domain/repositories/firestore.dart';
import 'dart:ui' as ui;

import '../../costumcomponents/expansion_tile.dart';
import '../../domain/models/parks.dart';
//import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


abstract class HomePageProviderAbs{
  onMapCreated(controller);
  getParkList();
  setRating(String parkname,var uid ,double rating);
  moveCamera();
}

class HomePageProvider with ChangeNotifier implements HomePageProviderAbs{

  ///all park screen
  int _selectId=0;
  List<bool> _expansionChange=[];
  List<GlobalKey<AppExpansionTileState>> _expansionTileList2=[];


  List<bool> get expansionChange => _expansionChange;
  int get selectId => _selectId;
  List<GlobalKey<AppExpansionTileState>> get expansionTileList2 =>
      _expansionTileList2;

  set expansionTileList2(List<GlobalKey<AppExpansionTileState>> value) {
    _expansionTileList2 = value;
  }
  set selectId(int value) {
    _selectId = value;
    notifyListeners();
  }

  set expansionChange(List<bool> value) {
    _expansionChange = value;
  }

  ///check filter variables
  bool _spor=false;
  bool _engellidostu=false;
  bool _yemek=false;
  bool _wc=false;
  bool _kultureloge=false;
  bool _otopark=false;
  bool _oturmaalani=false;
  bool _basketboll=false;
  bool _sports_fields=false;
  bool _bicycle_path=false;
  bool _running_track=false;
  bool _wifi=false;


  late GoogleMapController _controller;
  List<Marker> _markers=[];
  late PageController _pageController;
  PanelController _panelController=PanelController();

  ///TO-DO:KIYASLANICAK
  List<String> _filterList=[];
  
  ///filter ui'deki filter title'larını tutuyor
  List<String> filter=[];
///parklist gereksiz değiştirilecek
  List<Parks> _parkList=[];
  List<Parks> _park=[];
  List<CommentModel> _comments=[];

  List<CommentModel> get comments => _comments;

  set comments(List<CommentModel> value) {
    _comments = value;
   }

  GlobalKey<AppExpansionTileState> _expansionTileList=GlobalKey<AppExpansionTileState>();
  final Firestore _productRepository =  Firestore();


  FirebaseAuth auth =FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=GoogleSignIn();



  late User user;




  bool _isLoading=false;
  bool _detailvisiblity=false;
  bool _commentVisible=false;
  bool _menu_visibility=false;
  late bool userState;
  late bool _expansionState;

  bool get expansionState => _expansionState;



  int _parkListPosition=0;
   int _preview=0;
   double _ortRating=0.0;
  double _opacity=0.1;
  double _userRating=1;





  List<Parks> get park => _park;
  List<Parks> get parkList => _parkList;


   PanelController get panelController => _panelController;
  PageController get pageController => _pageController;
  GoogleMapController get controller => _controller;
  Firestore get productRepository => _productRepository;
  GlobalKey<AppExpansionTileState> get expansionTileList => _expansionTileList;
   List<Marker> get markers => _markers;

  List<String> get filterList => _filterList;
  double get opacity => _opacity;
  int get parkListPosition => _parkListPosition;
  int get preview => _preview;
  double get ortRating => _ortRating;
  double get userRating => _userRating;

  bool get isLoading => _isLoading;
  bool get commentVisible => _commentVisible;
  bool get detailvisiblity => _detailvisiblity;
  bool get menu_visibility => _menu_visibility;

  bool get engellidostu => _engellidostu;
  bool get otopark => _otopark;
  bool get kultureloge => _kultureloge;
  bool get oturmaalani => _oturmaalani;
  bool get yemek => _yemek;
  bool get running_track => _running_track;
  bool get wifi => _wifi;
  bool get bicycle_path => _bicycle_path;
  bool get sports_fields => _sports_fields;
  bool get spor => _spor;



  set filterList(List<String> value) {
    _filterList = value;
    notifyListeners();
  }



  set commentVisible(bool value) {
    _commentVisible = value;
    notifyListeners();
  }

  set panelController(PanelController value) {
    _panelController = value;
    notifyListeners();
  }

  set expansionState(bool value) {
    _expansionState = value;
    notifyListeners();
  }

  set park(List<Parks> value) {
    _park = value;
    notifyListeners();
  }


  bool get basketboll => _basketboll;

  set basketboll(bool value) {
    _basketboll = value;
    notifyListeners();
  }

  set menu_visibility(bool value) {
    _menu_visibility = value;
    notifyListeners();
  }

  set userRating(double value) {
    _userRating = value;
    notifyListeners();
  }


  set ortRating(double value) {
    _ortRating = value;
    notifyListeners();
  }


  set spor(bool value) {
    _spor = value;
    notifyListeners();
  }

  set engellidostu(bool value) {
    _engellidostu = value;
    notifyListeners();
  }


  set yemek(bool value) {
    _yemek = value;
    notifyListeners();
  }

  bool get wc => _wc;

  set wc(bool value) {
    _wc = value;
    notifyListeners();
  }

  set kultureloge(bool value) {
    _kultureloge = value;
    notifyListeners();
  }


  set otopark(bool value) {
    _otopark = value;
    notifyListeners();
  }


  set oturmaalani(bool value) {
    _oturmaalani = value;
    notifyListeners();
  }

  set controller(GoogleMapController value) {
    _controller = value;
    notifyListeners();
  }

  set parkListPosition(int value) {
    _parkListPosition = value;
  }

  set preview(int value) {
    _preview = value;
    notifyListeners();
  }


  set markers(List<Marker> value) {
    _markers = value;
    notifyListeners();
  }

  set expansionTileList(GlobalKey<AppExpansionTileState> value) {
    _expansionTileList = value;
    notifyListeners();
  }

  set pageController(PageController value) {
    _pageController = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set detailvisiblity(bool value) {
    _detailvisiblity = value;
    notifyListeners();
  }



  set opacity(double value) {
    _opacity = value;
    notifyListeners();
  }


  set parkList(List<Parks> value) {
    _parkList = value;
    notifyListeners();
  }

  set sports_fields(bool value) {
    _sports_fields = value;
    notifyListeners();

  }

  set bicycle_path(bool value) {
    _bicycle_path = value;
    notifyListeners();

  }


  set running_track(bool value) {
    _running_track = value;
    notifyListeners();

  }

  set wifi(bool value) {
    _wifi = value;
    notifyListeners();
  }

  
  setActivity(idenfitier,state){
    _productRepository.setActiviy(idenfitier, state);
    notifyListeners();
  }

  onMapCreated(controller)async{
    late BitmapDescriptor  mapMarker;
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(55, 55,),devicePixelRatio: 20),"asset/markeragac.png").then((value) {

      mapMarker=value;

      _controller=controller;
      List.generate(park.length, (index) async{
        LatLng coords=LatLng(double.parse(park[index].coords1!),double.parse(park[index].coords2!));
        markers.add(Marker(
            icon: mapMarker,
            markerId: MarkerId(park[index].title!),
            infoWindow: InfoWindow(onTap: ()async{
              await panelController.open();

            },title: park[index].title, snippet: park[index].description),
            position:coords));

      });
    });

    notifyListeners();
  }

  moveCamera()async {
    controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target:LatLng(double.parse(park[parkListPosition].coords1!),double.parse(park[parkListPosition].coords2!)),
            zoom: 14,bearing: 45,tilt: 45
        )));

  }

  moveCameraWithMarker(cords1,cords2) {
    controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target:LatLng(cords1,cords2),
            zoom: 14,bearing: 45,tilt: 45
        )));
  }

  Future getParkList()async{

    await _productRepository.getParkList(filterList: filterList).then((value) {
      print('parklist sonuç : '+value.length.toString());
      if(value!=null){
        park.clear();
        park=value;
      }
      if(park!=null){
        isLoading=true;
      }
    });

    notifyListeners();
  }

  Future setRating(String parkname,var uid ,double rating)async{
    await _productRepository.setRating(parkname, uid, rating);
  }
  
  Future getRating(String parkname)async{
    var d=await _productRepository.getRating(parkname);
    ortRating=d.isNaN==true?1:d;
    print(ortRating.toString()+"provider");
    notifyListeners();
  }

  Future getUserRating(String parkname,var uid)async{
    double d= await _productRepository.getuUserRating(parkname, uid);
    print(d.toString()+"user provider");
    if(d!=null){
      userRating=d;
    }
    notifyListeners();
  }

  Future sendComment(String text,String parkId)async{
    if(auth.currentUser!=null){
      await _productRepository.sendComment(text, parkId).then((value) {
       });
    }

  }
  Future deleteComment(String docId)async{
       await _productRepository.deleteComment(docId).then((value) {
       });
  }




  scroll()async{
    if(pageController.page!.toInt()!=preview){
      preview=pageController.page!.toInt();
      moveCameraWithMarker(double.parse(park[pageController.page!.toInt()].coords1!), double.parse(park[pageController.page!.toInt()].coords2!));
      await controller.showMarkerInfoWindow(MarkerId(park[pageController.page!.toInt()].title!));
      notifyListeners();
    }

  }

  Future checkFilter2()async {
    filterList.clear();
    parkList=park;
    if(otopark == true){
      filterList.add("otopark");
    }if(wc== true){
      filterList.add("tuvalet");
    }if(kultureloge== true){
      filterList.add("kultureloge");
    }if(engellidostu==true){
      filterList.add("engellidostu");
    }if(oturmaalani==true){
      filterList.add("oturmaalani");
    }if(yemek==true){
      filterList.add("yemeicme");
    }if(basketboll==true){
      filterList.add("basketball");
    }if(sports_fields==true){
      filterList.add("sporalani");
    }if(bicycle_path==true){
      filterList.add("bisikletyolu");
    }if(_running_track==true){
      filterList.add("kosuparkuru");
    }if(wifi==true){
      filterList.add("wifi");
    }
    await getParkList();
    onMapCreated;
    print(park.length);
    print("çalıştı");

    notifyListeners();

  }

  filterIsClear(){
    if(otopark== true){
      otopark=false;
    }if(wc== true){
      wc=false;
    }if(kultureloge== true){
      kultureloge=false;
    }if(engellidostu==true){
      engellidostu=false;
    }if(oturmaalani==true){
      oturmaalani=false;
    }if(yemek==true){
      yemek=false;
    }if(basketboll==true){
      basketboll=false;
    }if(sports_fields==true){
      sports_fields=false;
    }if(bicycle_path==true){
      bicycle_path=false;
    }if(running_track==true){
      running_track=false;
    }if(wifi==true){
      wifi=false;
    }
    notifyListeners();

  }

  Future signIn(context)async{
    GoogleSignInAccount? googleUser=await  googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =await googleUser!.authentication;
    AuthCredential credential =GoogleAuthProvider.credential(idToken: googleAuth.idToken,accessToken: googleAuth.accessToken);
    var response =await  auth.signInWithCredential(credential);

  }


}