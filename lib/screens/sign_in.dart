// import 'package:geolocator/geolocator.dart';
// import 'package:login_with_frebase/home/home.dart';
// import 'package:login_with_frebase/screens/signupscr.dart';

// import 'package:flutter/material.dart';
// import 'package:login_with_frebase/services/database.dart';
// import 'package:provider/provider.dart';
// import 'package:login_with_frebase/modules/auth.dart';

// class LoginScr extends StatefulWidget {
//   static const routeName = '/login';
//   @override
//   _LoginScrState createState() => _LoginScrState();
// }

// class _LoginScrState extends State<LoginScr> {
//   final GlobalKey<FormState> _formkey = GlobalKey();

//   Map<String, String> _authData = {'email': '', 'pass': ''};

//   void _showErrorDialogue(String msg) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//               title: Text("An Error Occured"),
//               content: Text(msg),
//               actions: <Widget>[
//                 FlatButton(
//                     onPressed: () {
//                       Navigator.of(ctx).pop();
//                     },
//                     child: Text('Okay'))
//               ],
//             ));
//   }

//   Future<void> _submit() async {
//     if (!_formkey.currentState.validate()) {
//       return;
//     }
//     _formkey.currentState.save();

//     try {
//       await Provider.of<Auth>(context, listen: false)
//           .login(_authData['email'], _authData['pass']);
//       // _getCurLoc(_authData['email']);
//     } catch (error) {
//       var errormsg = "Auth Failed. Try Again!";
//       _showErrorDialogue(errormsg);
//       // _getCurLoc(_authData['email']);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Log In"),
//         actions: <Widget>[
//           FlatButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacementNamed(SignupScr.routeName);
//               },
//               child: Row(children: <Widget>[
//                 Text("SignUp"),
//                 Icon(Icons.person),
//               ]))
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.yellowAccent,
//                   Colors.redAccent,
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               child: Container(
//                 height: 260.0,
//                 width: 300.0,
//                 padding: EdgeInsets.all(16),
//                 child: Form(
//                     key: _formkey,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: <Widget>[
//                           TextFormField(
//                             decoration: InputDecoration(labelText: "email"),
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) {
//                               if (value.isEmpty || !value.contains('@')) {
//                                 return "Invalid Email!";
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _authData['emmail'] = value;
//                             },
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(labelText: "password"),
//                             obscureText: true,
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) {
//                               if (value.isEmpty || value.length < 5) {
//                                 return "Invalid Password";
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _authData['pass'] = value;
//                             },
//                           ),
//                           SizedBox(
//                             height: 30.0,
//                           ),
//                           RaisedButton(
//                             child: Text('LogIn'),
//                             onPressed: () {
//                               _submit();
//                             },
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(32)),
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // String _loc = "";

//   // //Function to get current Location
//   // void _getCurLoc(String email) async {
//   //   final position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);
//   //   print(position);

//   //   setState(() {
//   //     _loc =
//   //         "Current Latitude : ${position.latitude}, \n Current Longitude: ${position.longitude}";
//   //   });
//   //   await DatabaseService(uid: email).updateUserData(
//   //       position.latitude.toString(), position.longitude.toString());

//   //   Navigator.of(context).pushReplacementNamed(HomeScr.routeName);
//   // }
// }

import 'package:flutter/material.dart';
import 'package:login_with_frebase/services/auth.dart';
import 'package:login_with_frebase/shared/constants.dart';
import 'package:login_with_frebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = "";
  String pass = "";
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign in"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("SignUP"))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Valid Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) =>
                            val.length < 6 ? 'Enter Valid Password' : null,
                        onChanged: (val) {
                          setState(() => pass = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                          child: Text("Sign In"),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, pass);

                              if (result == null) {
                                setState(() {
                                  error = 'Please supply valid credentials';
                                  loading = false;
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
