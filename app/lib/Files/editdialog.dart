import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home.dart';
import 'Login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';

class EditDialog extends StatefulWidget {
  final Map data;
  EditDialog({required this.data});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String imagePath = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.data["title"];
    descriptionController.text = widget.data["description"];
  }

  @override
  Widget build(BuildContext context) {
    
    
    image_picker() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imagePath = image!.path;
      });
    }


    done() async {
      try {

        DateTime date = DateTime.now();
        String dateFormat = DateFormat('dd-MM-yyyy').format(date);
        print(dateFormat);


        FirebaseFirestore db = FirebaseFirestore.instance;
        String imageName = path.basename(imagePath);

        Reference ref = FirebaseStorage.instance.ref('/$imageName');
        File file = File(imagePath);
        await ref.putFile(file);
        String downloadURL = await ref.getDownloadURL();

        Map<String, dynamic> newPost = {
          "time": timeController.text,
          "title": titleController.text,
          "description": descriptionController.text,
          "url": downloadURL,
          "date": dateFormat,
        };

        await db.collection('posts').doc(widget.data['id']).set(newPost);

        Navigator.of(context).pop();
        print("Post Updated Successfully");
      } catch (e) {
        print("Errore: " + e.toString());
      }
    }

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black,),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom:10),
        child: Center(
            child: Text(
          "Edit Article",
          style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        )),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 350,
                  height: 100,
                  child: TextField(
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
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
                  width: 350,
                  height: 100,
                  child: TextField(
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
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

              SizedBox(height: 20),

              Center(
                  child: Container(
                      width: 278,
                      height: 60,
                      child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          icon: Icon(
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            image_picker();
                          },
                          label: Text("Upload Photo",
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ))))),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Container(
                      width: 278,
                      height: 60,
                      child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          icon: Icon(
                            Icons.done_outline_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            done();
                          },
                          label: Text("Done",
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ))))),
            ],
          ),
        ),
      ),
    );
  }
}
