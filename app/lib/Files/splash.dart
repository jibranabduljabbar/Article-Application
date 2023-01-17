import 'package:app/Files/Login.dart';
import 'package:app/home.dart';
import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage("assets/logo.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    child: Center(
                      child: Text("Welcome to the Article App", style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),),
                    )
                  ),
                  SizedBox(height: 140),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.all(20),
                    height: 100,
                    width: 410,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white
                      ),
                      icon: Center(child: Icon(Icons.arrow_right,color: Colors.black,size: 35,)),
                      label: Text(""),
                      onPressed: (){
                        Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom1"); 
                      }
                    ),
                  )
                ]
              ),
            ),
          ),
        )
      )
    );
  }
}