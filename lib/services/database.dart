import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference location = Firestore.instance.collection('locate');

  Future updateUserData(String latitude, String longitude) async {
    return await location.document(uid).setData({
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
