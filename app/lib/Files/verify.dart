import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Verify extends StatefulWidget {
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      CheckEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

      Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }

    return Scaffold(
      backgroundColor: Colors.black,
          
    // Drawer:

    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Container(
            // width: 100,            
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/header.png"),
                fit: BoxFit.cover
              )
            )
            )),

            SizedBox(height: 7,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom1");
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.home,color: Colors.grey[700]),
                  title: Text("Home", style: GoogleFonts.sourceSansPro(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom2");
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.article_outlined,color: Colors.grey[700]),
                  title: Text("My Articles", style: GoogleFonts.sourceSansPro(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,),
                        GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom3");
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.favorite_border_outlined,color: Colors.grey[700]),
                  title: Text("Favorite Articles", style: GoogleFonts.sourceSansPro(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom4");
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.person,color: Colors.grey[700]),
                  title: Text("Profile", style: GoogleFonts.sourceSansPro(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/bottom5");
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.privacy_tip_outlined,color: Colors.grey[700]),
                  title: Text("Terms & Conditions", style: GoogleFonts.sourceSansPro(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),
                        SizedBox(height: 16),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null ? "/login" : "/login");
              },
              child: Container(
                color: Colors.black,
                child: ListTile(
                  leading: Icon(FirebaseAuth.instance.currentUser == null ? Icons.login_outlined : Icons.logout_outlined,color: Colors.white),
                  title: Text(FirebaseAuth.instance.currentUser == null ? "Login" : "Logout", style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                ),
              ),
            ),

        ]
      ),
    ),

    // AppBar:
    
          appBar: AppBar(
            backgroundColor: Colors.black,
            shadowColor: Colors.white,
              centerTitle: true,
              title: Text("Articles - Verify Account",style: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18
              ),),
                          actions: [
              FirebaseAuth.instance.currentUser == null ?
              IconButton(icon: Icon(Icons.login_outlined,color: Colors.white,),onPressed: (){
                print("Login");
                Navigator.of(context).pushNamed('/login');
              },)
              :
              IconButton(icon: Icon(Icons.logout_outlined,color: Colors.white,),onPressed: (){
                print("Logout");
                Logout(context);
              },)
            ]),
    

      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white
          ),
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.all(20),
          child: Center(
            child: Text("An email has been sent to ${user.email} please verify!", style: GoogleFonts.sourceSansPro(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 15
            ),),
          )
        ),
      )
    );
  }

  Future<void> CheckEmailVerified() async{
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushNamed("/bottom1");
    }
    else{

    }
  }
}