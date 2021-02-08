import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/PaymentPage.dart';
import 'package:rsa_app_official/SettingsPage.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:rsa_app_official/TrainingPage.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:rsa_app_official/imagePickerGallery.dart';


class ProfilePage extends StatefulWidget {
  Student_Details _student_details;
  ProfilePage(this._student_details);
  @override
  _ProfilePageState createState() => _ProfilePageState(_student_details);
}

class _ProfilePageState extends State<ProfilePage> {
  Student_Details student;
  _ProfilePageState(this.student);


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
        appBar: topAppBar(context,student),
        bottomNavigationBar: bottomNavBar(context,student),
        body: profileBody(context,student),
      ),
    );
  }
}

AppBar topAppBar(context,Student_Details student_details) => AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  //backgroundColor: Color.fromRGBO(187, 36, 45, 10),
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("PROFILE",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
  actions: <Widget>[
    Padding(
      padding:  EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(50)),
      child: IconButton(icon: Icon(Icons.payment,size: ScreenUtil.getInstance().setHeight(60),color: Colors.white,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(student_details)));
        },),
    ),
    Padding(
      padding:  EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(50)),
      child: IconButton(icon: Icon(Icons.settings,size: ScreenUtil.getInstance().setHeight(60),color: Colors.white,),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(student_details)));
      },),
    )
  ],
);



Container profileBody(context, Student_Details student) => Container(
  decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
          fit: BoxFit.cover),
   // color: Colors.white
  ),
  child: Container(  color: Colors.black.withOpacity(0.4),
    child: ListView(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
              left: ScreenUtil.getInstance().setWidth(100),
              right: ScreenUtil.getInstance().setWidth(100)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(40)),
                border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
                //color: Color.fromRGBO(187, 36, 45, 10).withOpacity(0.7)
              color: Colors.black.withOpacity(0.6),

            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(50)),
              child: Column(
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("STUDENT e-ID",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),)
                  ],),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                    child: Container(height: ScreenUtil.getInstance().setHeight(400),
                      width: (student.imageURL == null)?ScreenUtil.getInstance().setWidth(400):null,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(5)),
                      ),
                      child: (student.imageURL != null)?Image.network(student.imageURL,
                       // height: ScreenUtil.getInstance().setHeight(500),
                       // width: ScreenUtil.getInstance().setWidth(500),
                           )
                          :GestureDetector( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePickerGallery(student,false)) );},
                                            child: Container(decoration: BoxDecoration(color:Colors.grey),
                                                child: Icon(Icons.camera_enhance,color: Colors.black,size: ScreenUtil.getInstance().setHeight(100),))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Name: ",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),),
                        Text(student.name,style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20) ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Age: ",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),),
                        Text(student.age,style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Class: ",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),),
                        Text(student.std.toString(), style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("School: ",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),),
                        Text(student.school,style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(50)),
          child: Column(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/30),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("MESSAGES",
                      style: TextStyle(color: Colors.white,
                         fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width/20),)
                  ],
                ),
              ),
              Container(//height: MediaQuery.of(context).size.height*0.7,
                child: FirebaseAnimatedList(shrinkWrap: true,
                  query: FirebaseDatabase.instance.reference().child("Messages").child(student.sport).child(student.venue).orderByChild("Count").startAt(0),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index) {
                    return Padding(
                      padding: (index%2 == 0)?EdgeInsets.only(top: MediaQuery.of(context).size.height/30,
                          left:MediaQuery.of(context).size.width/30,
                          right: MediaQuery.of(context).size.width*28/90):
                      EdgeInsets.only(top: MediaQuery.of(context).size.height/30,
                          left: MediaQuery.of(context).size.width*28/90,
                          right: MediaQuery.of(context).size.width/30),
                      child: Container(
                        width: MediaQuery.of(context).size.width*2/3,
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.value['Text'],style: TextStyle(color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width/25),),
                              Padding(
                                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/70),
                                child: Text(snapshot.value['DateTime'],style: TextStyle(color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width/30),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ),
  ),
);




bmnav.BottomNav bottomNavBar(context,Student_Details student) => bmnav.BottomNav(
  index: 2,
  //color: Color.fromRGBO(187, 36, 45, 10),
  color: Colors.black.withOpacity(0.8),
  elevation: 0.5,
  iconStyle: bmnav.IconStyle(
      size: ScreenUtil.getInstance().setWidth(70),
      onSelectColor: Colors.yellowAccent,
      onSelectSize: ScreenUtil.getInstance().setWidth(80),
      color: Colors.white
  ),
  labelStyle: bmnav.LabelStyle(
      textStyle: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(30),color: Colors.white),
      onSelectTextStyle: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(35),color: Colors.yellowAccent)
  ),
  items: [
    bmnav.BottomNavItem(Icons.directions_run,label:"Training"),
    bmnav.BottomNavItem(Icons.event_note,label:"Event"),
    bmnav.BottomNavItem(Icons.account_circle,label:"Profile"),
  ],
  onTap: (index){
    if(index == 0){
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return TrainingPage(student);
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: new SlideTransition(
                  position: new Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(-1.0, 0.0),
                  ).animate(secondaryAnimation),
                  child: child,
                ),
              );
            },
          )
      );
    }
    if(index == 1)
    {
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return Events_Page(student);
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: new SlideTransition(
                  position: new Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(-1.0, 0.0),
                  ).animate(secondaryAnimation),
                  child: child,
                ),
              );
            },
          )
      );
    }

  },
);
