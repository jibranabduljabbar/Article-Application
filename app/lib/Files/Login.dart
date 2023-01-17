import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController(text: 'hayyanabduljabbar1@gmail.com');
    final TextEditingController passwordController = TextEditingController(text: '12345678');
    final TextEditingController femailController = TextEditingController();
    forg() async {        
      final String eemail = femailController.text;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: eemail);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                      child: Text("Alert", style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                      ),
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text("Reset code has been send to your email address!", style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                  actions: [
                                        Container(
          width: 300,
          height: 45,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                "OK",
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white
                ),
              ),),
        ),

                  ],
        );
      });
    }

    void forgot() async {
    showDialog(context: context, 
      builder: (context) {
        return AlertDialog(
          title: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                      child: Text("Forgot Password:", style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                      ),
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
          content:         SingleChildScrollView(
            child: Container(
            width: 330,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: femailController,
                    style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black
                        ),
                    maxLength: 100,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email Address: ",
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email Address...",
                        hintStyle:
                            GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                        ),),
                  ),
                ),
              ],
            ),
                  ),
          ),
          actions: [
                    Center(
                      child: Container(
          width: 210,
          margin: EdgeInsets.only(right: 4),
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                forg();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                "Forgot Password",
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white
                ),
              ),),
        ),
                    ),
      SizedBox(height: 15,),
          ],
        );
      }
    );
    }


    Login() async {

      final String email = emailController.text;
      final String password = passwordController.text;

      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      try{
      final UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
      final DocumentSnapshot snapshot = await db.collection("users").doc(user.user!.uid).get();

      final data = snapshot.data() as Map<String, dynamic>;
        print("User is Logged In!");

        Navigator.of(context).pushNamed('/bottom1', arguments: data);

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

    // Drawer:

    drawer: 
    Drawer(
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
              title: Text("Articles - Login Account",style: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18
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
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                      backgroundColor: Colors.white,
                      radius: 80,
                    ),
                    ),
                  SizedBox(height: 20,),
    
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
    
// Forgotten Button: 

  Container(
    margin: EdgeInsets.only(left: 217),
    child: TextButton(
      child: Text("Forgot Password", style: GoogleFonts.sourceSansPro(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 13
      ),),
      onPressed: (){
        forgot();
      },
    ),
  ),

    // Login Button:
    
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20,top: 20),
                      width: 340,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text(
                          "Login Account",
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        onPressed: () {
                          Login();
                        },
                      ),
                    ),
                  ),
    
                  SizedBox(height: 25,),
    
                  TextButton(onPressed: (){
                      Navigator.of(context).pushNamed('/register');
                  }, child: Text("Don't have an Account? Registered Here!", style: GoogleFonts.sourceSansPro(
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

