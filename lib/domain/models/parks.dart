import 'package:google_maps_flutter/google_maps_flutter.dart';

class Parks{
 String? description="";
 String? title="";
 String? photo="";
 String? coords1="";
 String? coords2="";
 bool? sporalani=false;
 bool? engellidostu=false;
 bool? wifi=false;
 bool? kultureloge=false;
 bool? otopark=false;
 bool? oturmaalani=false;
 bool? tuvalet=false;
 bool? yemeicme=false;
 bool? basketbol=false;
 bool? bisikletyolu=false;
 bool? kosuparkuru=false;

  Parks({ this.description, this.photo,  this.title,  this.coords2,  this.coords1});


  Parks.fromJsonMap(Map<String, dynamic> map):
        title = map["title"],
  description=map["description"],
        coords1 = map["coords1"],
        coords2 = map["coords2"],
        photo = map["photo"],
        tuvalet = map["tuvalet"]??false,
        yemeicme = map["yemeicme"]??false,
        basketbol = map["basketball"]??false,
        bisikletyolu = map["bisikletyolu"]??false,
        kosuparkuru = map["kosuparkuru"]??false,
        oturmaalani = map["oturmaalani"]??false,
        otopark = map["otopark"]??false,
        kultureloge = map["kultureloge"]??false,
        engellidostu = map["engellidostu"]??false,
        wifi = map["wifi"]??false,
        sporalani = map["sporalani"]??false;

 Map<String, dynamic> toJson() => {
  "title": title,
  "description": description,
  "coords1": coords1,
  "coords2": coords2,
  "tuvalet": true,
  "yemeicme": true,
  "basketbol": true,
  "bisikletyolu": true,
  "kosuparkuru": true,
  "oturmaalani": true,
  "kultureloge": false,
  "engellidostu": true,
  "wifi": false,
  "sporalani": false,

  };

}





