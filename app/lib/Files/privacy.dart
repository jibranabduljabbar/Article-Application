import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms_Conditions extends StatefulWidget {
  const Terms_Conditions({ Key? key }) : super(key: key);

  @override
  State<Terms_Conditions> createState() => _Terms_ConditionsState();
}

class _Terms_ConditionsState extends State<Terms_Conditions> {
  @override
  Widget build(BuildContext context) {

      Logout (BuildContext  context){
  FirebaseAuth.instance.signOut();
  // FirebaseUser user = FirebaseAuth.instance.currentUser;
  Navigator.of(context).pushNamed('/login');
  }


    return Scaffold(

      // Drawer: 

          drawer: 
          Scrollbar(
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

            // AppBar:

        appBar: AppBar(
          backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("Terms & Conditions",style: GoogleFonts.sourceSansPro(
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0,right: 3,left: 3,bottom: 3,),
                child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading("Privacy Policy: "),
                Peragraph("JAJ Digital built the News Articles app as a Free app. This SERVICE is provided by JAJ Digital at no cost and is intended for use as is."),
                Peragraph("This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service."),
                Peragraph("If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy."),
                Peragraph("The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at General Knowledge unless otherwise defined in this Privacy Policy."),
                Heading("Information Collection and Use: "),
                Peragraph("For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to There are different Articles of their Category in this app . The information that we request will be retained by us and used as described in this privacy policy."),
                Peragraph("The app does use third-party services that may collect information used to identify you."),
                Peragraph("Link to the privacy policy of third-party service providers used by the app"),
                Peragraph("Google Play Services"),
                Peragraph("Facebook"),
                Peragraph("Log Data"),
                Peragraph("We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics."),
                Heading("Cookies: "),
                Peragraph("Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory."),
                Peragraph("This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service."),
                Heading("Service Providers: "),
                Peragraph("We may employ third-party companies and individuals due to the following reasons:"),
                Peragraph("To facilitate our Service;"),
                Peragraph("To provide the Service on our behalf;"),
                Peragraph("To perform Service-related services;"),
                Peragraph("or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose."),
                Heading("Security: "),
                Peragraph("We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."),
                Heading("Links to Other Sites: "),
                Peragraph("This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services."),
                Heading("Changes to This Privacy Policy: "),
                Peragraph("We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page."),
                Peragraph("This policy is effective as of 2022-01-13"),
                Heading("Contact Us: "),
                Peragraph("If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at jibran.jabbar06@gmail.com."),
                Heading("Follow Us: "),
                Button("Facebook", "https://www.facebook.com/stylish.jibran/",Colors.blue[600]),
                Button("Twitter", "https://twitter.com/JibranJabbar06",Colors.blue[400]),
                Button("LinkedIn", "https://www.linkedin.com/in/jibran-abdul-jabbar-249a66209/", Colors.blue[600]),
                Button("GitHub", "https://github.com/jibranabduljabbar", Color.fromARGB(255, 60, 60, 60)),
                Button("Youtube", "https://www.youtube.com/channel/UCYLh4RjXI6rNcFEeot1Rsuw", Colors.red[400]),
                Button("Instagram", "https://www.instagram.com/jibranabduljabbar/", Color(0xff3f729b)),
              ],
                )),
              ),
            ),
          ),
      )
    );
  }
}

Widget Heading(head) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(head,
        style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
  );
}

Widget Peragraph(pera) {
  return    Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pera,
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.black)),
              );

}

Widget Button(name, url, color){
  return                                         Container(
                              width: 365,
                              margin: EdgeInsets.only(right: 10,left: 10, bottom: 10, top: 20),
                              height: 55,
                              child: ElevatedButton.icon(
                                label: Text(
                                  "",
                                  style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                icon: name == "Facebook" ? Icon(FontAwesomeIcons.facebook ,color: Colors.white,) : name == "Twitter" ? Icon(FontAwesomeIcons.twitter ,color: Colors.white,) : name == "Youtube" ? Icon( FontAwesomeIcons.youtube ,color: Colors.white,) : name == "Instagram" ? Icon( FontAwesomeIcons.instagram , color: Colors.white,) : name == "LinkedIn" ? Icon( FontAwesomeIcons.linkedin ,color: Colors.white,) : name == "GitHub" ? Icon( FontAwesomeIcons.github ,color: Colors.white,) : Icon( FontAwesomeIcons.networkWired ,color: Colors.white,),
                                style: ElevatedButton.styleFrom(
                                  
                                  shape: RoundedRectangleBorder(
                                    
                                    borderRadius:
                                        BorderRadius.circular(3), // <-- Radius
                                  ),
                                  shadowColor: Colors.grey,
                                  primary: color,
                                  onPrimary: color,
                                  side: BorderSide(color: color, width: 3),
                                ),
                                onPressed: () {
                                  launch(url);
                                },
                              ),
                            );
}