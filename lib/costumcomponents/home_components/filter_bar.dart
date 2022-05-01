import 'package:flutter/material.dart'
;

import '../../features/providers/home_provider.dart';
class FilterButton extends StatefulWidget {
  FilterButton({Key? key, required this.select,   required this.name1,  required this.homePageProvider, required this.index, required this.icon,
  }) : super(key: key);

  final String name1;
  final HomePageProvider homePageProvider;
  final int index;
  final IconData icon;
  bool select;


  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        switch(widget.index){
          case 0:
            widget.homePageProvider.oturmaalani==false?widget.homePageProvider.oturmaalani=true:widget.homePageProvider.oturmaalani=false;
            break;
          case 1:
            widget.homePageProvider.engellidostu==false?widget.homePageProvider.engellidostu=true:widget.homePageProvider.engellidostu=false;
            break;
          case 2:
            widget.homePageProvider.yemek==false?widget.homePageProvider.yemek=true:widget.homePageProvider.yemek=false;
            break;
          case 3:
            widget.homePageProvider.wc==false?widget.homePageProvider.wc=true:widget.homePageProvider.wc=false;
            break;
          case 4:
            widget.homePageProvider.kultureloge==false?widget.homePageProvider.kultureloge=true:widget.homePageProvider.kultureloge=false;
            break;
          case 5:
            widget.homePageProvider.otopark==false?widget.homePageProvider.otopark=true:widget.homePageProvider.otopark=false;
            break;
          case 6:
            widget.homePageProvider.basketboll==false?widget.homePageProvider.basketboll=true:widget.homePageProvider.basketboll=false;
            break;
          case 7:
            widget.homePageProvider.sports_fields==false?widget.homePageProvider.sports_fields=true:widget.homePageProvider.sports_fields=false;
            break;
          case 8:
            widget.homePageProvider.bicycle_path==false?widget.homePageProvider.bicycle_path=true:widget.homePageProvider.bicycle_path=false;
            break;
          case 9:
            widget.homePageProvider.running_track==false?widget.homePageProvider.running_track=true:widget.homePageProvider.running_track=false;
            break;

          case 10:
            widget.homePageProvider.wifi==false?widget.homePageProvider.wifi=true:widget.homePageProvider.wifi=false;
            break;
        }

        setState(() {

        });

      },
      child: Container(
        decoration: BoxDecoration(
            border:widget.select==true? Border.all(color: Colors.green): Border.all(color: Colors.white),
            boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(2,2),blurRadius: 10)],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        height: 50,
        width: 240,
        child:  Center(child: Padding(
          padding: const EdgeInsets.only(left:16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                  visible: widget.select==true?true:false,
                  child: const Icon(Icons.check,color: Colors.green)),
              Text(widget.name1,style: const TextStyle(fontSize: 10),),
              Container(
                  height: 40,
                  width: 40,
                  child: Icon(widget.icon,color: widget.select==false?Colors.grey:const Color(0xff00524E),))
            ],
          ),
        )),
      ),
    );
  }
}