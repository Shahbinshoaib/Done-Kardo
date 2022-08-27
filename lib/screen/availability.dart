import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Availability extends StatefulWidget {
  final String farmName;
  final String pic;
  final User user;

  const Availability({Key key, this.farmName,this.pic,this.user}) : super(key: key);

  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {


  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }


  String _selectedDate;
  String _guests;
  String _time;
  String _phone;
  bool loader = false;
  final List<String> guests = ['1 - 50',
  '51 - 100', '101 - 150','151 - 200','201 - 250','251 - 300','301 - 400', '401 - 450',
  '451 - 500', '501 - 600','601 - 700','701 - 800','801 - 900', '1000 +'];
  final List<String> time = ['Any','Lunch','Dinner'];

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _selectedDate = '${selectedDate.toLocal()}'.split(' ')[0];
        print(_selectedDate);

      });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);
    dynamic currentTime = DateFormat.Hms().format(DateTime.now());
    String _date = '$formattedDate - $currentTime';

    Future<void> _showMyDialog2() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('We will inform you soon about the availability, thank you',style: TextStyle(color: Colors.green),textAlign: TextAlign.center,)),
          );
        },
      );
    }

    return loader ? Loader() :
    StreamBuilder<User>(
      stream: DatabaseService(email: user.email).usersData,
      builder: (context,snapshot){
        if(snapshot.hasData){

          User users = snapshot.data;

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
              title: Text('Booking',),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton(
                      elevation: 5.0,
                      color: Colors.green,
                      onPressed: (){
                        _selectDate(context);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.date_range,color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Text('Select Date',style: TextStyle(color: Colors.white),),

                        ],
                      ),
                    ),
                    SizedBox(height: h*0.02,),
                    Text('Date Selected',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.02),),
                    SizedBox(height: h*0.02,),
                    Center(child: Text(_selectedDate ?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.04,fontStyle: FontStyle.italic,color: Colors.green),)),
                    SizedBox(height: h*0.02,),
                    Text('Guests',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.020),),
                    SizedBox(height: h*0.01,),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'No. of Guests',
                            ),
                            value: _guests,
                            items: guests.map((course) {
                              return DropdownMenuItem(
                                value: course,
                                child: Text('$course'),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _guests = val;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Preferred Time',
                            ),
                            value: _time,
                            items: time.map((time) {
                              return DropdownMenuItem(
                                value: time,
                                child: Text('$time'),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _time = val;
                              });
                            },
                          ),
                          SizedBox(height: h*0.02,),
                          TextFormField(
                            validator: _validateName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.smartphone),
                              labelText: 'Mobile Number',
                            ),
                            onChanged: (value){
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.03,),
                          ButtonTheme(
                            minWidth: w*0.9,
                            child: RaisedButton(
                              color: Colors.green,
                              child: Text('CHECK AVAILABILITY',style: TextStyle(color: Colors.white),),
                              onPressed: _selectedDate == null ? null : () async{
                                if(_formkey.currentState.validate()){
                                  setState(() {
                                    //loader = true;
                                  });
                                  await DatabaseService().updateQueryData(_selectedDate, _guests, _time, _phone, _date,users.email,users.username,widget.farmName,widget.pic);
                                  await DatabaseService().sendEmail('firebasedb786@gmail.com', widget.farmName, _selectedDate, _guests, _time, _phone, users.username, users.email);
                                  Navigator.pop(context);
                                  setState(() {
                                    loader = false;
                                  });
                                  _showMyDialog2();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }else{
          return Loader();
        }
      },
    );
  }
}
