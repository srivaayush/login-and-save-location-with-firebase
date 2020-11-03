import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_with_frebase/home/locstile.dart';
import 'package:login_with_frebase/modules/user_data.dart';
import 'package:provider/provider.dart';

class LocAndTime extends StatefulWidget {
  @override
  _LocAndTimeState createState() => _LocAndTimeState();
}

class _LocAndTimeState extends State<LocAndTime> {
  @override
  Widget build(BuildContext context) {
    final locs = Provider.of<List<userData>>(context);

    // locs.forEach((loc) {
    //   print(loc.latitude);
    //   print(loc.longitude);
    //   print(loc.time);
    // });

    return Container();

    // return ListView.builder(
    //   itemCount: locs.length,
    //   itemBuilder: (context, index) {
    //     return LocsTile(loc: locs[index]);
    //   },
    // );
  }
}
