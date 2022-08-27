import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddFarmhouse extends StatefulWidget {
  final Farm farm;

  const AddFarmhouse({Key key, this.farm}) : super(key: key);

  @override
  _AddFarmhouseState createState() => _AddFarmhouseState();
}

class _AddFarmhouseState extends State<AddFarmhouse> {

  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }
  bool loader = false;
  String _category;
  String _pic1;
  String _pic2;
  String _pic3;
  String _pic4;
  String _pic5;
  String _pic6;
  String _pic7;
  String _pic8;
  String _pic9;
  String _pic10;
  String _title;
  String _address;
  String _details;
  String _price;
  String _starting;
  String _reviews;
  String _guests;
  bool _wifi = false;
  bool _wifi2;
  bool _ac = false;
  bool _ac2 ;
  bool _gym = false;
  bool _gym2;
  bool _pool = false;
  bool _pool2;
  bool _bar = false;
  bool _bar2;
  bool _tv = false;
  bool _tv2;
  bool _parking = false;
  bool _parking2 ;
  bool _dj = false;
  bool _dj2;
  bool _light = false;
  bool _light2;
  bool _drones = false;
  bool _drones2;
  bool posted = false;


  final List<String> category = [
    'Home','Featured','Best Deals'
  ];

  final List<String> rating = [
    '1','2','3','4','5'
  ];
  Future<void> _showMyDialog2() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('FARMHOUSE ADDED SUCCESSFULLY',style: TextStyle(color: Colors.green),textAlign: TextAlign.center,)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    dynamic currentTime = DateFormat.jm().format(DateTime.now());
    String _date = '$formattedDate - $currentTime';

    if(widget.farm == null){
      return loader ? Loader() :
      Container(
        color: Colors.white,
        height: h*0.916,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: h*0.01,),
                  Center(child: Text('Farmhouse Details',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),)),
                  SizedBox(height: h*0.01,),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    value: _category,
                    items: category.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text('$category'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _category = val;
                      });
                    },
                  ),
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic1 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 1',
                    ),
                    keyboardType: TextInputType.name,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  _pic1 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic2 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 2',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic2 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic3 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 3',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic3 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic4 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 4',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic4 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic5 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 5',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic5 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic6 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 6',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic6 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic7 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 7',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic7 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic8 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 8',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic8 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic9 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 9',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  _pic9 != null ?
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        _pic10 = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Picture link 10',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ) : Container(),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _title = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Farmhouse Title',
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val){
                      setState(() {
                        _address = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Area name',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _price = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Price per head',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _starting= val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Starting From',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _guests = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Guest Capacity',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _details = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Contact Details',
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: h*0.02,),
                  Text('Amenities',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._wifi = value;
                          });
                        },
                        value: _wifi,
                      ),
                      Text('Free Wi-Fi'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._ac = value;
                          });
                        },
                        value: _ac,
                      ),
                      Text('AC'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._gym = value;
                          });
                        },
                        value: _gym,
                      ),
                      Text('GYM'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._pool = value;
                          });
                        },
                        value: _pool,
                      ),
                      Text('Pool'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._bar = value;
                          });
                        },
                        value: _bar,
                      ),
                      Text('BAR'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._tv = value;
                          });
                        },
                        value: _tv,
                      ),
                      Text('TV'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._parking = value;
                          });
                        },
                        value: _parking,
                      ),
                      Text('Parking'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._dj = value;
                          });
                        },
                        value: _dj,
                      ),
                      Text('DJ Music'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._light = value;
                          });
                        },
                        value: _light,
                      ),
                      Text('Lightning & Smoke'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._drones = value;
                          });
                        },
                        value: _drones,
                      ),
                      Text('Drones'),
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Rating Stars',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    value: _reviews,
                    items: rating.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text('$category'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _reviews = val;
                      });
                    },
                  ),
                  SizedBox(height: h*0.02,),
                  ButtonTheme(
                    height: 40.0,
                    child: RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.green,
                      child: Text(posted ? 'POST' : 'SUBMIT',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                      elevation: 5.0,
                      onPressed: loader ? null : () async{
                        if (_formkey.currentState.validate()){
                          if(!posted){
                            setState(() {
                              posted = !posted;
                            });
                            await DatabaseService().updateFarmData(_category, _pic1??'', _pic2??'', _pic3??'', _pic4??'', _pic5??'', _pic6??'', _pic7??'', _pic8??'', _pic9??'', _pic10??'', _title, _address, _price,_starting, _guests, _details, _wifi, _ac, _gym, _pool, _bar, _tv, _parking,_dj,_light,_drones, _reviews, _date);
                          }else {
                            setState(() {
                              loader = true;
                            });
                            await DatabaseService().updateFarmPicData(_category, _pic1, _title,'1');
                            await DatabaseService().updateFarmPicData(_category, _pic2 , _title,'2');
                            await DatabaseService().updateFarmPicData(_category, _pic3, _title,'3');
                            await DatabaseService().updateFarmPicData(_category, _pic4 , _title,'4');
                            await DatabaseService().updateFarmPicData(_category, _pic5, _title,'5');
                            await DatabaseService().updateFarmPicData(_category, _pic6, _title,'6');
                            await DatabaseService().updateFarmPicData(_category, _pic7, _title,'7');
                            await DatabaseService().updateFarmPicData(_category, _pic8 , _title,'8');
                            await DatabaseService().updateFarmPicData(_category, _pic9 , _title,'9');
                            await DatabaseService().updateFarmPicData(_category, _pic10, _title,'10');
                            Navigator.pop(context);
                            _showMyDialog2();
                          }
                          setState(() {
                            loader = false;
                          });

                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }else{
      return loader ? Loader() :
      Container(
        color: Colors.white,
        height: h*0.916,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: h*0.01,),
                  Center(child: Text('Farmhouse Details',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),)),
                  SizedBox(height: h*0.01,),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    value:  _category ?? widget.farm.category,
                    items: category.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text('$category'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _category = val;
                      });
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _title = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Farmhouse Title',
                    ),
                    keyboardType: TextInputType.name,
                    initialValue: widget.farm.title,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val){
                      setState(() {
                        _address = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Area name',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    keyboardType: TextInputType.streetAddress,
                    initialValue: widget.farm.area,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _price = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Price per head',
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.farm.price,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _starting= val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Starting From',
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.farm.starting,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _guests = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Guest Capacity',
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.farm.guest,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    onChanged: (val){
                      setState(() {
                        _details = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Contact Details',
                    ),
                    keyboardType: TextInputType.multiline,
                    initialValue: widget.farm.contact,
                  ),
                  SizedBox(height: h*0.02,),
                  Text('Amenities',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._wifi2 = value;
                          });
                        },
                        value: _wifi2 ?? widget.farm.wifi,
                      ),
                      Text('Free Wi-Fi'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._ac2 = value;
                          });
                        },
                        value: _ac2?? widget.farm.ac,
                      ),
                      Text('AC'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._gym2 = value;
                          });
                        },
                        value: _gym2?? widget.farm.gym,
                      ),
                      Text('GYM'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._pool2 = value;
                          });
                        },
                        value: _pool2 ?? widget.farm.pool,
                      ),
                      Text('Pool'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._bar2 = value;
                          });
                        },
                        value: _bar2 ?? widget.farm.bar,
                      ),
                      Text('BAR'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._tv2 = value;
                          });
                        },
                        value: _tv2 ?? widget.farm.tv,
                      ),
                      Text('TV'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._parking2 = value;
                          });
                        },
                        value: _parking2 ?? widget.farm.parking,
                      ),
                      Text('Parking'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._dj2 = value;
                          });
                        },
                        value: _dj2 ?? widget.farm.dj,
                      ),
                      Text('DJ Music'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._light2 = value;
                          });
                        },
                        value: _light2 ?? widget.farm.light,
                      ),
                      Text('Lightning & Smoke'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value){
                          setState(() {
                            this._drones2 = value;
                          });
                        },
                        value: _drones2 ?? widget.farm.drones,
                      ),
                      Text('Drones'),
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Rating Stars',
                    ),
                    validator: (val) => val.isEmpty ? 'Required' : null,
                    value: _reviews ?? widget.farm.rating,
                    items: rating.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text('$category'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _reviews = val;
                      });
                    },
                  ),
                  SizedBox(height: h*0.02,),
                  ButtonTheme(
                    height: 40.0,
                    child: RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.green,
                      child: Text(posted ? 'POST' :'SUBMIT',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                      elevation: 5.0,
                      onPressed: loader ? null : () async{
                        print(_category);
                        if (_formkey.currentState.validate()){
                          setState(() {
                            loader = true;
                          });
                            await DatabaseService().updateFarmData(_category ?? widget.farm.category, _pic1 ?? widget.farm.pic1, _pic2?? widget.farm.pic2, _pic3?? widget.farm.pic3, _pic4?? widget.farm.pic4, _pic5?? widget.farm.pic5, _pic6?? widget.farm.pic6, _pic7?? widget.farm.pic7, _pic8?? widget.farm.pic8, _pic9?? widget.farm.pic9, _pic10?? widget.farm.pic10, _title?? widget.farm.title, _address?? widget.farm.area, _price?? widget.farm.price,_starting?? widget.farm.starting, _guests?? widget.farm.guest, _details?? widget.farm.contact, _wifi2 ?? widget.farm.wifi, _ac2?? widget.farm.ac, _gym2?? widget.farm.gym, _pool2?? widget.farm.pool, _bar2?? widget.farm.bar, _tv2?? widget.farm.tv, _parking2?? widget.farm.parking,_dj2 ?? widget.farm.dj,_light2 ??widget.farm.light,_drones2 ?? widget.farm.drones, _reviews ?? widget.farm.rating, _date);
                            Navigator.pop(context);
                            _showMyDialog2();
                            setState(() {
                              loader = false;
                            });
                          }
                          }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
