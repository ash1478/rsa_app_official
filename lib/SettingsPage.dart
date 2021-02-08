import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/AboutUsPage.dart';
import 'package:rsa_app_official/Choose_Profile.dart';
import 'package:rsa_app_official/EditProfilePage.dart';
import 'package:rsa_app_official/LoginPage.dart';
import 'package:rsa_app_official/MD_1.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
Student_Details _student_details;
SettingsPage(this._student_details);
  @override
  _SettingsPageState createState() => _SettingsPageState(_student_details);
}

class _SettingsPageState extends State<SettingsPage> {
  Student_Details student;
  SharedPreferences pref_email;
  SharedPreferences pref_uid;

  _SettingsPageState(this.student);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
                fit: BoxFit.cover)
         // color: Colors.white
        ),
        child: Container(color: Colors.black.withOpacity(0.4),
          child: Column(
            children: <Widget>[

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(200),
                right: ScreenUtil.getInstance().setWidth(100),
                left: ScreenUtil.getInstance().setWidth(100)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(student)));
                        },
                        child: Container(height: ScreenUtil.getInstance().setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20))
                            ),
                            child: new Text("Edit Profile",
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                                  color: Colors.white,
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
                    right: ScreenUtil.getInstance().setWidth(100),
                    left: ScreenUtil.getInstance().setWidth(100)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MD_1(student)));
                        },
                        child: Container(height: ScreenUtil.getInstance().setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20))
                            ),
                            child: new Text("Add New Profile",
                              style: new TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                                color: Colors.white,
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
                    right: ScreenUtil.getInstance().setWidth(100),
                    left: ScreenUtil.getInstance().setWidth(100)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Choose_Profile(student.uid)));
                        },
                        child: Container(height: ScreenUtil.getInstance().setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20))
                            ),
                            child: new Text("Change Profile",
                              style: new TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                                color: Colors.white,
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
              right: ScreenUtil.getInstance().setWidth(100),
              left: ScreenUtil.getInstance().setWidth(100)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUsPage()));
                        },
                        child: Container(height: ScreenUtil.getInstance().setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20))
                            ),
                            child: new Text("About Us",
                              style: new TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                                color: Colors.white,
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
                    right: ScreenUtil.getInstance().setWidth(100),
                    left: ScreenUtil.getInstance().setWidth(100)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: _logOut,
                        child: Container(height: ScreenUtil.getInstance().setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20))
                            ),
                            child: new Text("Log Out",
                              style: new TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                                color: Colors.white,
                              ),
                            )

                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


  _logOut() async{
    pref_email = await SharedPreferences.getInstance();
    pref_uid = await SharedPreferences.getInstance();
    pref_email.remove('userEmail');
    pref_uid.remove('userUid');
    FirebaseAuth.instance.signOut().then((val){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    });
  }

}

final topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("SETTINGS",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);


