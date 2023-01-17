import 'dart:async';
import 'package:intl/intl.dart';
import 'package:app/Files/Login.dart';
import 'package:app/Files/favorite.dart';
import 'package:app/Files/my_articles_me.dart';
import 'package:app/Files/profile.dart';
import 'package:app/Files/privacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'dart:io';
import 'package:app/Files/posts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late int num;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String imagePath = "";
  final Stream<QuerySnapshot> postStream = FirebaseFirestore.instance.collection('posts').snapshots();

  image_picker() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image!.path;
    });

  }  

  submit() async { 

    if(FirebaseAuth.instance.currentUser == null){
      Navigator.of(context).pushNamed("/login");
    }
    else{
    try{

    DateTime date = DateTime.now();
    String dateFormat = DateFormat('dd-MM-yyyy').format(date);
    print(dateFormat);

    String title = titleController.text;
    String description = descriptionController.text;
    String time = timeController.text;

    String imageName = path.basename(imagePath);

    final storage = FirebaseStorage.instance;
    final ref = FirebaseStorage.instance.ref('/$imageName');
    File file = File(imagePath);
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    var profiledata = await db.collection('users').doc(auth.currentUser?.uid).get();

      await db.collection("posts").add({
        "time": time,
        "title": title,
        "description": description,
        "url": downloadURL,
        "date": dateFormat,
        "usersurl": profiledata['url'],
        "usersname": profiledata['username'],
        "userdes": profiledata['bio']

      });
    print(downloadURL);
    Timer.periodic(Duration(seconds: 1), (timer){
    Center(child: CircularProgressIndicator());
    });
    print("Posted Uploaded Successfully!");
    titleController.clear();
    descriptionController.clear();
    Navigator.of(context).pop();
    }
    catch(e){
      print("Error" + e.toString());
    }
    }
  }

  Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }

  int currentTab = 0;
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

            // FloatActionButton:
          
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return  AlertDialog(
                  insetPadding: EdgeInsets.only(left: 10,right: 10),
                  title: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black,),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom:10),
          child: Center(
              child: Text(
            "Create a new Article: ",
            style: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          )),
        ),
                  content: 
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [ 
                                      
                                        // SizedBox(height: 5,),
                                      
                                                            Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 400,
                                          height: 100,
                                          child: TextField(
                                            style: GoogleFonts.sourceSansPro(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                            ),
                                            controller: titleController,
                                            maxLength: 10000,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.title),
                                              label: Text(
                                                "Article Title: ",
                                                style: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              hintText: "Enter Article Title: ",
                                              helperText: "Title: ",
                                              helperStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey, fontWeight: FontWeight.bold),
                                              hintStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                                    ),
                                      
                                                          Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 400,
                                          height: 100,
                                          child: TextField(
                                            style: GoogleFonts.sourceSansPro(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                            ),
                                            controller: descriptionController,
                                            maxLength: 10000,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.description_outlined),
                                              label: Text(
                                                "Article Description: ",
                                                style: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              hintText: "Enter Article Description: ",
                                              helperText: "Description: ",
                                              helperStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey, fontWeight: FontWeight.bold),
                                              hintStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                                    ),

                                                          Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 400,
                                          height: 100,
                                          child: TextField(
                                            style: GoogleFonts.sourceSansPro(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                            ),
                                            controller: timeController,
                                            maxLength: 10000,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.timelapse),
                                              label: Text(
                                                "Article Time Duration: ",
                                                style: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              hintText: "Enter Maximum time to read this Article: ",
                                              helperText: "Time: ",
                                              helperStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey, fontWeight: FontWeight.bold),
                                              hintStyle: GoogleFonts.sourceSansPro(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                                    ),


                                      SizedBox(height:20),
                                      
                                        Center(
                                          child: Container(
                                            width: 278,
                                            height: 60,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black
                                              ),
                                              icon: Icon(Icons.file_upload, color: Colors.white,),
                                              onPressed: (){
                                                image_picker();
                                              },
                                              
                                              label: Text("Upload Photo", style: GoogleFonts.sourceSansPro(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15,
                                              ))
                                            )
                                          )
                                        ),
                                      
                                      
                                      SizedBox(height: 30,),
                                                    
                                        Center(
                                          child: Container(
                                            width: 278,
                                            height: 60,
                                            child: ElevatedButton.icon(
                                              icon: Icon(Icons.ads_click_outlined),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black
                                              ),
                                              onPressed: (){
                                                submit();
                                              },
                                              label: Text("Submit a Post", style: GoogleFonts.sourceSansPro(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15,
                                              ))
                                            )
                                          )
                                        ),
                                      
                                        SizedBox(height: 10,),
                                      
                                      
                                          ]),
                                      ],
                                    ),
                                  ));
              });
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.post_add_outlined,color: Colors.white),
          ),
          
          
            // AppBar:
          
            appBar: AppBar(
              backgroundColor: Colors.black,
                centerTitle: true,
                title: Text("Articles - Home",style: GoogleFonts.sourceSansPro(
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
          
        drawer: Scrollbar(
          isAlwaysShown: true,
          child: Drawer(
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
        ),
          
          
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
                  return Post(data: data);
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
                
                        ),
      ),
    );
  }
}
