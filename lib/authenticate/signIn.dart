import 'package:farmhouse_app/authenticate/signUp.dart';
import 'package:farmhouse_app/screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:farmhouse_app/loader.dart';
import 'package:page_transition/page_transition.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }


  bool loader = false;
  bool _showPassword = true;
  String email = '';
  String password = '';
  String error = '';
  String gError = '';



  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Future<void> _passwordResetDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Enter email to reset password'),
                  Form(
                    key: _formkey2,
                    child: Column(
                      children: [
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
                      ],
                    ),
                  )
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
                child: Text('Reset', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  await _auth.passwordReset(email);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return loader ? Loader() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: h*0.1),
              Image.asset('assets/Green.png',height: h*0.08,),
              Padding(
                padding: EdgeInsets.fromLTRB(w*0.1, h*0.05, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text('Sign in',style: TextStyle(color: Colors.green,fontSize: h*0.03,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
              ),
              SizedBox(height: h*0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                    buttonColor: Colors.white,
                    minWidth: w*0.4,
                    height: h*0.06,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                    child: RaisedButton(
                      child: Image.asset('assets/google2.png',height: h*0.03,),
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
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: Colors.indigo[900],
                    minWidth: w*0.4,
                    height: h*0.06,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                    child: RaisedButton(
                      child: Image.asset('assets/facebook.jpg',height: h*0.05,),
                      onPressed:  () async{
                        dynamic result = await _auth.signInFB();
                        print(result);
                        if (result == null){
                          setState(() {
                            gError = 'Could Not Sign In With Facebook';
                            loader = false;
                          });
                        } else{

                        }
                      }
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.03),
              Text('OR',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: h*0.02,color: Colors.black54),),
              SizedBox(height: h*0.03),
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
                          child: GestureDetector(
                            onTap: () async{
                              _passwordResetDialog();
                            },
                              child: Text('Forget Password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.018,color: Colors.green),))),
                      SizedBox(height: h*0.04),
                      ButtonTheme(
                        height: h*0.06,
                        minWidth: w*0.9,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text('Sign in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: h*0.028),),
                          onPressed: () async{
                            if(_formkey.currentState.validate()){
                              setState(() {
                                loader = true;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if (result == null){
                                setState(() {
                                  error = 'Incorrect credentials';
                                });
                              } else{
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
                          child: Text('Sign up',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: h*0.028),),
                          onPressed: (){
                            Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SignUpPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
