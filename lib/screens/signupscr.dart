import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_with_frebase/modules/user.dart';
import 'package:login_with_frebase/modules/user_data.dart';
import 'package:login_with_frebase/screens/homescreen.dart';
import 'package:login_with_frebase/screens/loginscreen.dart';
import 'package:login_with_frebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:login_with_frebase/modules/auth.dart';

class SignupScr extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScrState createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _pwCon = new TextEditingController();

  Map<String, String> _authData = {'email': '', 'pass': ''};
  void _showErrorDialogue(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An Error Occured"),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(_authData['email'], _authData['pass']);

      _getCurLoc(_authData['email'].toString());
    } catch (error) {
      var errormsg = "Auth Failed. Try Again!";
      _showErrorDialogue(errormsg);

      // int p = 1;

      // await DatabaseService(uid: p.toString()).updateUserData('0.0.0', '0.0.0');
      // Navigator.of(context).pushReplacementNamed(HomeScr.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(LoginScr.routeName);
              },
              child: Row(children: <Widget>[
                Text("LogIn"),
                Icon(Icons.person),
              ]))
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 300.0,
                width: 300.0,
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: "email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return "Invalid Email!";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "password"),
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: _pwCon,
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return "Invalid Password";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: "confirm password"),
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || value != _pwCon.text) {
                                return "Invalid Password";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['pass'] = value;
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          RaisedButton(
                            child: Text('Sign Up'),
                            onPressed: () {
                              _submit();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

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
    await DatabaseService(uid: email).updateUserData(
        position.latitude.toString(), position.longitude.toString());

    Navigator.of(context).pushReplacementNamed(HomeScr.routeName);
  }
}
