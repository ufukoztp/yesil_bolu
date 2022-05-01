import 'package:urbanspaces/domain/repositories/firestore.dart';

import '../models/parks.dart';

class UseCases{
Firestore _firestore=Firestore();

   Future<List<Parks>> getParkList({List<String>? filterlist}) async{
    return await _firestore.getParkList(filterList: filterlist);
  }

}