import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/LoginPage.dart';
import 'package:rsa_app_official/RegisterPage.dart';
import 'package:rsa_app_official/MD_1.dart';
import 'package:rsa_app_official/MD_2.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "RSA",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
      '/loginPage' : (BuildContext context) => LoginPage(),
        '/registerPage' : (BuildContext context) => RegisterPage(),
        '/MD_2' : (BuildContext context) => MD_2(Student_Details()),
      }
    );
  }
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences pref_user;
  String _email,_uid;
  Student_Details student = Student_Details();
 // final FirebaseMessaging _messaging = FirebaseMessaging();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, _navigate);
  }


  @override
  void initState() {
    super.initState();
    startTime();
  //  _messaging.getToken().then((token){
     // print(token);
   // });
  }

 _navigate() async{
    pref_user = await SharedPreferences.getInstance();
    _email = pref_user.getString('userEmail');
    _uid = pref_user.getString('userUid');
    if(_uid == null){
    Navigator.of(context).pushReplacementNamed('/loginPage');}
    else {try{student.uid = _uid;
    student.profile_count = 1;
      await FirebaseDatabase.instance.reference().child('Students').child(_uid).child("1").once().then((DataSnapshot snapshot){
        student.getDetails(snapshot.value['Name'], snapshot.value['Age'], snapshot.value['School Name'],
            snapshot.value['DOB'], snapshot.value['Sport'],snapshot.value['Address'],snapshot.value['Email-id'],snapshot.value['Venue'],
            snapshot.value['Class'],snapshot.value['ImageURL'],snapshot.value['Contact Number'],snapshot.value["Parent's Contact"],
        snapshot.value['Category']);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Events_Page(student)));
      });
    }
    catch(e){
      Navigator.of(context).pushReplacementNamed('/loginPage');
    }}
      }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          //  image: DecorationImage(
            //  fit: BoxFit.cover,
             // image: AssetImage("images/RSA_background.png")
            //)
          ),
          child: Center(
            child: Image.asset("images/RSA_Logo.png",
                height: ScreenUtil.getInstance().setHeight(300),
                width: ScreenUtil.getInstance().setWidth(300),
            ),
          ),
        ));
  }
}
