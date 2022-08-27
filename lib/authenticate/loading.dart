import 'package:flutter/material.dart';
import 'dart:async';
import 'package:farmhouse_app/screen//wrapper.dart';
import 'package:farmhouse_app/loader.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {



  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Wrapper())));
  }
//  void initState() {
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Loader(),
//      body: Center(
//        child: Image.asset('assets/FBLOGO1.png'),
//      ),
    );
  }
}



