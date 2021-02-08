import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rsa_app_official/MD_2.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';




class MD_1 extends StatefulWidget {
  Student_Details _student_details;
  MD_1(this._student_details);
  @override
  _MD_1State createState() => _MD_1State(_student_details);
}

class _MD_1State extends State<MD_1> {
  Student_Details student;
  _MD_1State(this.student);
  TextEditingController date;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/RSA_background_1.jpg"),
            fit: BoxFit.cover,
          )
          //color: Colors.white
        ),
        child: Container(color: Colors.black.withOpacity(0.4),
          child: Form(key: _formKey,
                          child: ListView(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top:ScreenUtil.getInstance().setHeight(100),
                      left: ScreenUtil.getInstance().setWidth(75)),
                  child: Row(
                    children: <Widget>[
                      Text("Details.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(80),
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:ScreenUtil.getInstance().setHeight(50),
                  left: ScreenUtil.getInstance().setWidth(75),
                  right: ScreenUtil.getInstance().setWidth(75)),
                  child: Column(
                    children: <Widget>[
                      Container(decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setHeight(20),
                              bottom: ScreenUtil.getInstance().setHeight(40),
                              left: ScreenUtil.getInstance().setWidth(40),
                              right: ScreenUtil.getInstance().setWidth(40)),
                          child: TextFormField(cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            onSaved: (val){
                              student.name = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter a name!";
                              else return null;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.redAccent),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                              hintText: "Enter Full name.",
                              hintStyle: TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                labelText: "Name",
                                labelStyle: TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(20),
                                bottom: ScreenUtil.getInstance().setHeight(40),

                                left: ScreenUtil.getInstance().setWidth(40),
                                right: ScreenUtil.getInstance().setWidth(40)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              controller: date,
                              onSaved: (val){
                              student.dob = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter Date of Birth!";
                              else return null;
                            },
                              obscureText: false,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                suffixIcon: GestureDetector(onTap:() async{
                                  showDatePicker(context: context,
                                    initialDate: DateTime.now() , firstDate: DateTime(1960),lastDate: DateTime(DateTime.now().year + 10),

                                  ).then((val){
                                    setState(() {
                                      String convertedDate = new DateFormat("dd/MM/yyy").format(val);
                                      student.dob = convertedDate;
                                      date = new TextEditingController(text: student.dob);
                                    });
                                  });
                                },child: Icon(Icons.calendar_today,color: Colors.white,)),
                                  labelText: "DOB (DD/MM/YYYY)",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(20),
                                bottom: ScreenUtil.getInstance().setHeight(40),
                                left: ScreenUtil.getInstance().setWidth(40),
                                right: ScreenUtil.getInstance().setWidth(40)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onSaved: (val){
                              student.school = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter School name!";
                              else return null;
                            },
                              obscureText: false,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "School Name",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(20),
                                bottom: ScreenUtil.getInstance().setHeight(40),
                                left: ScreenUtil.getInstance().setWidth(40),
                                right: ScreenUtil.getInstance().setWidth(40)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onSaved: (val){
                              student.g_phone = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter contact number!";
                              else return null;
                            },
                              obscureText: false,inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "Contact Number",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(20),
                                bottom: ScreenUtil.getInstance().setHeight(40),
                                left: ScreenUtil.getInstance().setWidth(40),
                                right: ScreenUtil.getInstance().setWidth(40)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onSaved: (val){
                              student.age = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter an Age!";
                              else return null;
                            },
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "Age",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(20),
                                bottom: ScreenUtil.getInstance().setHeight(40),
                                left: ScreenUtil.getInstance().setWidth(40),
                                right: ScreenUtil.getInstance().setWidth(40)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              onSaved: (val){
                              student.std = int.parse(val);
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter a Class!";
                              else return null;
                            },
                              obscureText: false,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "Class",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:ScreenUtil.getInstance().setHeight(40),
                  bottom: ScreenUtil.getInstance().setHeight(50),
                  right: ScreenUtil.getInstance().setWidth(20),),
                  child: GestureDetector(onTap: _confirm_MD1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Next",
                        style: TextStyle(color: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
                        ),),
                        Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
Future<void> _confirm_MD1() async{
  final formState = _formKey.currentState;
  if(formState.validate())
  {
    showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text("Confirm? Given details cannot be edited later.",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),),
          actions: <Widget>[
            FlatButton(
              child: Text("Go Back",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40))),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
            FlatButton(
              child: Text("Yes",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40))),
              onPressed: (){
                formState.save();
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MD_2(student)));
              }
            ),
          ],
        )
    );
  }
}
}
