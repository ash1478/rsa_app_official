import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/Event_Details_Page.dart';
import 'package:rsa_app_official/Events_Details.dart';
import 'package:rsa_app_official/ProfilePage.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:rsa_app_official/TrainingPage.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

class Events_Page extends StatefulWidget {
  Student_Details _student_details;
  Events_Page(this._student_details);
  @override
  _Events_PageState createState() => _Events_PageState(_student_details);
}
int i =1;

class _Events_PageState extends State<Events_Page> {
  Student_Details student;
  EventDetails _eventDetails = EventDetails();
  _Events_PageState(this.student);

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
       appBar: topAppBar,
        bottomNavigationBar: bottomNavBar(context,student),
        body:Container(decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
                fit: BoxFit.cover)
          // color: Colors.lightBlueAccent.withOpacity(0.4)
        ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: FirebaseAnimatedList(query: FirebaseDatabase.instance.reference().child("Events"),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
              return Padding(
                padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(60),
                bottom: ScreenUtil.getInstance().setHeight(40),
                left: ((i++)%2.0 == 1) ? ScreenUtil.getInstance().setWidth(50) : ScreenUtil.getInstance().setWidth(ScreenUtil.getInstance().width/5),
                right: ((i)%2.0 == 0)? ScreenUtil.getInstance().setWidth(ScreenUtil.getInstance().width/5) : ScreenUtil.getInstance().setWidth(50)),
                child: GestureDetector(onTap: (){
                  _eventDetails.getDetails(snapshot.value['Title'], snapshot.value['Subtitle'],
                      snapshot.value['Description'], snapshot.value['imageURL']);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Event_Details_Page(_eventDetails)));
                },
                    child: _eventCard(snapshot))
              );
                }),
          ),
        )

      ),
    );
  }
}
AppBar topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  //backgroundColor: Color.fromRGBO(187, 36, 45, 10),
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("EVENTS",
    style: new TextStyle(color: Colors.white,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);


bmnav.BottomNav bottomNavBar(context,Student_Details student) => bmnav.BottomNav(
  index: 1,
  //color: Color.fromRGBO(187, 36, 45, 10),
  elevation: 0.5,
  color: Colors.black.withOpacity(0.8),
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
    if(index == 2)
      {
        Navigator.pushReplacement(context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return ProfilePage(student);
              },
              transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                return SlideTransition(
                  position: new Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1.0, 0.0),
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

Container _eventCard(DataSnapshot snapshot) => Container(
  height: ScreenUtil.getInstance().setHeight(400),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(40)),
  border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
image: DecorationImage(
  image: NetworkImage(snapshot.value['imageURL']),
fit: BoxFit.cover,
),
),
  child: Column(mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Container(
        height: ScreenUtil.getInstance().setHeight(150),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(30))
      ),
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  Text(snapshot.value["Title"],
                  style: TextStyle(
                    fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),)
                ],),
              ),
              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10)),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(snapshot.value["Subtitle"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                            color: Colors.white
                        ),),
                    )
                  ],),
              )
            ],
          ),
        )
),
    ],
  ),
);