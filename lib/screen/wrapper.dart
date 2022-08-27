import 'package:farmhouse_app/loader.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/authenticate/authenticate.dart';
import 'package:farmhouse_app/screen/home.dart';
import 'package:provider/provider.dart';
import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either home or authenticate
    if (user == null){
      return Authenticate();
    } else {
      return StreamBuilder<User>(
        stream: DatabaseService(email: user.email).usersData,
        builder: (context,snapshot){

          User users = snapshot.data;

          if(snapshot.hasData){
            return Home(users: users,);
          }else{
            return Loader();
          }
          },
      );
    }
  }
}
