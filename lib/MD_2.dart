import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/MD_1.dart';
import 'package:rsa_app_official/MD_3.dart';
import 'package:rsa_app_official/Student_Details.dart';

class MD_2 extends StatefulWidget {
  Student_Details g_student = Student_Details();
  MD_2(this.g_student);
  @override
  _MD_2State createState() => _MD_2State(g_student);
}

class _MD_2State extends State<MD_2> {
  Student_Details student = Student_Details();
  _MD_2State(this.student);
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
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(100),
                    left: ScreenUtil.getInstance().setWidth(75)),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Details.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(80),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(50),
                    left: ScreenUtil.getInstance().setWidth(75),
                    right: ScreenUtil.getInstance().setWidth(75)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
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
                              student.blood_group = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter blood group!";
                              else return null;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.redAccent),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                labelText: "Blood Group",
                                labelStyle: TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true)
                                        .setSp(40),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(
                          decoration: BoxDecoration(
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
                              student.f_name = val;
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
                                  labelText: "Father's Name",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true)
                                          .setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(
                          decoration: BoxDecoration(
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
                              student.m_name = val;
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
                                  labelText: "Mother's Name",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true)
                                          .setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(
                          decoration: BoxDecoration(
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
                              student.p_phone = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter a contact number!";
                              else return null;
                            },
                              obscureText: false,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText:
                                      "Father's or Mother's Contact Number",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true)
                                          .setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(
                          decoration: BoxDecoration(
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
                              student.illness = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Enter 'nil' if none!";
                              else return null;
                            },
                              obscureText: false,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "Any Major Illness",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true)
                                          .setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(50)),
                        child: Container(
                          decoration: BoxDecoration(
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
                              student.address = val;
                            },
                            validator: (val){
                              if(val.isEmpty) return "Please enter an Address!";
                              else return null;
                            },
                              obscureText: false,
                              maxLines: 2,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  labelText: "Address",
                                  labelStyle: TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true)
                                          .setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(50),
                    right: ScreenUtil.getInstance().setWidth(20),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _confirm_MD2,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtil(allowFontScaling: true).setSp(50),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _confirm_MD2() async{
    final formState = _formKey.currentState;
    if(formState.validate())
    {
      showDialog(context: context,
          builder: (context)=>AlertDialog(

            title: Text("Confirm? Given details may not be edited later.",style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),),
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
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MD_3(student)));
                  }
              ),
            ],
          )
      );
    }
  }
}
