import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/MD_2.dart';
import 'package:rsa_app_official/MD_4.dart';
import 'package:rsa_app_official/Student_Details.dart';

class MD_3 extends StatefulWidget {
Student_Details g_student = Student_Details();
  MD_3(this.g_student);
  @override
  _MD_3State createState() => _MD_3State(g_student);
}

class _MD_3State extends State<MD_3> {
  Student_Details student = Student_Details();
  _MD_3State(this.student);
  DatabaseReference DBref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBref = FirebaseDatabase.instance.reference().child('Students');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/RSA_background_1.jpg"),
            fit: BoxFit.cover
          )
          //color: Colors.white
        ),
        child: Container(color: Colors.black.withOpacity(0.3),
          child: Column(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(150),
                bottom: ScreenUtil.getInstance().setHeight(200),
                left: ScreenUtil.getInstance().setWidth(60),
                right: ScreenUtil.getInstance().setWidth(60)),
                child: Row(
                  children: <Widget>[
                    Text('Choose your Sport.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil(allowFontScaling: true).setSp(80),
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(100),
                right: ScreenUtil.getInstance().setWidth(100),),
                child: Container(//color: Colors.black,
                  height: ScreenUtil.getInstance().setHeight(400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:AssetImage("images/football_card.jpg")
                    )
                  ),
                  child: GestureDetector(
                    onTap: (){
                      student.sport = "Football";
                      student.sport_id = 1;
                      //Navigate to MD_4()
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MD_4(student)));
                    },
                      child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Text("FOOTBALL",
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left:ScreenUtil.getInstance().setWidth(30),
                right: ScreenUtil.getInstance().setWidth(30),
                top: ScreenUtil.getInstance().setHeight(200)),
                child: new Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        height: ScreenUtil.getInstance().setHeight(50),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(30),
                            right: ScreenUtil.getInstance().setWidth(40)),
                        child: Divider(
                          color: Colors.white,
                          height: ScreenUtil.getInstance().setHeight(50),
                        )),
                  ),
                  Text("OR",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),),
                  Expanded(
                    child: new Container(
                      height:ScreenUtil.getInstance().setHeight(50) ,
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(40),
                            right: ScreenUtil.getInstance().setWidth(30)),
                        child: Divider(
                          color: Colors.white,
                          height: ScreenUtil.getInstance().setHeight(50),
                        )),
                  ),
                ]),
              ),

              Padding(
                padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(100),
                right: ScreenUtil.getInstance().setWidth(100),
                top: ScreenUtil.getInstance().setHeight(200)),
                child: Container(//color: Colors.black,
                  height: ScreenUtil.getInstance().setHeight(400),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(10)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:AssetImage("images/athletics_card.jpg")
                      )
                  ),
                  child: GestureDetector(
                    onTap: ()async{
                      await showDialog(context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.black.withOpacity(0.8),
                          content: Container(
                            child: Column(mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/60),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Choose Category",style: TextStyle(color: Colors.white,
                                          fontSize: MediaQuery.of(context).size.width/20,
                                      fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "Shotput";
                                        print(student.category);
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Shotput",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(onTap: (){
                                    setState(() {
                                      student.category = "Discuss";
                                    });
                                    Navigator.pop(context,false);
                                  },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Discuss Throw",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "Long Jump";
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Long Jump",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "High Jump";
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("High Jump",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "Short";
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Short Dist. Runner",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "Medium";
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Medium Dist. Runner",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        student.category = "Long";
                                      });
                                      Navigator.pop(context,false);
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Long Dist. Runner",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      );

                      student.sport = "Athletics";
                      student.sport_id = 2;
                      //Navigate to MD_4()
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MD_4(student)));
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Text("ATHLETICS",
                          style: TextStyle(
                            fontSize: ScreenUtil(allowFontScaling: true).setSp(60),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
