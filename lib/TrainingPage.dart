import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/ProfilePage.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:rsa_app_official/Student_Details.dart';


class TrainingPage extends StatefulWidget {
  Student_Details _student_details;
  TrainingPage(this._student_details);
  @override
  _TrainingPageState createState() => _TrainingPageState(_student_details);
}

class _TrainingPageState extends State<TrainingPage> {
Student_Details student;
DateTime date = DateTime.now();
_TrainingPageState(this.student);

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
        ]
      )
  );

}

  @override
  Widget build(BuildContext context) {
    String venue;

    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        appBar: topAppBar ,
        bottomNavigationBar: bottomNavBar(context,student) ,
        body: _pageBody(context,student,date),
      ),
    );
  }
}

final topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  //backgroundColor: Color.fromRGBO(187, 36, 45, 10),
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("TRAINING",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);

Container _pageBody(BuildContext context,Student_Details student,DateTime date) => Container(
  decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
    fit: BoxFit.cover),
    //color: Colors.white
  ),
  child: Container(color: Colors.black.withOpacity(0.5),
    child: ListView(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50),
          right: ScreenUtil.getInstance().setWidth(50),
          top: ScreenUtil.getInstance().setHeight(50)),
          child: Container(
            child: FirebaseAnimatedList(query: FirebaseDatabase.instance.reference().child('Training').
            child('Venues').child(student.sport).orderByChild('Venue Name').equalTo(student.venue),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
                return Container(
                  height: ScreenUtil.getInstance().setHeight(ScreenUtil.getInstance().height/5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(40)),
                      border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
                      //color:Color.fromRGBO(187, 36, 45, 10).withOpacity(0.7),
                    color: Colors.black.withOpacity(0.5)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(30)),
                    child: Column(
                      children: <Widget>[
                        Text("NEXT TRAINING SESSION", style: TextStyle(fontSize: ScreenUtil(
                            allowFontScaling: true).setSp(60),
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),

                        Padding(
                          padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                          child: Text(snapshot.value['Time'],
                            style: TextStyle(fontSize: ScreenUtil(
                                allowFontScaling: true).setSp(60),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                          child: Text(snapshot.value['Date'],
                            style: TextStyle(fontSize: ScreenUtil(
                                allowFontScaling: true).setSp(60),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                          child: Text(student.venue,
                            style: TextStyle(fontSize: ScreenUtil(
                                allowFontScaling: true).setSp(60),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(50),
          left: ScreenUtil.instance.setWidth(50)),
          child: Text("Home Workouts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
          color: Colors.white),),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(30),
          left: ScreenUtil.instance.setWidth(50),
          right: ScreenUtil.instance.setWidth(50)),
          child: Container(height: ScreenUtil.instance.setHeight(1000),
            child: FirebaseAnimatedList(query: (student.std >= 1 && student.std <= 3)?
            ((student.sport == "Athletics")?
            FirebaseDatabase.instance.reference().child("Training").child("Workouts").
            child(student.sport).child("1").child(student.category).child(DateFormat('EEEE').format(date))
                :FirebaseDatabase.instance.reference().child("Training").child("Workouts").
            child(student.sport).child("1").child(DateFormat('EEEE').format(date)))
                : (student.std >=4 && student.std <=6)?
            ((student.sport == "Athletics")?FirebaseDatabase.instance.reference().child("Training").child("Workouts")
                .child(student.sport).child("2").child(student.category).child(DateFormat('EEEE').format(date))
                :FirebaseDatabase.instance.reference().child("Training").child("Workouts").
            child(student.sport).child("2").child(DateFormat('EEEE').format(date)))
            : (student.std >=7 && student.std <=10)?
            ((student.sport == "Athletics")?FirebaseDatabase.instance.reference().child("Training").child("Workouts")
                .child(student.sport).child("3").child(student.category).child(DateFormat('EEEE').format(date))
            :FirebaseDatabase.instance.reference().child("Training").child("Workouts").
            child(student.sport).child("3").child(DateFormat('EEEE').format(date)))
            : ((student.sport == "Athletics")?FirebaseDatabase.instance.reference().child("Training").child("Workouts").child(student.sport)
                .child("4").child(student.category).child(DateFormat('EEEE').format(date))
            :FirebaseDatabase.instance.reference().child("Training").child("Workouts").
            child(student.sport).child("4").child(DateFormat('EEEE').format(date))),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.value['Name'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      subtitle: Text(snapshot.value['Reps'],style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      color: Colors.grey,
                      height: ScreenUtil.getInstance().setHeight(2),
                    ),
                  ],
                ),
              );
                }
            ),
          ),
        ),
      ],
    ),
  ),
);



bmnav.BottomNav bottomNavBar(context, Student_Details student) => bmnav.BottomNav(
  index: 0,
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
    if(index == 1){
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return Events_Page(student);
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
