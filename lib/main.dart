import 'package:flutter/material.dart';
import 'package:login_with_frebase/screens/homescreen.dart';
import 'package:login_with_frebase/screens/loginscreen.dart';
import 'package:login_with_frebase/screens/signupscr.dart';
import 'package:provider/provider.dart';
import 'package:login_with_frebase/modules/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Auth())],
      child: MaterialApp(
        title: "LOgin with Firebase",
        theme: ThemeData.dark(),
        home: LoginScr(),
        routes: {
          SignupScr.routeName: (ctx) => SignupScr(),
          LoginScr.routeName: (ctx) => LoginScr(),
          HomeScr.routeName: (ctx) => HomeScr(),
        },
      ),
    );
  }
}
