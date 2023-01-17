
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;


class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

String username = "Username";
String email = "Email Address";
String bio = "BIO";
String phone = "Phone Number";
String address = "Location";
String url = "https://img.favpng.com/12/22/15/person-icon-png-favpng-3qfAUXKk4BC2zas4D2cC3HkKb.jpg";
String date = "11-10-2022";
String urlnew = "";
var work = "";


class _ProfileState extends State<Profile> {
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController urlController = TextEditingController();

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    if (vari.data()?['username'] == null) {
          setState(() {
      username = "Username";
      email = "example@gmail.com";
      bio = "Person Intro";
      phone = "+923111111111";
      address = "Karachi - Pakistan";
      url = "https://img.favpng.com/12/22/15/person-icon-png-favpng-3qfAUXKk4BC2zas4D2cC3HkKb.jpg";
      date = "11-10-2022";
          getData();
          run();
          setState(() {
            work = "Working";
          });          
    });  
    }

    
    else{
    setState(() {
      username = vari.data()?['username'];
      email = vari.data()?['email'];
      bio = vari.data()?['bio'];
      phone = vari.data()?['phone'];
      address = vari.data()?['address'];
      url = vari.data()?['url'];
      date = vari.data()?['date'];
    });  
    }    
  }

run (){
void initState(){
  getData();
  super.initState();
}
}

  void initState() {
    var timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getData();
    });
    super.initState();
  }

  @override
  void dispose() {
    var timer;
    timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

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
      urlnew = downloadURL;
    });

    print("URL" + urlnew);
    print("File Uploaded In Firebase Storage Successfully");

  }


Edit() async {

      final String eusername = usernameController.text;
      final String eemail = emailController.text;
      final String ebio = bioController.text;
      final String ephone = phoneController.text;
      final String eaddress = addressController.text;
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('dd-MM-yyyy').format(date);
      final String edate = dateFormat;

      if (eusername == "" || eemail == "" || ebio == "" || ephone == "" || eaddress == ""){
        showDialog(context: context, 
        builder: (context){
          return AlertDialog(
          title: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                      child: Text("Issues:", style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                      ),
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
          content: Center(
            child: Text("All Fields are Required!", style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black
                        ),),
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
      );}); 
      }
      else{
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      'username': eusername,
      'email': eemail,
      'bio': ebio,
      'phone': ephone,  
      'url': urlnew,
      'address': eaddress,
    });
  print("URL: " + urlnew);
    // getData();
      }
} 


  Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }
print(url);

    return Scaffold(
      body:  StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Container(child: CircularProgressIndicator()));
        }

        return ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map data = document.data()! as Map<String, dynamic>;
            return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black,
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(url),
                          ),
                        ), 
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0, top: 10,),
                        child: Container(
                          child: Text(username, style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 1,),
                        child: Container(
                          child: Text(email, style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Center(
                            child: Text(bio, style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Text(phone, style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10
                            ),
                          ),
                        ),
                      trailing: Text(address, style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10
                        ),
                      ),
                      ),
                                            Center(
                                              child: Container(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Center(child: Icon(Icons.watch_later, color: Colors.white)),
                                                      SizedBox(width: 10,),
                                                      Center(
                                                        child: Text("Joined on " + date, style: GoogleFonts.sourceSansPro(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w900,
                                                          fontSize: 15,
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                ) 
                                              ),
                                            ),
                      Container(
                                width: 365,
                                margin: EdgeInsets.only(right: 10,left: 10, bottom: 10, top: 20),
                                height: 55,
                                child: ElevatedButton.icon(
                                  label: Text(
                                    'Edit',
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  icon: Icon(Icons.edit_outlined,size: 15,color: Colors.black,),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0), // <-- Radius
                                    ),
                                    shadowColor: Colors.grey,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    side: BorderSide(color: Colors.white, width: 3),
                                  ),
                                  onPressed: () {
                                  showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                      child: Text("Edit Contact Info", style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                      ),
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
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
    
                        SizedBox(height: 10,),
                                Container(
                            width: 330,
                            child: TextField(
                              controller: usernameController,
                              style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black
                                  ),
                              maxLength: 100,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Username: ",
                                  prefixIcon: Icon(Icons.person_pin_rounded),
                                  hintText: "Username...",
                                  hintStyle:
                      GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white
                                  ),),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 330,
                            child: TextField(
                              controller: emailController,
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
                    fontSize: 10,
                    color: Colors.white
                                  ),),
                            ),
                          ),
                                  SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 330,
                            child: TextField(
                              controller: bioController,
                              style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black
                                  ),
                              maxLength: 5000,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "BIO: ",
                                  prefixIcon: Icon(Icons.info_outline_rounded),
                                  hintText: "BIO...",
                                  hintStyle:
                      GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white
                                  ),),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 330,
                            child: TextField(
                              controller: phoneController,
                              style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black
                                  ),
                              maxLength: 100,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Contact No: ",
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: "+923111111111",
                                  hintStyle:
                      GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white
                                  ),),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 330,
                            child: TextField(
                              controller: addressController,
                              style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black
                                  ),
                              maxLength: 100,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Address: ",
                                  prefixIcon: Icon(Icons.location_city),
                                  hintText: "Karachi - Pakistan",
                                  hintStyle:
                      GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white
                                  ),),
                            ),
                          ),
                  
                          SizedBox(
                            height: 35,
                          ),
                  
                  
                      ],
                    ),
                  ),
                  actions: [
                            Container(
          width: 300,
          height: 45,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Edit();
  Timer.periodic(Duration(seconds: 1), (Timer t) => { 
getData(),
run(),
setState(() {
  work = "Working";  
})
  });
  },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                "Update",
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
                                  },
                                ),
                              ),
                    ],
                  )
              ),
              ),
            ),
          ),
        );
          }).toList(),
        );
      },
    ),
              
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
            title: Text("Articles - Profile",style: GoogleFonts.sourceSansPro(
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
                );
  }
}