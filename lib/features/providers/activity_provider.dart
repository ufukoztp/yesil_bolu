import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/models/activities.dart';
import '../../domain/repositories/firestore.dart';

abstract class ActivityProvider_abs{
   void saveUser({activity_uid});
  Future saveUid({activity_uid});
}

class ActivityProvider with ChangeNotifier implements ActivityProvider_abs{
  FirebaseAuth auth =FirebaseAuth.instance;

  String _select_type="hepsi";


  String get select_type => _select_type;

  set select_type(String value) {
    _select_type = value;
    notifyListeners();
  }

  Firestore repo=Firestore();

  int _selecteId=0;

  int get selecteId => _selecteId;

  set selecteId(int value) {
    _selecteId = value;
    notifyListeners();
  }

  List<Activity> _activities=[];

  List<Activity> get activities => _activities;

  set activities(List<Activity> value) {
    _activities = value;
  }


  @override
  Future saveUser({activity_uid}) async{
    await repo.saveUser(activity_uid: activity_uid,user_uid: auth.currentUser?.uid);
  }

  @override
  Future saveUid({activity_uid}) async{
    await repo.saveUid(activity_uid: activity_uid,user_uid: auth.currentUser?.uid);
  }

  @override
  Future getSubscribersUid({activity_uid}) async{
    await repo.getSubscribesUid(activity_uid: activity_uid);
  }

}