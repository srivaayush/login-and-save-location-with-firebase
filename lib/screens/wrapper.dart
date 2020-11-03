import 'package:flutter/material.dart';
import 'package:login_with_frebase/authenticate/authenticate.dart';
import 'package:login_with_frebase/home/home.dart';
import 'package:login_with_frebase/modules/user.dart';
import 'package:provider/provider.dart';
// import 'package:login_with_frebase/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null)
      return Authenticate();
    else
      return Homme();
  }
}
