import 'dart:io';
// import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

    String url = "";

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController usernameController = TextEditingController(text: "Jibran Abdul Jabbar");
    final TextEditingController emailController = TextEditingController(text: "jibran.jabbar06@gmail.com");
    final TextEditingController BioController = TextEditingController(text: "Article writer.");
    final TextEditingController phoneController = TextEditingController(text: "03182386144");
    final TextEditingController addressController = TextEditingController(text: "Karachi - Pakistan");
    final TextEditingController passwordController = TextEditingController(text: "12345678");

    String imagePath = "";


  Future image_pic() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image!.path;
    });
    String imageName = path.basename(imagePath);
    Reference ref = FirebaseStorage.instance.ref('/$imageName');
    final storage = FirebaseStorage.instance;
    File file = File(imagePath);
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    setState(() {
      url = downloadURL;
    });

    print("URL" + url);
    print("File Uploaded In Firebase Storage Successfully");

  }


    Future register() async {

      final String username = usernameController.text.trim();
      final String email = emailController.text.trim();
      final String bio = BioController.text.trim();
      final String phone = phoneController.text.trim();
      final String address = addressController.text.trim();
      final String password = passwordController.text.trim();


      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      try{
      final UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);

      DateTime date = DateTime.now();
      String dateFormat = DateFormat('dd-MM-yyyy').format(date);

      db.collection("users").doc(user.user?.uid).set({
        "username": username,
        "email": email,
        "bio": bio,
        "date": dateFormat,
        "phone": phone,
        "address": address,
        "url": url
      });

      print("URL: " + url);
      print("User is Succussfully Created!");

      Navigator.of(context).pushNamed('/verify');
      
      }
      catch(e){
        print("Error Occured!");
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Error: ",style: GoogleFonts.sourceSansPro(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900
            ),),
            content: Text(e.toString(),style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black,
            ),),
            actions: [
              // OK Button:

                Center(
                  child: Container(
                    // margin: EdgeInsets.all(20),
                    width: 340,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Text(
                        "OK",
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
            ],
          );
        });
      }
    } 

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
    
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
              title: Text("Articles - Registered Account",style: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17
              ),),
              actions: [
                IconButton(icon: Icon(Icons.more_vert,color: Colors.white,),onPressed: (){
                  print("More");
                },)
              ]),
    
    // Body
    
    
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
    
                  SizedBox(height: 33,),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(78),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.zero,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.grey.shade400
                          )
                        ]
                      ),
                      child: GestureDetector(
                        onTap: (){
                          image_pic();
                        },
                        child: CircleAvatar(
                          child: Text("Upload Profile", style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),),
                          backgroundColor: Colors.black,
                          radius: 80,
                        ),
                      ),
                    ),
                    ),
                  SizedBox(height: 20,),
    
    
                  // Username TextField:
    
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 350,
                      height: 100,
                      child: TextField(
                        controller: usernameController,
                        maxLength: 30,
                        autocorrect: true,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          label: Text(
                            "Username",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Username",
                          helperText: "@username",
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
    
                  // Email Address TextField:
    
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 350,
                      height: 100,
                      child: TextField(
                        controller: emailController,
                        maxLength: 320,
                        autocorrect: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text(
                            "Email Address: ",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Email Address: ",
                          helperText: "example@gmail.com",
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

                  // BIO TextField:
    
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 350,
                      height: 100,
                      child: TextField(
                        controller: BioController,
                        maxLength: 5000,
                        autocorrect: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text(
                            "BIO: ",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Bio: ",
                          helperText: "Articles writer.",
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


                  // Phone Number TextField:
    
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 350,
                      height: 100,
                      child: TextField(
                        controller: phoneController,
                        maxLength: 15,
                        autocorrect: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_outlined),
                          label: Text(
                            "Phone Number: ",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Phone Number: ",
                          helperText: "+923182323232",
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
    
                  // Address TextField:
    
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 350,
                      height: 100,
                      child: TextField(
                        controller: addressController,
                        maxLength: 95,
                        autocorrect: true,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          label: Text(
                            "Address",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Address: ",
                          helperText: "123 Main Street, New York, NY 10030",
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
    
                  // Password TextField:
    
                  Center(
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(10),
                      height: 100,
                      child: TextField(
                        controller: passwordController,
                        maxLength: 127,
                        obscureText: true,
                        autocorrect: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security_rounded),
                          label: Text(
                            "Password",
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter your Password: ",
                          helperText: "********",
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
    
    // Registered Button:
    
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left:20,right: 20,top: 20),
                      width: 340,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text(
                          "Register Account",
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        onPressed: () {
                          register();
                        },
                      ),
                    ),
                  ),
    
                  SizedBox(height: 25,),
    
                  TextButton(onPressed: (){
                      Navigator.of(context).pushNamed('/login');
                  }, child: Text("Already Registered Account? Login Here!", style: GoogleFonts.sourceSansPro(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 11
                  ),)),
    
                                  TextButton(onPressed: (){
                      Navigator.of(context).pushNamed('/bottom1');
                  }, child: Text("Skip - Home", style: GoogleFonts.sourceSansPro(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 11
                  ),)),
    
        SizedBox(height: 15,),

                ],
              ),
            ),
          )),
    );
  }
}
