
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/MD_1.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:url_launcher/url_launcher.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _pwd;
  SharedPreferences pref_user;
  bool _obscurePwd = true;
  final student = Student_Details();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GoogleSignIn googleAuth = new GoogleSignIn();
  Map userProfile;
  bool _isLoggedIn = false;

  Future<bool> _backPressed()
  {
    return showDialog(context: context,
        builder: (context)=>AlertDialog(

          title: Text("Do you want to exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () => exit(0)
            ),
          ],
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        body: Form(key: _formKey,
          child: Container(decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/RSA_background_1.jpg"),
                fit: BoxFit.cover,
              )
            //  color: Colors.white,
          ),
            child: Container(color: Colors.black.withOpacity(0.4),
              child: ListView(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(100)),
                      child: CircleAvatar(backgroundImage: AssetImage("images/RSA_Logo_icon.png"),
                       radius: ScreenUtil.getInstance().setWidth(150),
                       // child: Image.asset("images/RSA_Logo_icon.png",
                         // height: ScreenUtil.getInstance().setHeight(300),
                          //width: ScreenUtil.getInstance().setWidth(300),
                        //),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(150),
                      left: ScreenUtil.getInstance().setWidth(100),
                      right: ScreenUtil.getInstance().setWidth(100)),
                  child: TextFormField(cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    obscureText: false,
                    onSaved: (val) {
                      setState(() {
                        _email = val;
                      });
                    } ,
                    validator: (val){
                      if(val.isEmpty){
                        return "Please enter an Email-Id.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                            color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(50),
                      left: ScreenUtil.getInstance().setWidth(100),
                      right: ScreenUtil.getInstance().setWidth(100)),
                  child: TextFormField(cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    obscureText: _obscurePwd,
                    onSaved: (val) {
                      setState(() {
                        _pwd = val;
                      });
                    },
                    validator: (val){
                      if(val.length<8){
                        return "Password must be minimum 8 characters.";
                      }
                      else return null;
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                        suffixIcon: IconButton(icon: (_obscurePwd)?Icon(Icons.visibility_off):Icon(Icons.visibility),
                          color: (_obscurePwd)?Colors.grey:Colors.black,
                          onPressed: (){
                        setState(() {
                          _obscurePwd = !_obscurePwd;
                        });
                          }),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                            color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(100),
                      left: ScreenUtil.getInstance().setWidth(200),
                      right: ScreenUtil.getInstance().setWidth(200)),
                  child: GestureDetector(
                    onTap: _login,

                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              height: ScreenUtil.getInstance().setHeight(100),
                              decoration: BoxDecoration(
                                  //color: Color.fromRGBO(187, 36, 45, 10),
                                color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: new Text(
                                  "LOGIN",
                                  style: new TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(50),
                                      color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding:
                      EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                  child: new Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          height: ScreenUtil.getInstance().setHeight(40),
                          margin: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(40),
                              right: ScreenUtil.getInstance().setWidth(40)),
                          child: Divider(
                            color: Colors.white,
                            height: ScreenUtil.getInstance().setHeight(20),
                          )),
                    ),
                    Text("OR",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40),color: Colors.white),),
                    Expanded(
                      child: new Container(
                          height: ScreenUtil.getInstance().setHeight(40),
                          margin: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(40),
                              right: ScreenUtil.getInstance().setWidth(40)),
                          child: Divider(
                            color: Colors.white,
                            height: ScreenUtil.getInstance().setHeight(20),
                          )),
                    ),
                  ]),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
                  left: ScreenUtil.getInstance().setWidth(100),
                  right: ScreenUtil.getInstance().setWidth(100)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: _googleLogin,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(60)),
                              border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(5)),
                              color: Colors.black.withOpacity(0.8),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(ScreenUtil.getInstance().setHeight(20)),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset("images/google_icon.png",height: ScreenUtil.getInstance().setHeight(60),width: ScreenUtil.getInstance().setWidth(60),),
                                  Padding(
                                    padding:  EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
                                    child: Text("Login with Google",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



                Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(100)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "New Member? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'LemonMilk',
                            fontSize: ScreenUtil(allowFontScaling: true).setSp(45),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/registerPage');
                          },
                          child: new Text(
                            "Register Now!",
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'LemonMilk'),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(200),
                    bottom: ScreenUtil.getInstance().setHeight(50)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            launch("https://right-sports-academy.flycricket.io/privacy.html");
                          },
                          child: Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              decoration: TextDecoration.underline),),
                        )
                      ],
                    )
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future <void> _googleLogin() async {
    await googleAuth.signOut();
    GoogleSignInAccount _account = await googleAuth.signIn();
    try{FirebaseAuth auth = FirebaseAuth.instance;
    if (_account != null) {
      AuthResult res = await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await _account.authentication).idToken,
        accessToken: (await _account.authentication).accessToken,
      )
      );
      if(res.user == null){
         Fluttertoast.showToast(
          msg: 'Google Login failed.',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
        );
      }
      else {
        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        student.uid = user.uid;
        student.profile_count = 1;
        pref_user = await SharedPreferences.getInstance();
        pref_user.setString('userUid', user.uid);
        try{
        await FirebaseDatabase.instance.reference().child('Students').child(student.uid).child(student.profile_count.toString()).once().then((DataSnapshot snapshot){
          student.getDetails(snapshot.value['Name'], snapshot.value['Age'], snapshot.value['School Name'],
              snapshot.value['DOB'], snapshot.value['Sport'],snapshot.value['Address'],snapshot.value['Email-id'],snapshot.value['Venue'],
              snapshot.value['Class'],snapshot.value['ImageURL'],snapshot.value['Contact Number'],snapshot.value["Parent's Contact"],
          snapshot.value['Category']);
          Fluttertoast.showToast(
            msg: "Logged in successfully!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Events_Page(student)));
        });}catch(e){
          print(e.toString());
          student.profile_count = 0;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MD_1(student)));
        }
      }
    }}
    catch(e){
      print(e);
      Fluttertoast.showToast(
        msg: 'Something went wrong! Check your network.',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
      );
      FirebaseAuth user = FirebaseAuth.instance;
      await user.signOut();
      await googleAuth.signOut();
    }
    }


  Future<void> _login() async {
    final formState = _formKey.currentState;
    if(formState.validate())
    {
      try {
        formState.save();
        AuthResult authresult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _pwd).catchError((e){
          Fluttertoast.showToast(
            msg: 'Something went wrong! Check your credentials or your network.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
          );
        });

        if(authresult != null){
          Fluttertoast.showToast(
            msg: "Please wait! This may take few seconds.",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
          );
        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        student.uid=user.uid;
        pref_user = await SharedPreferences.getInstance();
        pref_user.setString('userEmail', _email);
        pref_user.setString('userUid', user.uid);
        student.profile_count = 1;
        await FirebaseDatabase.instance.reference().child('Students').child(student.uid).child(student.profile_count.toString()).once().then((DataSnapshot snapshot){
            student.getDetails(snapshot.value['Name'], snapshot.value['Age'], snapshot.value['School Name'],
                snapshot.value['DOB'], snapshot.value['Sport'],snapshot.value['Address'],snapshot.value['Email-id'],snapshot.value['Venue'],
            snapshot.value['Class'],snapshot.value['ImageURL'],snapshot.value['Contact Number'],snapshot.value["Parent's Contact"],
            snapshot.value['Category']);

        });
        student.calc_age();
        Fluttertoast.showToast(
          msg: "Logged in successfully!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Events_Page(student)) );
      }}catch(e){
        print(e);
      }
    }
  }
  }

