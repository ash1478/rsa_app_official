import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rsa_app_official/MD_1.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email;
  String _pwd;
  String c_pwd;
  bool _obscurePwd = true;
  final r_Student = Student_Details();
  GoogleSignIn googleAuth = GoogleSignIn();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<bool> _backPressed()
  {
    return showDialog(context: context,
        builder: (context)=>AlertDialog(

          title: Text("Do you want to exit?",),
          actions: <Widget>[
            FlatButton(
              child: Text("No",),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
            FlatButton(
                child: Text("Yes",),
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
        body: Container(decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/RSA_background_1.jpg"),
              fit: BoxFit.cover,
            )
        ),
          child: Container(color: Colors.black.withOpacity(0.4),
            child: ListView(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(100)),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/RSA_Logo_icon.png"),
                      radius: ScreenUtil.getInstance().setWidth(150),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                child: Form(
                  key: _formKey,
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(100),
                          right: ScreenUtil.getInstance().setWidth(100)),
                      child: TextFormField(cursorColor: Colors.white,
                        onSaved: (val) =>  _email = val,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter an Email-ID.";
                          }
                          else
                            return null;
                        },
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                            icon: Icon(Icons.email, color: Colors.white,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                color: Colors.white
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(50),
                          left: ScreenUtil.getInstance().setWidth(100),
                          right: ScreenUtil.getInstance().setWidth(100)),
                      child: TextFormField(cursorColor: Colors.white,
                        onSaved: (val) =>  _pwd = val,
                        validator: (val) {
                          if (val.length < 8) {
                            return "Password should be minimum 8 characters.";
                          }
                          else
                            return null;
                        },
                        obscureText: _obscurePwd,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                            suffixIcon: IconButton(icon: (_obscurePwd)?Icon(Icons.visibility_off):Icon(Icons.visibility),
                                color: (_obscurePwd)?Colors.grey:Colors.black,
                                onPressed: (){
                                  setState(() {
                                    _obscurePwd = !_obscurePwd;
                                  });
                                }),
                            icon: Icon(Icons.lock, color: Colors.white,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                color: Colors.white
                            )
                        ),
                      ),
                    ),

                  ],
                )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(100),
                    left: ScreenUtil.getInstance().setWidth(200),
                    right: ScreenUtil.getInstance().setWidth(200)),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(onTap: _register,
                        child: Container(
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Center(
                              child: new Text("REGISTER",
                                style: new TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(50),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'LemonMilk'
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                child: new Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        height: ScreenUtil.getInstance().setHeight(30),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(40),
                            right: ScreenUtil.getInstance().setWidth(40)),
                        child: Divider(
                          color: Colors.white,
                          height: 36,
                        )),
                  ),
                  Text("OR",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40),color: Colors.white),),
                  Expanded(
                    child: new Container(
                        height: 30,
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(40),
                            right: ScreenUtil.getInstance().setWidth(40)),
                        child: Divider(
                          color: Colors.white,
                          height: 36,
                        )),
                  ),
                ]),
              ),

              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                    left: ScreenUtil.getInstance().setWidth(100),
                    right: ScreenUtil.getInstance().setWidth(100)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: _googleSignIn,
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(200),
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
                                  child: Text("Login with Google",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(45),
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
                        "Back to login? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'LemonMilk',
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
                        ),
                      ),
                      new GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/loginPage');
                        },
                        child: new Text(
                          "Click Here!",
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
            ]
            ),
          ),
        ),
      ),
    );
  }
  Future <void> _googleSignIn() async {
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
          msg: 'Google Sign in failed.',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
        );
      }
      else {
        Fluttertoast.showToast(
          msg: "Please wait! This may take few seconds.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
        );
        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        r_Student.uid = user.uid;
        r_Student.email = user.email;
        bool ifExist = false;
        String name;
        await FirebaseDatabase.instance.reference().child("Students").child(r_Student.uid).child("1").once().then((DataSnapshot snap){
          name = snap.value["Name"];
        }).catchError((e)async{SharedPreferences pref_uid = await SharedPreferences.getInstance();
        pref_uid.setString('userUid', user.uid);

        Fluttertoast.showToast(
          msg: "Signed in successfully!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
        );
        r_Student.profile_count = 0;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MD_1(r_Student)));
        ifExist = true;
        });
        if(!ifExist) {
          Fluttertoast.showToast(
            msg: 'Email-ID is already in use, try again with another id.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
          );
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

  Future<void> _register() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      try {
        bool ifExist = false;
        form.save();
          AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email, password: _pwd).catchError((e){if(e is PlatformException)
         {
           if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE'){
             Fluttertoast.showToast(
               msg: 'Email-ID is already in use, try again with another id.',
               gravity: ToastGravity.BOTTOM,
               toastLength: Toast.LENGTH_LONG,
               backgroundColor: Colors.black.withOpacity(0.7),
               textColor: Colors.white,
               fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
             );
             ifExist = true;
           }
         }
            });
          if(!ifExist){
          if(user != null){
          FirebaseUser user = await FirebaseAuth.instance.currentUser();
          Fluttertoast.showToast(
            msg: "Account created successfully!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
          );

          r_Student.uid = user.uid;
          r_Student.email = _email;
          r_Student.profile_count =0;
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> MD_1(r_Student)));
        }
          else {
            Fluttertoast.showToast(
              msg: 'Something went wrong! Check your credentials or your network.',
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.black.withOpacity(0.7),
              textColor: Colors.white,
              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
            );
          }}
      } catch (e) {
        print(e);
        }
      }
    }
  }
