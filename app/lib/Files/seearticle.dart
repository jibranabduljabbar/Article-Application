import 'dart:async';

import 'package:app/Files/editdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class See_Article extends StatefulWidget {
    final Map data1;
  See_Article({required this.data1});

  @override
  State<See_Article> createState() => _See_ArticleState();
}



class _See_ArticleState extends State<See_Article> {

      void deletepost() async {
    try{
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("posts").doc(widget.data1['id']).delete();
      Navigator.of(context).pop();
    }
    catch(e){
      print(e.toString());
    }
  }

  void editpost(){
    showDialog(context: context, builder: (BuildContext context){
      return EditDialog(data: widget.data1);
    });
  }

    Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
                  appBar: AppBar(
              backgroundColor: Colors.black,
                centerTitle: true,
                title: Text("Articles - ${widget.data1['title']}",style: GoogleFonts.sourceSansPro(
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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
            //   boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1),spreadRadius: 2,blurRadius: 3,offset: Offset(0, 1),)],
            //   borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.grey.shade300,width: 1)
            ),
            child: Column( 
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Text(widget.data1['title'], style: GoogleFonts.sourceSansPro(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),)),
                ),

                SizedBox(height: 13,),

  Container(
    margin: EdgeInsets.only(right: 240),
    child: Text("articles.com", style: GoogleFonts.sourceSansPro(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),),
  ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                  child: Divider(
                    color: Colors.grey
                  ),
                ),
                Container(
                  width: 315,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.network(widget.data1['url']) 
                            ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 10,top: 8.0,bottom: 8.0),
                  child: Container(child: Text(widget.data1['description'],style: GoogleFonts.sourceSansPro(
                    color: Color.fromARGB(255, 84, 83, 83),
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),)),
                ),
                      
                Padding(
                  padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                  child: Divider(
                    color: Colors.grey
                  ),
                ),

            Padding(
              padding: const EdgeInsets.only(top: 35.0,bottom: 8.0,right: 8.0),
              child: Container(
                child: ListTile( 
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${widget.data1['usersurl']}"),
                        radius: 18,
                      ),
                      // SizedBox(height: 1,),
                      Text("@ ${widget.data1['usersname']}", style: GoogleFonts.sourceSansPro(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 13
                      ),),
                    ],
                  ),

                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.data1['date']}", style: GoogleFonts.sourceSansPro(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),),
                        
                        SizedBox(height: 15,),
                        Text("${widget.data1['time']} read", style: GoogleFonts.sourceSansPro(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      
                    SizedBox(height: 10,)
              ],
            )
          ),
        ),
      )
        );
      } }   