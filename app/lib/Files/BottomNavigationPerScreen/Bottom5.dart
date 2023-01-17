import 'package:flutter/material.dart';

import 'package:app/home.dart';
import 'package:app/Files/my_articles_me.dart';
import 'package:app/Files/favorite.dart';
import 'package:app/Files/privacy.dart';
import 'package:app/Files/profile.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottom5 extends StatefulWidget {
  const Bottom5({ Key? key }) : super(key: key);

  @override
  State<Bottom5> createState() => _Bottom5State();
}

class _Bottom5State extends State<Bottom5> {
  int _index = 0;
  final List<Widget> _tabs = [Terms_Conditions(),My_Articles_me(),Favorite_Articles(),Home(),Profile()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  
        BottomNavigationBar(
            selectedItemColor: Colors.white,
            selectedLabelStyle: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 11,
            ),
            unselectedLabelStyle: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 10
            ),
            unselectedItemColor: Color.fromARGB(255, 206, 206, 206),
            currentIndex: _index,
            onTap: (index) => setState(() {
              _index = index; 
            }),
            items: [
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 5.0),
                  child: Icon(Icons.privacy_tip_outlined),
                ),
                backgroundColor: Colors.black,
                label: "Terms & Conditions",
                ),
                const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 5.0),
                  child: Icon(Icons.article_outlined)
                ),
                label: "My Articles",
                ),const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 5.0),
                  child: Icon(Icons.favorite_border_outlined),
                ),
                label: "Favorite Article",
                ),const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 5.0),
                  child: Icon(Icons.home_outlined),
                ),
                label: "Home",
                ),const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 5.0),
                  child: Icon(Icons.perm_contact_cal_outlined),
                ),
                label: "Profile",
                ),
            ],
          ),
      
      body: _tabs[_index],
      
    );
  }
}