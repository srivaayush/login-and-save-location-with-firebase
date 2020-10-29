// class HomeScr extends StatelessWidget {
//   static const routeName = '/home';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//         actions: <Widget>[
//           FlatButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacementNamed(LoginScr.routeName);
//               },
//               child: Row(children: <Widget>[
//                 Text("LogOut"),
//                 Icon(Icons.person),
//               ]))
//         ],
//       ),
//       body: Center(
//         child: Text(
//           "Home Screen!!!",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:login_with_frebase/screens/homescreen.dart';
import 'package:login_with_frebase/screens/loginscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_with_frebase/services/database.dart';

class HomeScr extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScrState createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  // This widget is the root of your application.
  String _loc = "";

  //Function to get current Location
  void _getCurLoc(String email) async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _loc =
          "Current Latitude : ${position.latitude}, \n Current Longitude: ${position.longitude}";
    });
    int p = 1;

    await DatabaseService(uid: email).updateUserData(
        position.latitude.toString(), position.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScr.routeName);
                },
                child: Row(children: <Widget>[
                  Text("LogOut"),
                  Icon(Icons.person),
                ]))
          ],
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(_loc),
                color: Colors.tealAccent,
              ),
              FlatButton(
                onPressed: () {
                  _getCurLoc("1");
                },
                color: Colors.amber,
                child: Text("Find Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
