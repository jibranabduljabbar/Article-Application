import 'package:app/Files/BottomNavigationPerScreen/Bottom1.dart';
import 'package:app/Files/BottomNavigationPerScreen/Bottom2.dart';
import 'package:app/Files/BottomNavigationPerScreen/Bottom3.dart';
import 'package:app/Files/BottomNavigationPerScreen/Bottom5.dart';
import 'package:app/Files/BottomNavigationPerScreen/Bottom4.dart';
import 'package:app/Files/Login.dart';
import 'package:app/Files/favorite.dart';
import 'package:app/Files/my_articles_me.dart';
import 'package:app/Files/privacy.dart';
import 'package:app/Files/profile.dart';
import 'package:app/Files/splash.dart';
import 'package:flutter/material.dart';
import 'Files/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'Files/verify.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Center(child: Container(child: Text("Error Occured!"),));
        }

        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: {
        "/home": (context) => Home(),
        "/login" : (context) => Login(),
        "/register":(context) => Register(),
        "/splash": (context) => Splash(),
        "/verify": (context) => Verify(),
        "/profile": (context) => Profile(),
        "/privacy":(context) => Terms_Conditions(),
        "/my_articles": (context) => My_Articles_me(),
        "/favorite_articles": (context) => Favorite_Articles(),
        "/bottom1": (context) => Bottom1(), 
        "/bottom2": (context) => Bottom2(),
        "/bottom3": (context) => Bottom3(),
        "/bottom4": (context) => Bottom4(),
        "/bottom5": (context) => Bottom5(),
          
      }
          );
        }

return Center(child: Container(child: CircularProgressIndicator(),));

      },
    );

  }
}

class My_Articles {
}