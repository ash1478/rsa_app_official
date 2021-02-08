import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:rsa_app_official/EditProfilePage.dart';
import 'package:rsa_app_official/ProfilePage.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerGallery extends StatefulWidget {
  bool isEdit;
  Student_Details student_details;
  ImagePickerGallery(this.student_details,this.isEdit);
  @override
  _ImagePickerGalleryState createState() => _ImagePickerGalleryState(student_details,isEdit);
}

class _ImagePickerGalleryState extends State<ImagePickerGallery> {
Student_Details student;
bool _isEdit;
bool hasImage = false;
_ImagePickerGalleryState(this.student,this._isEdit);
File _image;
  Future getImage() async {
    File image;
     image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }



  @override
  Widget build(BuildContext context) {


    Future uploadImage() async{
      if(_image == null){getImage();}
      else {
        Fluttertoast.showToast(msg: "Please Wait! This may take few seconds.",textColor: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
            toastLength:Toast.LENGTH_SHORT );
        StorageReference _storageReference = FirebaseStorage.instance.ref()
            .child("ProfilePics").child(student.uid).child(student.profile_count.toString())
            .child("myProfilePic.jpg");
        StorageUploadTask task = _storageReference.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await task.onComplete;
        var dowURL = await taskSnapshot.ref.getDownloadURL();
        student.imageURL = dowURL.toString();
        await FirebaseDatabase.instance.reference().child("Students").child(
            student.uid).child(student.profile_count.toString()).update(student.toJsonImage());
        if (taskSnapshot != null) {
          Fluttertoast.showToast(msg: "Image uploaded Succesfully!",
              textColor: Colors.white,
              fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
              toastLength: Toast.LENGTH_SHORT);
          if(!_isEdit){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ProfilePage(student)
          ));}
          else{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => EditProfile(student)
            ));
          }
        }
      }
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/RSA_background_1.jpg"),
              fit: BoxFit.cover,
            )
           // color: Colors.white,
        ),
        child: Container(color: Colors.black.withOpacity(0.4),
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(200),
            left: ScreenUtil.getInstance().setWidth(100),
            right: ScreenUtil.getInstance().setWidth(100)),
            child: Column(
              children: <Widget>[
                Container(height: (_image==null)? ScreenUtil.getInstance().setHeight(600):null,
                  width: (_image==null)? ScreenUtil.getInstance().setWidth(600):null,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: ScreenUtil.getInstance().setWidth(5)),
                  ),
                  child: (_image != null)?GestureDetector(onTap: getImage,
                      child: Image.file(_image,height: ScreenUtil.getInstance().setHeight(600),))
                  :GestureDetector( onTap: getImage,
                                    child: Container(color: Colors.grey,
                                        child: Icon(Icons.camera_enhance,color: Colors.black,size: ScreenUtil.getInstance().setHeight(120),))),
                ),
               Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
                     child: Text("Upload your passport size photo or similar sized photo.",
                       style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(45),color: Colors.white),),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                     child: Text("Make sure you crop the photo and upload just the necessary area.",maxLines: 2,
                       style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(45),color: Colors.white),),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                     child: Text("The maximum file size allowed is 1MB.",
                       style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(45),color: Colors.white),),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                     child: Text("The photo uploaded would reflect on your e-IDs.",
                       style: TextStyle(fontSize: ScreenUtil(allowFontScaling: true).setSp(45),color: Colors.white),),
                   ) ,

                 ],),
               Padding(
                 padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                 child: GestureDetector(
                   onTap: uploadImage,
                   child: Row(
                     children: <Widget>[
                       Expanded(
                         child: Container(height: ScreenUtil.getInstance().setHeight(150),
                           width: ScreenUtil.getInstance().setWidth(200),
                           decoration: BoxDecoration(
                             color: Colors.black.withOpacity(0.8),
                             borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(30))
                           ),
                           child: Center(child: (_image!=null)?Text("UPLOAD IMAGE",style: TextStyle(color: Colors.white,fontSize:ScreenUtil(allowFontScaling: true).setSp(40)),):
                           Text("SELECT IMAGE",style: TextStyle(color: Colors.white,fontSize:ScreenUtil(allowFontScaling: true).setSp(40)),)),
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
