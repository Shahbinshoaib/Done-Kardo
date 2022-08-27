import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QueryDataScreen extends StatefulWidget {


  @override
  _QueryDataScreenState createState() => _QueryDataScreenState();
}

class _QueryDataScreenState extends State<QueryDataScreen> {

  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog(QueryData query) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text(query.farmName,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            content: Container(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(query.pic,height: 150,),
                  SizedBox(height: 30,),
                  Text('Customer Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                  SizedBox(height: 15,),
                  Text(query.username),
                  SizedBox(height: 6,),
                  Text(query.email),
                  SizedBox(height: 6,),
                  Text(query.number),
                  SizedBox(height: 20,),
                  Text('Booking Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                  SizedBox(height: 6,),
                  Text('Date: ${query.selectedDate}'),
                  SizedBox(height: 6,),
                  Text('No. of guests: ${query.guests}'),
                  SizedBox(height: 6,),
                  Text('Time: ${query.time}'),
                  SizedBox(height: 10,),
                  Text('Submitted: ${query.date}'),
                ],
              ),
            )
          );
        },
      );
    }

    return StreamBuilder<List<QueryData>>(
      stream: DatabaseService().queryData,
      builder: (context,snapshot){
        if(snapshot.hasData){

          List<QueryData> query =snapshot.data;

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
              title: Text('User Queries'),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: query.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(query[index].pic),
                          title: Text(query[index].username,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text('${query[index].farmName} - ${query[index].selectedDate}'),
                          onTap: (){
                            _showMyDialog(query[index]);
                          },
                        ),
                        Divider()
                      ],
                    ),
                  );
                },
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
