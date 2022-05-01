import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanspaces/features/pages/first_pages/onboarding_screen.dart';
import 'package:urbanspaces/utils/localization/pref_language.dart';

import '../../../utils/localization/bloc_localization.dart';
import '../../../utils/routes.dart';


class InitLanguage extends StatefulWidget {
  const InitLanguage({Key? key}) : super(key: key);

  @override
  _InitLanguageState createState() => _InitLanguageState();
}

class _InitLanguageState extends State<InitLanguage> with AfterLayoutMixin<InitLanguage>{
  final FirebaseAuth _auth=FirebaseAuth. instance;

  Future  initLanguage() async {
    final String language = await PrefUtils.getLanguage();
      BlocProvider.of<BlocLocalization>(context).add(language.isNotEmpty?language == "tr" ? LocaleEvent.tr : LocaleEvent.tr:LocaleEvent.tr,
    );
  }

  @override
  void afterFirstLayout(BuildContext context)async {
    Future.delayed(Duration(seconds: 2)).then((value) async{
      await initLanguage().then((value) {
        if(_auth.currentUser==null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  IntroScreen()));
        }else{
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
    });




    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }


}
