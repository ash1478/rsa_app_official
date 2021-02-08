import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_app_official/SettingsPage.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:rsa_app_official/imagePickerGallery.dart';



class EditProfile extends StatefulWidget {
Student_Details _student_details;
EditProfile(this._student_details);
  @override
  _EditProfileState createState() => _EditProfileState(_student_details);
}

TextEditingController controller_age;
TextEditingController controller_class;
TextEditingController controller_school;
TextEditingController controller_g_phone;
TextEditingController controller_p_phone;

class _EditProfileState extends State<EditProfile> {
  Student_Details student;
  _EditProfileState(this.student);
  final GlobalKey<FormState> _form_Key = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller_class = new TextEditingController(text: student.std.toString());
    controller_school = new TextEditingController(text: student.school);
    controller_g_phone = new TextEditingController(text: student.g_phone);
    controller_p_phone = new TextEditingController(text:student.p_phone);
  }

  Future uploadDetails() async{
    final formState = _form_Key.currentState;
    if(formState.validate()){
      await FirebaseDatabase.instance.reference().child("Students").child(student.uid).child(student.profile_count.toString()).update(student.toJsonUpdate());
      Fluttertoast.showToast(msg: "Details updated succesfully!",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
        textColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.7),
      );
Navigator.pop(context);
    }
  }
  final topAppBar = new AppBar(
    elevation: 0.1,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.black.withOpacity(0.8),
    title: Text("EDIT PROFILE",
      style: new TextStyle(
        fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: topAppBar,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
                  fit: BoxFit.cover)
            //color: Colors.white
          ),
          child: Container(color: Colors.black.withOpacity(0.4),
            child: Form(
              key: _form_Key,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                    child: Center(
                      child: Container(height: (student.imageURL==null)?ScreenUtil.getInstance().setHeight(600):null,
                        width:(student.imageURL==null)? ScreenUtil.getInstance().setWidth(600):null,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(5)),
                        ),
                        child: (student.imageURL != null)?GestureDetector(onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ImagePickerGallery(student,true)) );},
                            child: Image.network(student.imageURL,height: ScreenUtil.getInstance().setHeight(500),))
                            :GestureDetector( onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ImagePickerGallery(student,true)) );},
                            child: Container(decoration: BoxDecoration(color:Colors.grey),
                                child: Icon(Icons.camera_enhance,color: Colors.black,size: ScreenUtil.getInstance().setHeight(100),))),
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                    left: ScreenUtil.getInstance().setWidth(50),
                    right: ScreenUtil.getInstance().setWidth(50)),
                    child: TextFormField(
                      controller: controller_age,
                      onChanged: (val){
                        student.age = val;
                      },
                      validator: (val){
                        if(val.isEmpty) return "Please enter an Age!";
                        else return null;
                      },
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Edit your Age.",
                          hintStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          labelText: "Age",
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.black)
                      ),
                    ),
                  ),*/

                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                        left: ScreenUtil.getInstance().setWidth(50),
                        right: ScreenUtil.getInstance().setWidth(50)),
                    child: TextFormField(cursorColor: Colors.white,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: controller_class,
                      style: TextStyle(color: Colors.white,),
                      onChanged: (val){
                        student.std = int.parse(val);
                      },
                      validator: (val){
                        if(val.isEmpty) return "Please enter a Class!";
                        else return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          hintText: "Edit your Class.",
                          hintStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          labelText: "Class",
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                        left: ScreenUtil.getInstance().setWidth(50),
                        right: ScreenUtil.getInstance().setWidth(50)),
                    child: TextFormField(cursorColor: Colors.white,
                      controller: controller_school,
                      onChanged: (val){
                        student.school = val;
                      },
                      validator: (val){
                        if(val.isEmpty) return "Please enter a School Name!";
                        else return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                          hintText: "Edit your School name.",
                          hintStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          labelText: "School",
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                        left: ScreenUtil.getInstance().setWidth(50),
                        right: ScreenUtil.getInstance().setWidth(50)),
                    child: TextFormField(cursorColor: Colors.white,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: controller_g_phone,
                      onChanged: (val){
                        student.g_phone = val;
                      },
                      validator: (val){
                        if(val.isEmpty) return "Please enter a Contact Number!";
                        else return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          hintText: "Edit your Contact Number.",
                          hintStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          labelText: "Contact Number",
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50),
                        left: ScreenUtil.getInstance().setWidth(50),
                        right: ScreenUtil.getInstance().setWidth(50)),
                    child: TextFormField(cursorColor: Colors.white,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: controller_p_phone,
                      onChanged: (val){
                        student.p_phone = val;
                      },
                      validator: (val){
                        if(val.isEmpty) return "Please enter parent's Contact Number!";
                        else return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                          hintText: "Edit parent's Contact Number.",
                          hintStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          labelText: "Parent's Contact Number",
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100),
                    bottom: ScreenUtil.getInstance().setHeight(100),
                    left: ScreenUtil.getInstance().setWidth(100),
                    right: ScreenUtil.getInstance().setWidth(100)),
                    child: GestureDetector(
                      onTap: uploadDetails,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(height: ScreenUtil.getInstance().setHeight(150),
                              width: ScreenUtil.getInstance().setWidth(200),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(30))
                              ),
                              child: Center(child: Text("UPLOAD DETAILS",style: TextStyle(color: Colors.white,fontSize:ScreenUtil(allowFontScaling: true).setSp(40)),)),
                            ),
                          ),
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
}


