import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/authenticate/loading.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );


    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'DoneKardo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Loading(),
      ),
    );
  }
}
