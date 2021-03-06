import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'modules/user.dart';

// class CurLocAndTimeA extends StatefulWidget {
//   @override
//   _CurLocAndTimeAState createState() => _CurLocAndTimeAState();
// }

// class _CurLocAndTimeAState extends State<CurLocAndTimeA> {
//   String _loctime = "";

//   //Function to save data
//   void _saveLoc(String s) async {
//     final CollectionReference userCollection =
//         Firestore.instance.collection('Location');
//     final user = Provider.of<User>(context);
//     try {
//       final Map<String, dynamic> k =
//           (await userCollection.document(user.uid).get()).data;

//       String as = k['locDetail'];
//       as = as + "\n \t" + s;
//       print(s);
//       await userCollection.document(user.uid).setData({'locDetail': as});
//       print("Done");
//     } catch (e) {
//       // showInSnackBar(e.toString());
//       // print(e.toString());
//       // print(e.code);
//     }
//   }

//   //Function to get current Location
//   void _getCurLoc() async {
//     var dDay = new DateTime.now();
//     String daytimee = dDay.toString();
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print(position);
//     _loctime =
//         "Current :::::::: Lat : ${position.latitude}, Long: ${position.longitude}, Time: $daytimee       . \t from A";
//     // setState(() {
//     //   _loctime =
//     //       "Current :::::::: Lat : ${position.latitude}, Long: ${position.longitude}, Time: $daytimee       . \t from A";
//     // });
//     _saveLoc(_loctime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(" Current Location"),
//       ),
//       body: Align(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: Text(_loctime),
//               color: Colors.tealAccent,
//             ),
//             FlatButton(
//               onPressed: () {
//                 _getCurLoc();
//               },
//               color: Colors.amber,
//               child: Text("Find & save Location"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//------------------------------
class CurLocAndTimeA  {
  // String _loctime = "";
  static void saveLoc(String s, BuildContext context) async {
    final CollectionReference userCollection =
        Firestore.instance.collection('Location');
    final user = Provider.of<User>(context);
    try {
      final Map<String, dynamic> k =
          (await userCollection.document(user.uid).get()).data;

      String as = k['locDetail'];
      as = as + "\n \t" + s;
      print(s);
      await userCollection.document(user.uid).setData({'locDetail': as});
      print("Done");
    } catch (e) {
      // showInSnackBar(e.toString());
      // print(e.toString());
      // print(e.code);
    }
  }

  //Function to get current Location
  static void getCurLoc(BuildContext context) async {
    var dDay = new DateTime.now();
    String daytimee = dDay.toString();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    String loctime =
        "Current :::::::: Lat : ${position.latitude}, Long: ${position.longitude}, Time: $daytimee       . \t from A";
    // setState(() {
    //   _loctime =
    //       "Current :::::::: Lat : ${position.latitude}, Long: ${position.longitude}, Time: $daytimee       . \t from A";
    // });
    saveLoc(loctime, context);
  }

  
}
