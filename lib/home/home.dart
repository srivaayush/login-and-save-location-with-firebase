import 'package:flutter/material.dart';
import 'package:login_with_frebase/curlocntimeA.dart';
import 'package:login_with_frebase/curlocntimeB.dart';
import 'package:login_with_frebase/modules/user_data.dart';
import 'package:login_with_frebase/services/auth.dart';
import 'package:login_with_frebase/services/database.dart';
import 'package:provider/provider.dart';

class Homme extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<userData>>.value(
      value: DatabaseService().locs,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HOME"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.SignOut();
                },
                icon: Icon(Icons.person),
                label: Text("LogOUT"))
          ],
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurLocAndTimeB()));
                },
                color: Colors.red,
                child: Text("Find & save Location at B"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurLocAndTimeA()));
                },
                color: Colors.red,
                child: Text("Find & save Location at A"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
