import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_with_frebase/modules/user_data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference loc = Firestore.instance.collection('Location');

  Future<void> updateUserData() async {
    return await loc.document(uid).setData({
      'locDetail': ' ',
    });
  }

  List<userData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return userData(
        locDetail: doc.data['locDetail'] ?? '',
      );
    }).toList();
  }

  Stream<List<userData>> get locs {
    return loc.snapshots().map(_userListFromSnapshot);
  }
}
