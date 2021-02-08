import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: Container(
        decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
                fit: BoxFit.cover)
        ),
        child: Container(color: Colors.black.withOpacity(0.4),
          child: ListView(
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: CircleAvatar(backgroundImage: AssetImage("images/RSA_Logo_icon.png"),radius: ScreenUtil.getInstance().setWidth(150),)),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(100),
              horizontal: ScreenUtil.getInstance().setWidth(20)),
              child: Text("RSA(Right Sports Academy) is an academy focussed on bringing young and talented sportsperson, starting from the tender age of 6." +
                  " Well qualified coaches and trainers are one of the many perks available here at RSA. "
              + "Our high performance coaching package makes the student develop physically also by including special training sessions for Flexibility,"
                      + " Strengthening, Acceleration and also helps in prevention of injuries. We majorly train students in the field of Football and" +
                  " Athletics(Runninng, Long and High jump, Shotput, Discuss and Javelin throw).",
              style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),),
              textAlign: TextAlign.center,),
            ),

            Container(
              color: Colors.grey,
              height: ScreenUtil.getInstance().setHeight(2),
            ),


            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("MEET OUR COACHES",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(60),fontWeight: FontWeight.bold),),
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
              child: Column(
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Mr. MANIKANDAN",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),)
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("PRESIDENT",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Mr. NIRMAL RAJ",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),)
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("HEAD COACH",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Mr. AROKIYA VIJAY ALBERT",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),)
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("FOOTBALL COACH",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Mr. BOOBESH",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),)
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("ATHLETICS COACH",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(50),fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Container(
                color: Colors.grey,
                height: ScreenUtil.getInstance().setHeight(2),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("MEET OUR DEVELOPER",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(60),fontWeight: FontWeight.bold),),
                ],
              ),
            ),


            Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(50)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Mr. M. ASHWIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),)
                  ],
                )
            ),
            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Container(
                color: Colors.grey,
                height: ScreenUtil.getInstance().setHeight(2),
              ),
            ),


            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("SNAPS FROM WORK",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(60),fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(100)),
              child: Container(
                child: Column(
                  children: <Widget>[
                   Padding(
                     padding:  EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                     child: Image.asset("images/aboutUs_1.jpeg"),
                   ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                      child: Image.asset("images/aboutUs_2.jpeg"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                      child: Image.asset("images/aboutUs_3.jpeg"),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                      child: Image.asset("images/aboutUs_4.jpeg"),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                      child: Image.asset("images/aboutUs_5.jpeg"),
                    ),

                  ],
                ),
              ),
            ),
                    Container(
                      color: Colors.grey,
                      height: ScreenUtil.getInstance().setHeight(2),
                    ),


            Container(
              color: Colors.grey,
              height: ScreenUtil.getInstance().setHeight(2),
            ),

            Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(50)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        launch("https://right-sports-academy.flycricket.io/privacy.html");
                      },
                      child: Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                      decoration: TextDecoration.underline),),
                    )
                  ],
                )
            ),
          ],),
        ),
      ),
    );
  }
}
final topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("ABOUT US",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);
