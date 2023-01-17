import 'package:app/Files/favoriteposts.dart';
import 'package:app/Files/seearticle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/Files/editdialog.dart';


class Post extends StatefulWidget {
  final Map data;
  Post({required this.data});
  

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {

  // void delete() async {
  //   try{
  //       final FirebaseAuth auth = FirebaseAuth.instance;
  //       final User? user = auth.currentUser;
  //       final uid = user!.uid;
  //     FirebaseFirestore db = FirebaseFirestore.instance;
  //     db.collection("users/$uid/favorite").doc(widget.data['id']).delete();
  //     print(data1['id']);
  //     print(widget.data['id']);
  //     // print(Details.data2);
  //   }
  //   catch(e){
  //     print(e.toString());
  //   }
  // }

  // void editpost(){
  //   showDialog(context: context, builder: (BuildContext context){
  //     return EditDialog(data: data);
  //   });
  // }


final FirebaseAuth auth = FirebaseAuth.instance;
        
  void favorite (data) async {
 
      if(FirebaseAuth.instance.currentUser == null){
        Navigator.of(context).pushNamed("/login"); 
      }
  else{
    final User? user = auth.currentUser;
        final uid = user!.uid;

        FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection("users/$uid/favorite").add({
        "time": data['time'],
        "title": data['title'],
        "description": data['description'],
        "url": data['url'],
        "date": data['date'],
        "usersurl": data['usersurl'],
        "usersname": data['usersname'],
        "userdes": data['userdes'],
        "count": 1
      });
    }
  }

    void seearticle(){
      Navigator.push(context,MaterialPageRoute(builder: (context) => See_Article(data1: widget.data)));
    }

    return Center(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom:30),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1),spreadRadius: 2,blurRadius: 3,offset: Offset(0, 1),)],
          borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300,width: 1)
        ),
        child: Column( 
          children: [

FirebaseAuth.instance.currentUser == null ? Container()
: ListTile(
  trailing: IconButton(icon: Icon(Icons.favorite_border_outlined), onPressed: (){
      favorite(widget.data);
  },),
),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.network(widget.data['url']) 
                          ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 8.0,left: 8.0,right: 8.0),
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  // color: Colors.black,
                ),
                child: Center(
                  child: Text(widget.data['title'], style: GoogleFonts.sourceSansPro(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 20
              ),),
                )),
            ),
            
Divider(
                  color: Colors.black,
                ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 8.0),
              child: Container(
                child: ListTile( 
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${widget.data['usersurl']}"),
                        radius: 18,
                      ),
                      // SizedBox(height: 1,),
                      Text("@ ${widget.data['usersname']}", style: GoogleFonts.sourceSansPro(
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
                        Text("${widget.data['date']}", style: GoogleFonts.sourceSansPro(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),),
                        
                        SizedBox(height: 15,),
                        Text("${widget.data['time']} read", style: GoogleFonts.sourceSansPro(
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
            SizedBox(height: 10,),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(child: Text(data['description'],style: GoogleFonts.sourceSansPro(
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 12
            //   ),)),
            // ),

Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10,top: 20),
                    width: 340,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Text(
                        "See Article",
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        seearticle();
                      },
                    ),
                  ),
                ),


// Center(
//                   child: Container(
//                     margin: EdgeInsets.only(left: 20, right: 20,top: 20),
//                     width: 340,
//                     height: 55,
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(primary: Colors.green),
//                       child: Text(
//                         "Edit",
//                         style: GoogleFonts.sourceSansPro(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       onPressed: () {
//                         editpost();
//                       },
//                     ),
//                   ),
//                 ),


//                           Center(
//                   child: Container(
//                     margin: EdgeInsets.only(left: 20, right: 20,top: 20),
//                     width: 340,
//                     height: 55,
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(primary: Colors.red),
//                       child: Text(
//                         "Delete",
//                         style: GoogleFonts.sourceSansPro(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       onPressed: () {
//                         deletepost();
//                       },
//                     ),
//                   ),
//                 ),
SizedBox(height: 10,),
          ],
        )
      ),
    );
  }
}