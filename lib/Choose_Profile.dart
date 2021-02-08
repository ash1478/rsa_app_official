import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/Events_Page.dart';
import 'package:rsa_app_official/Student_Details.dart';

class Choose_Profile extends StatefulWidget {
  String uid;
  Choose_Profile(this.uid);
  @override
  _Choose_ProfileState createState() => _Choose_ProfileState(uid);
}

class _Choose_ProfileState extends State<Choose_Profile> {
  _Choose_ProfileState(this._uid);

  Student_Details student = Student_Details();
  String _uid;
  int _profile_count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
              fit: BoxFit.cover),
          // color: Colors.white
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: FirebaseAnimatedList(query: FirebaseDatabase.instance.reference().child("Students").child(_uid),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index)
              {
                return Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(2)),
                    color: Colors.black.withOpacity(0.8)
                 ),
                  child: GestureDetector(
                    onTap: (){
                      _profile_count = index;
                      select_profile();
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(snapshot.value['Name'],style: TextStyle(color:Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),),
                          subtitle: Text(snapshot.value['Sport'],style: TextStyle(color:Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),),
                        ),
                        Container(
                          height: ScreenUtil.getInstance().setHeight(3),
                          color: Colors.white,
                        )
                      ],
                    )

                  ),
                );
            }
            ),
        ),
      ),

    );
  }
  Future select_profile() async
  {_profile_count = _profile_count + 1;
  student.uid = _uid;
  student.profile_count = _profile_count;
    await FirebaseDatabase.instance.reference().child('Students').child(student.uid).child(_profile_count.toString()).once().then((DataSnapshot snapshot){
      student.getDetails(snapshot.value['Name'], snapshot.value['Age'], snapshot.value['School Name'],
          snapshot.value['DOB'], snapshot.value['Sport'],snapshot.value['Address'],snapshot.value['Email-id'],snapshot.value['Venue'],
          snapshot.value['Class'],snapshot.value['ImageURL'],snapshot.value['Contact Number'],snapshot.value["Parent's Contact"],
      snapshot.value['Category']);

    });
    student.calc_age();
    await FirebaseDatabase.instance.reference().child('Students').child(student.uid).child(_profile_count.toString()).update(student.toJsonAge());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Events_Page(student)));
  }
}

final topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("CHOOSE YOUR PROFILE",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);