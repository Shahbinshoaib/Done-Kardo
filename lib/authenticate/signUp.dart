import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }


  bool loader = false;
  bool _showPassword = true;
  String name;
  String email = '';
  String password = '';
  String error = '';
  String gError = '';



  Widget _buildLoginBtn() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          width: MediaQuery.of(context).size.width*0.5,
          child: GoogleSignInButton(
            splashColor: Colors.blue[300],
            onPressed: () async {
              setState(() {
                loader = true;
              });
              dynamic result = await _auth.signInWithGoogle();
              if (result == null){
                setState(() {
                  gError = 'Could Not Sign In With Google';
                  loader = false;
                });
              } else{

              }
            },
            // darkMode: true, // default: false
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          error,
          style: TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }

  // Widget _buildLoginBtn2() {
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
  //         width: MediaQuery.of(context).size.width*0.55,
  //         child: FacebookSignInButton(
  //           splashColor: Colors.teal,
  //           onPressed: () async{
  //             dynamic result = await _auth.signInFB().whenComplete(() {
  //               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()));
  //               });
  //             print(result);
  //             if (result == null){
  //               setState(() {
  //                 gError = 'Could Not Sign In With Facebook';
  //                 loader = false;
  //               });
  //             } else{
  //
  //             }
  //           }
  //           // darkMode: true, // default: false
  //         ),
  //       ),
  //       SizedBox(height: 10.0,),
  //       Text(
  //         error,
  //         style: TextStyle(color: Colors.red, fontSize: 14.0),
  //       ),
  //     ],
  //   );
  // }



  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return loader ? Loader() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: h*0.08),
                  Image.asset('assets/Green.png',height: h*0.08,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(w*0.1, h*0.04, 0, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Sign up',style: TextStyle(color: Colors.green,fontSize: h*0.03,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                  ),
                  SizedBox(height: h*0.04),
                  Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: _validateName,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.person),
                              labelText: 'Name',
                            ),
                            onChanged: (value){
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          TextFormField(
                            validator: _validateName,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                            ),
                            onChanged: (value){
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          TextFormField(
                            validator: _validateName,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: _showPassword,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.security),
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye,color: _showPassword ? Colors.grey : Colors.green,),
                                  onPressed: (){
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.04),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Forget Password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.018,color: Colors.green),)),
                          SizedBox(height: h*0.04),
                          ButtonTheme(
                            height: h*0.06,
                            minWidth: w*0.9,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                            child: RaisedButton(
                              color: Colors.green,
                              child: Text('Sign up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: h*0.028),),
                              onPressed: () async{
                                if(_formkey.currentState.validate()){
                                  setState(() {
                                    loader = true;
                                  });
                                  dynamic result = await _auth.registerWithEmailAndPassword(name,email, password);
                                  if (result == null){
                                    setState(() {
                                      error = 'Incorrect credentials';
                                    });
                                  } else{
                                    //await DatabaseService().updateUsersData(name, fName, gFName, surname, cnic, email, phone, address, password,'');
                                    Navigator.of(context).pop();
                                  }
                                  setState(() {
                                    loader = false;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(height: h*0.01,),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          SizedBox(height: h*0.01),
                          ButtonTheme(
                            height: h*0.06,
                            minWidth: w*0.9,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                            child: RaisedButton(
                              color: Colors.white,
                              child: Text('Sign in',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: h*0.028),),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.green,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
