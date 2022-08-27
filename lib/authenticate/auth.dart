
import 'package:farmhouse_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin fb = FacebookLogin();


  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, username: user.displayName, photo: user.photoUrl) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  //sign in with Google
  Future signInWithGoogle() async{
    try{
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      print(account);
      if (account == null)
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      FirebaseUser user = res.user;
      print(user);
      await DatabaseService().updateUsersData(user.displayName, user.photoUrl, user.email);
      if(user == null)
        return false;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }



  Future signInFB() async {
    var fbLogin = FacebookLogin();
    final FacebookLoginResult result = await fbLogin.logIn(["email"]);
    print('......${result.status}');
    if(result.status == FacebookLoginStatus.loggedIn){
      final String token = result.accessToken.token;
      final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      await DatabaseService().updateUsersData(user.displayName, user.photoUrl, user.email);
      print('success');
    }else{
      print('try again');
    }
  }



  //sign in with email & pw
  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(user == null)
        return false;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }



  //register
  Future registerWithEmailAndPassword(String name,String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(user == null)
        return false;
      await DatabaseService().updateUsersData(name, 'https://blog.cpanel.com/wp-content/uploads/2019/08/user-01.png', email);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future passwordReset(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}

class User{

  final String photo;
  final String uid;
  final String email;
  final String username;

  User({this.uid, this.email, this.photo, this.username});
}