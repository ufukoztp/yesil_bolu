import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:urbanspaces/features/pages/account/profil_screen.dart';
import 'package:urbanspaces/features/pages/first_pages/init_language.dart';
import 'package:urbanspaces/costumcomponents/slide_left_route.dart';
import 'package:urbanspaces/features/pages/first_pages/onboarding_screen.dart';
import 'package:urbanspaces/features/pages/home/home_page.dart';
import 'package:urbanspaces/features/providers/profile_provider.dart';
import 'package:urbanspaces/utils/localization/bloc_localization.dart';

import 'package:firebase_core/firebase_core.dart';

import 'features/pages/activity/activity_screen.dart';
import 'features/pages/all_park_screen.dart';
import 'features/providers/activity_provider.dart';
import 'features/providers/home_provider.dart';

 void main() async{
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light// this one for iOS
   ));
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

   runApp(
       MultiProvider(providers: [
         ChangeNotifierProvider(create: (BuildContext context)=>HomePageProvider()),
         ChangeNotifierProvider(create: (BuildContext context)=>ActivityProvider())

       ],
         child: const UrbanSpaces() ,
       )

   ); }

class UrbanSpaces extends StatefulWidget {
  const UrbanSpaces({Key? key}) : super(key: key);
  @override
  _UrbanSpacesState createState() => _UrbanSpacesState();
}

class _UrbanSpacesState extends State<UrbanSpaces> with AfterLayoutMixin<UrbanSpaces> {
  @override
  void afterFirstLayout(BuildContext context) async{}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocLocalization>(
      create:(_)=> BlocLocalization(const Locale("en")),
      child: BlocBuilder<BlocLocalization, Locale>(
          builder:(context,locale){
            return Sizer(
                builder:(context,orientation,devicetype){
                  return  MaterialApp(
                    locale: locale,
                    debugShowCheckedModeBanner: false,
                    supportedLocales: const [Locale("en"), Locale("tr")],

                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],

                    theme: ThemeData(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    routes: {
                      "/": (context)=>const InitLanguage()
                    },

                    onGenerateRoute:(settings){

                      switch(settings.name){
                        case "/home":
                          return SlideLeftRoute(page: const HomePageScreen());
                          break;

                        case "/onboard":
                          return SlideLeftRoute(page: const IntroScreen());
                          break;


                        case "/activity":
                          return SlideLeftRoute(page: Activity_Screen());
                          break;

                        case "/allparks":

                          return SlideLeftRoute(page: AllPark());
                          break;


                        default:
                          return SlideLeftRoute(page:const InitLanguage());


                      }

                     },
                  );
                }
            );

          }
      ),
    );
  }

}

