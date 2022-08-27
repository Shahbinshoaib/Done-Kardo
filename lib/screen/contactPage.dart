import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Contact us'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: h*0.05,),
            Image.asset('assets/Green.png',width: w*0.8,),
            SizedBox(height: h*0.02,),
            Divider(),
            SizedBox(height: h*0.03,),
            Text('CONTACT DETAILS',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green[800],fontSize: 23,fontFamily: 'Ral')),
            SizedBox(height: h*0.03,),
            Container(
                child: Column(
              children: [
                Image.asset('assets/email.png',height: 50,),
                SizedBox(height: h*0.02,),
                Text('contact@donekardo.com',style: TextStyle(fontStyle: FontStyle.italic,letterSpacing: 2,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Ral'),),
              ],
            )),
            SizedBox(height: h*0.04,),
            Image.asset('assets/phone.png',height: 50,),
            SizedBox(height: h*0.02,),
            Text('Main headquarter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Ral')),
            SizedBox(height: h*0.02,),
            Text('+92 310 8019026',style: TextStyle()),
            SizedBox(height: h*0.04,),
            Image.asset('assets/phone.png',height: 50,),
            SizedBox(height: h*0.02,),
            Text('Alternate Contact #',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Ral')),
            SizedBox(height: h*0.02,),
            Text('+92 333 3270854',style: TextStyle()),
            SizedBox(height: h*0.02,),
            Text('+92 323 2236163',style: TextStyle()),
            SizedBox(height: h*0.05,),
          ],
        ),
      ),
    );
  }
}
