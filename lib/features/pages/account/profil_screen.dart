/*
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:urbanspaces/features/providers/profile_provider.dart';

import '../../widgets/profile_widget.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>with TickerProviderStateMixin,AfterLayoutMixin {
  late ProfilePageProvider _pageProvider;
  @override
  void initState() {
    super.initState();
  }

  // TODO: taskstate devre dışı bırakılacak son düzenlemeden sonra

  @override
  Widget build(BuildContext context) {
    _pageProvider = Provider.of<ProfilePageProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Profile_Widget(
            profileProvider: _pageProvider)
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    // TODO: getting işlemleri gözden geçirelecek
    _pageProvider.auth = FirebaseAuth.instance;
    _pageProvider.pageController = PageController(initialPage: 1);
    _pageProvider.tabController = TabController(length: 2, vsync: this);
    /*
    _pageProvider.taskStateLoading=false;
    _pageProvider.getTaskPhoto(uid: _user.uid).then((value) {
      setState(() {

      });
    });
     print(_profile_provider.photoList.toString());
    await _pageProvider.getLevel(uid: _user.uid);
  }
     */
  }
}

 */