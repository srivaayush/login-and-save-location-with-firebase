import 'package:flutter/material.dart';
import 'package:login_with_frebase/modules/user.dart';
import 'package:login_with_frebase/screens/wrapper.dart';
import 'package:login_with_frebase/services/auth.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:login_with_frebase/modules/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Wrapper(),
      ),
    );
  }
}
