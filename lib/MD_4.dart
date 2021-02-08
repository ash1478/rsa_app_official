import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MD_4 extends StatefulWidget {
  Student_Details g_student = Student_Details();
  MD_4(this.g_student);
  @override
  _MD_4State createState() => _MD_4State(g_student);
}

class _MD_4State extends State<MD_4> {
  Student_Details student = Student_Details();
  _MD_4State(this.student);
  DatabaseReference DBref =  FirebaseDatabase.instance.reference().child("Students");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
          fit: BoxFit.cover)
         // color: Colors.white
        ),
        child: Container(color: Colors.black.withOpacity(0.3),
          child: ListView(
            scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
            bottom: ScreenUtil.getInstance().setHeight(100),
                      left: ScreenUtil.getInstance().setWidth(60),
                      right: ScreenUtil.getInstance().setWidth(60)),
                  child: Row(
                    children: <Widget>[
                      Text('Venues.',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(80),
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                    ],
                  ),
                ),

                FirebaseAnimatedList(query: (student.sport == "Football")
                    ? FirebaseDatabase.instance.reference().child("Venues").orderByChild("Sport Code").startAt("200").endAt("300")
                    : FirebaseDatabase.instance.reference().child("Venues").orderByChild("Sport Code").startAt("100").endAt("200"),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
                      return Padding(
                        padding:  EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(100),
                            right: ScreenUtil.getInstance().setWidth(100),
                        bottom:ScreenUtil.getInstance().setHeight(100)),
                        child: _venueCard(snapshot,index),
                      );
                    }),
              ],
          ),
        ),
      ),
    );
  }
Container _venueCard(DataSnapshot snapshot, int index) => Container(
  height: ScreenUtil.getInstance().setHeight(400),
  decoration: BoxDecoration(
    image: DecorationImage(
        image: (student.sport == "Football") ? AssetImage("images/football_card.jpg"): AssetImage("images/athletics_card.jpg"),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20)),
      border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
      //image yet to be uploaded in database.
  ),
  child: GestureDetector(
    onTap: () async {
      student.venue_id = snapshot.value['Id'];
      student.venue = snapshot.value['Name'];
      if(student.std >= 1 && student.std <= 3)student.grp_id=1;
      else if(student.std >= 4 && student.std <= 6)student.grp_id=2;
      else if(student.std >= 7 && student.std <= 10)student.grp_id=3;
      else student.grp_id=4;
     SharedPreferences pref_user = await SharedPreferences.getInstance();
     pref_user.setString('userEmail', student.email);
      pref_user.setString('userUid', student.uid);
      student.calc_factor();
      student.calc_age();
      int c;
      await FirebaseDatabase.instance.reference().child("StudentList").child("0").once().then((DataSnapshot snapshot){
        c = snapshot.value['Count'];
      });
      await FirebaseDatabase.instance.reference().child("StudentList").child("0").update({"Count" : ++c});
       student.imageURL = null;
        await FirebaseDatabase.instance.reference().child("Students").child(student.uid).child(student.profile_count.toString())
            .once().then((DataSnapshot snapshot){
              student.profile_count = snapshot.value['Profile Count'];
        }).catchError((e){
          student.profile_count = 0;
        });
        student.profile_count = student.profile_count + 1;
        DBref.child(student.uid).child(student.profile_count.toString()).set(student.toJson());
      await FirebaseDatabase.instance.reference().child("StudentList").child(c.toString()).set(student.toJsonList());
      for(int i = 1;i<=student.profile_count;i++){
          DBref.child(student.uid).child(i.toString()).update(student.toJsonCount());
        }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Events_Page(student)));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(20)),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(snapshot.value['Name'],
            style: TextStyle(
              fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
          Text(snapshot.value['Location'],
            style: TextStyle(
              fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
        ],
      ),
    ),
  ),
);
}
