import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login_with_frebase/modules/httpexception.dart';
import 'package:login_with_frebase/modules/user.dart';
import 'package:login_with_frebase/services/database.dart';

class Auth with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User _userfromfirebaseuser(String user) {
  //   return user != null ? User(uid: user) : null;
  // }

  // Stream<User> get user {
  //   return _auth.onAuthStateChanged.map();
  //   //.map((FirebaseUser user) => _userfromfirebaseuser(user));
  // }

  Future<void> signUp(String email, String pass) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDJXOjz2R7L3cg6_OSXy21gDYfL8jrOcYU';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': pass,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // await DatabaseService(uid: responseData['refreshToken'])
      //     .updateUserData('0.0.0', '0.0.0');

      // // _userfromfirebaseuser(responseData['refreshToken']);

      // print(responseData['refreshToken'].runtimeType);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String pass) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDJXOjz2R7L3cg6_OSXy21gDYfL8jrOcYU';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': pass,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // print(responseData);
    } catch (error) {
      throw error;
    }
  }
}
