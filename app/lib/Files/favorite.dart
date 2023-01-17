import 'package:app/Files/favoriteposts.dart';
import 'package:app/Files/my_articles_me.dart';
import 'package:app/Files/privacy.dart';
import 'package:app/Files/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Home.dart';

class Favorite_Articles extends StatefulWidget {

  @override
  State<Favorite_Articles> createState() => _Favorite_ArticlesState();
}

class _Favorite_ArticlesState extends State<Favorite_Articles> {

  @override
  Widget build(BuildContext context) {

        final FirebaseAuth auth = FirebaseAuth.instance;
        final User? user = auth.currentUser;
        final uid = user!.uid;

  final Stream<QuerySnapshot> postStream = FirebaseFirestore.instance.collection('users/$uid/favorite').snapshots();


      Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }

    return Scaffold(

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
            centerTitle: true,
            title: Text("Favorite Articles",style: GoogleFonts.sourceSansPro(
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


      body: Scrollbar(
              isAlwaysShown: true,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // SizedBox(height: 35,),
                      
                      SizedBox(height: 20,),
                      
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                      stream: postStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong', style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15
                ),));
              }
                      
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(margin: EdgeInsets.only(top: 200),child: Center(child: CircularProgressIndicator()));
              }
                      
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map data = document.data()! as Map<String, dynamic>;
                  String id = document.id;
                  data["id"] = id;
                  return FavoritePost(data: data);
                }).toList(),
              );
                      },
                    ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            )

    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}