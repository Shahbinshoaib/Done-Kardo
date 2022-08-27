import 'dart:io';

import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/screen/addFarmhouse.dart';
import 'package:farmhouse_app/screen/bestDealsList.dart';
import 'package:farmhouse_app/screen/contactPage.dart';
import 'package:farmhouse_app/screen/featuredList.dart';
import 'package:farmhouse_app/screen/homeList.dart';
import 'package:farmhouse_app/screen/queryDataScreen.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final User users;

  const Home({Key key, this.users}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();


  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;

    Future<void> _showlogoutDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to logout?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL', style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('LOGOUT', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.green[800],
                Colors.green,
              ])
      ),

      accountName: Text(widget.users.username),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        radius: 40.0,
        backgroundImage: NetworkImage(widget.users.photo),
        backgroundColor: Colors.transparent,
      ),
    );



    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;



    return StreamBuilder<List<QueryData>>(
        stream: DatabaseService().queryData,
        builder: (context, snapshot){

          List<QueryData> queryData2 = snapshot.data;

          if(snapshot.hasData){
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('DoneKardo'),
                    centerTitle: true,
                    actions: [
                      user.email == 'shahbinshoaib@gmail.com' || user.email == 'firebasedb786@gmail.com' || user.email == 'shahrukh_srk6@outlook.com' ?
                      IconButton(onPressed: (){
                        Navigator.of(context).push(AddFarmhouse1());
                      },
                          icon: Icon(Icons.add)
                      )
                          : Container(),
                      SizedBox(width: 10,)
                    ],
                  bottom: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab( text: "HOME",icon: Icon(Icons.home),),
                      Tab( text: "FEATURED",icon: Icon(Icons.featured_play_list)),
                      Tab( text: "BEST DEALS",icon: Icon(Icons.thumb_up_alt)),
                    ],
                  ),
                ),
                  body: TabBarView(
                    children: [
                      HomeList(),
                      FeaturedList(),
                      BestDealsList(),
                    ],
                  ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      drawerHeader,
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Logout'),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            _showlogoutDialog();
                          });
                        },
                      ),
                      user.email == 'shahbinshoaib@gmail.com' || user.email == 'firebasedb786@gmail.com' || user.email == 'shahrukh_srk6@outlook.com' ? ListTile(
                        leading: Icon(Icons.notifications_active),
                        title: Text('Query Data'),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: QueryDataScreen()));
                          });
                        },
                      ) : Container(),
                      ListTile(
                        leading: Icon(Icons.error),
                        title: Text('Contact us'),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: ContactPage()));
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Loader();
          }

        }

    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
class AddFarmhouse1 extends MaterialPageRoute<Null> {
  AddFarmhouse1()
      : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.green[800],
                    Colors.green,
                  ])
          ),
        ),
        title: Text('Add a new Farmhouse '),
      ),
      body: AddFarmhouse(),
    );
  });
}
