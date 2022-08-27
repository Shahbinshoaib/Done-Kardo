import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/screen/addFarmhouse.dart';
import 'package:farmhouse_app/screen/farmDetails.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  bool loader = false;
  bool _filterOn = false;
  bool _filterUsed = true;
  String _area ;
  String _price ;
  String _starting ;
  String _guest ;
  bool _wifi = false;
  bool _ac= false;
  bool _gym= false;
  bool _pool= false;
  bool _bar= false;
  bool _tv= false;
  bool _parking= false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return StreamBuilder<List<Farm>>(
      stream: DatabaseService().farmData,
      builder: (context,snapshot){
        if(snapshot.hasData){

          List<Farm> farm2 = snapshot.data;
          var farm =  farm2.where((p) => ('${p.category}').contains('Home')).toList();


          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(20.0, h*0.02, 20.0,h*0.015),
                child: ButtonTheme(
                  height: h*0.05,
                  child: RaisedButton(
                    onPressed: (){
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(farm2: farm),
                      );
                    },
                    elevation: 3.0,
                    splashColor: Colors.green,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(width: w*0.05,),
                            Text('Search',style: TextStyle(fontSize: 20.0),),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              _filterOn = !_filterOn;
                              //_filterUsed = true;
                            });
                          },
                          icon: Icon(Icons.filter_alt,color: Colors.green,),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              _filterOn ? Container(
                color: Colors.transparent,
                height: h*0.42,
                width: w*0.95,
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListBody(
                          children: <Widget>[
                            SizedBox(height: h*0.01,),
                            Text('Filter',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: w*0.47,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Select Area',
                                    ),
                                    value: _area,
                                    items: farm.map((categor) {
                                      return DropdownMenuItem(
                                        value: categor.area,
                                        child: Text('${categor.area.toString()}'),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _area = val;
                                        _filterUsed = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: w*0.35 ,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Price per head'
                                    ),
                                    value: _price,
                                    items: farm.map((beds) {
                                      return DropdownMenuItem(
                                        value: beds.price,
                                        child: Text('${beds.price.toString()}'),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _price = val;
                                        _filterUsed = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: w*0.47,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Starting from',
                                    ),
                                    value: _starting,
                                    items: farm.map((categor) {
                                      return DropdownMenuItem(
                                        value: categor.starting,
                                        child: Text('${categor.starting.toString()}'),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _starting = val;
                                        _filterUsed = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: w*0.35 ,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Guest Capacity'
                                    ),
                                    value: _guest,
                                    items: farm.map((beds) {
                                      return DropdownMenuItem(
                                        value: beds.guest,
                                        child: Text('${beds.guest.toString()}'),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _guest = val;
                                        _filterUsed = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h*0.02,),
                            Text('Amenities',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                            SizedBox(height: h*0.01,),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Free Wi-Fi'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._wifi = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _wifi,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('AC'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._ac = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _ac,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('GYM'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._gym = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _gym,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Pool'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._pool = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _pool,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('BAR'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._bar = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _bar,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('TV'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._tv = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _tv,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Parking'),
                                    Checkbox(
                                      onChanged: (bool value){
                                        setState(() {
                                          this._parking = value;
                                          _filterUsed = false;
                                        });
                                      },
                                      value: _parking,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                RaisedButton(
                                  child: Text('RESET',style: TextStyle(color: Colors.white),),
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      _area = null;
                                      _price = null;
                                      _starting = null;
                                      _guest = null;
                                      _wifi = false;
                                      _ac = false;
                                      _gym = false;
                                      _pool = false;
                                      _bar = false;
                                      _tv = false;
                                      _parking = false;
                                      _filterUsed = true;
                                      _filterOn = false;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Container(),
              Container(
                  height: _filterOn ? h*0.3 : h*0.706,
                  child: ListView.builder(
                    itemCount: farm.length,
                    itemBuilder: (context, index){
                      if(_filterUsed){
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                            child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      loader = true;
                                    });
                                    Navigator.of(context).push(AdminPanel1(farm[index]));
                                    setState(() {
                                      loader = false;
                                    });
                                  },
                                  splashColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset('assets/loading.gif',height: h*0.1,),
                                            Image.network(farm[index].pic1 ??  'https://i.pinimg.com/originals/a3/a7/f4/a3a7f4d0f800028e6aed6dae054744fd.gif',
                                              height: h*0.15,
                                              fit: BoxFit.fill,
                                              width: w*0.30,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.fromLTRB(w*0.03, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(farm[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.02,color: Colors.black),),
                                            width: w*0.6,),
                                            SizedBox(height: h*0.005,),
                                            Text(farm.toList()[index].area,style: TextStyle(fontSize: h*0.013,color: Colors.black45),),
                                            SizedBox(height: h*0.01,),
                                            farm.toList()[index].rating == '0' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                              ],
                                            ) : Container(),
                                            farm.toList()[index].rating == '1' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                              ],
                                            ) : Container(),
                                            farm.toList()[index].rating == '2' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                              ],
                                            ) : Container(),
                                            farm.toList()[index].rating == '3' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star_border,size: h*0.015,),
                                                Icon(Icons.star_border,size: h*0.015,),
                                              ],
                                            ) : Container(),
                                            farm.toList()[index].rating == '4' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star_border,size: h*0.015,),
                                              ],
                                            ) : Container(),
                                            farm.toList()[index].rating == '5' ?
                                            Row(
                                              children: [
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                              ],
                                            ) : Container(),
                                            SizedBox(height: h*0.025,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Guests: ${farm.toList()[index].guest}',style: TextStyle(fontSize: h*0.014,color: Colors.black45),),
                                                SizedBox(width: 10.0,),
                                                Text('RS: ${farm.toList()[index].price}/head',style: TextStyle(color: Colors.green,fontSize: h*0.015),),
                                              ],
                                            ),
                                            Text('Starting from: Rs.${farm.toList()[index].starting}/-',style: TextStyle(color: Colors.green,fontSize: h*0.014,letterSpacing: 1),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            )
                        );
                      }else{
                        if(farm.toList()[index].area == _area || farm.toList()[index].price == _price || farm.toList()[index].starting == _starting || farm.toList()[index].guest == _guest
                            || ((farm.toList()[index].wifi == _wifi && _wifi.toString() == 'true') || (farm.toList()[index].ac == _ac && _ac.toString() == 'true')
                                || (farm.toList()[index].gym == _gym && _gym.toString() == 'true') || (farm.toList()[index].pool == _pool && _pool.toString() == 'true')
                            || (farm.toList()[index].bar == _bar && _bar.toString() == 'true') || (farm.toList()[index].tv == _tv && _tv.toString() == 'true')
                                || (farm.toList()[index].parking == _parking && _parking.toString() == 'true'))){
                          return Padding(
                              padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                              child: Card(
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: FlatButton(
                                    onPressed: (){
                                      setState(() {
                                        loader = true;
                                      });
                                      Navigator.of(context).push(AdminPanel1(farm[index]));
                                      setState(() {
                                        loader = false;
                                      });
                                    },
                                    splashColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset('assets/loading.gif',height: h*0.1,),
                                              Image.network(farm[index].pic1 ??  'https://i.pinimg.com/originals/a3/a7/f4/a3a7f4d0f800028e6aed6dae054744fd.gif',
                                                height: h*0.15,
                                                fit: BoxFit.fill,
                                                width: w*0.30,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.fromLTRB(w*0.02, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(farm[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.022,color: Colors.black),),
                                                width: w*0.6,),
                                              SizedBox(height: h*0.005,),
                                              Text(farm.toList()[index].area,style: TextStyle(fontSize: h*0.013,color: Colors.black45),),
                                              SizedBox(height: h*0.01,),
                                              farm.toList()[index].rating == '0' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                ],
                                              ) : Container(),
                                              farm.toList()[index].rating == '1' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                ],
                                              ) : Container(),
                                              farm.toList()[index].rating == '2' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                ],
                                              ) : Container(),
                                              farm.toList()[index].rating == '3' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                ],
                                              ) : Container(),
                                              farm.toList()[index].rating == '4' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star_border,size: h*0.015,),
                                                ],
                                              ) : Container(),
                                              farm.toList()[index].rating == '5' ?
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                  Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                                ],
                                              ) : Container(),
                                              SizedBox(height: h*0.02,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Guests: ${farm.toList()[index].guest}',style: TextStyle(fontSize: h*0.014,color: Colors.black45),),
                                                  SizedBox(width: 10.0,),
                                                  Text('Rs: ${farm.toList()[index].price}/head',style: TextStyle(color: Colors.green,fontSize: h*0.015),),
                                                ],
                                              ),
                                              Text('Starting from: Rs.${farm.toList()[index].starting}/-',style: TextStyle(color: Colors.green,fontSize: h*0.014),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              )
                          );
                        }else{
                          return Container();
                        }

                      }

                    },
                  )
              ),
            ],
          );
        }else{
          return Loader();
        }
      },
    );
  }
}
class AdminPanel1 extends MaterialPageRoute<Null> {
  AdminPanel1(Farm farm)
      : super(builder: (BuildContext context) {
    final user = Provider.of<User>(context);

    Future<void> _showlogoutDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove Farmhouse'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to remove this farmhouse?'),
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
                child: Text('DELETE', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  DatabaseService().delFarmDocument(farm.category, farm.title);
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showEditDialog(Farm farm) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Farmhouse'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Add this Farmhouse again with updated changes keeping the Farmhouse title and category same.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel', style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Edit', style: TextStyle(color: Colors.red),),
                onPressed: ()  {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(AddFarmhouse1(farm));
                },
              ),
            ],
          );
        },
      );
    }

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
        title: Text('Details',),
        actions: [
          user.email == 'shahbinshoaib@gmail.com' || user.email == 'firebasedb786@gmail.com'
              ? IconButton(
            onPressed: (){
              _showEditDialog(farm);
            },
            icon: Icon(Icons.edit),
          ) : Container(),
          user.email == 'shahbinshoaib@gmail.com' || user.email == 'firebasedb786@gmail.com'
              ? IconButton(
            onPressed: (){
              _showlogoutDialog();
            },
            icon: Icon(Icons.delete),
          ) : Container(),
          SizedBox(width: 10,)
        ],
      ),
      body: FarmDetails(farm: farm,),
    );
  });
}
class AddFarmhouse1 extends MaterialPageRoute<Null> {
  AddFarmhouse1(Farm farm)
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
      body: AddFarmhouse(farm: farm,),
    );
  });
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Farm> farm2;

  CustomSearchDelegate({this.farm2});

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for the app bar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }


  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some result based on the selection
    return Container(
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            onTap: (){

            },
            title: Text('Not Found'),
            //onTap: () => Navigator.of(context).push(_NewPage2(2)),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something

    var farm =  farm2.where((p) => ('${p.title}${p.starting}${p.area}${p.guest}${p.price}${p.contact}${p.area}').toLowerCase().contains(query.toLowerCase())).toList();
    //final myList =  property.where((p) => p.price.contains(_amountfilter);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return farm.isEmpty? Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Text('Not found... '),
    ) : ListView.builder(
      itemCount:farm.length,
      itemBuilder: (context,index) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(AdminPanel1(farm[index]));

                  },
                  splashColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(farm[index].pic1 ??  'https://i.pinimg.com/originals/a3/a7/f4/a3a7f4d0f800028e6aed6dae054744fd.gif',
                          height: h*0.15,
                          fit: BoxFit.fill,
                          width: w*0.30,),
                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(w*0.03, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(farm[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.02,color: Colors.black),),
                              width: w*0.6,),
                            SizedBox(height: h*0.005,),
                            Text(farm.toList()[index].area,style: TextStyle(fontSize: h*0.013,color: Colors.black45),),
                            SizedBox(height: h*0.01,),
                            farm.toList()[index].rating == '0' ?
                            Row(
                              children: [
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                              ],
                            ) : Container(),
                            farm.toList()[index].rating == '1' ?
                            Row(
                              children: [
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                              ],
                            ) : Container(),
                            farm.toList()[index].rating == '2' ?
                            Row(
                              children: [
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                              ],
                            ) : Container(),
                            farm.toList()[index].rating == '3' ?
                            Row(
                              children: [
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star_border,size: h*0.015,),
                                Icon(Icons.star_border,size: h*0.015,),
                              ],
                            ) : Container(),
                            farm.toList()[index].rating == '4' ?
                            Row(
                              children: [
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star_border,size: h*0.015,),
                              ],
                            ) : Container(),
                            farm.toList()[index].rating == '5' ?
                            Row(
                              children: [
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                                Icon(Icons.star,size: h*0.015,color: Colors.yellow[700],),
                              ],
                            ) : Container(),
                            SizedBox(height: h*0.025,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Guests: ${farm.toList()[index].guest}',style: TextStyle(fontSize: h*0.014,color: Colors.black45),),
                                SizedBox(width: 10.0,),
                                Text('RS: ${farm.toList()[index].price}/head',style: TextStyle(color: Colors.green,fontSize: h*0.015),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
        );
      },

    );
  }

}


