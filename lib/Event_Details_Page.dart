import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsa_app_official/Events_Details.dart';

class Event_Details_Page extends StatefulWidget {
  EventDetails _details;
  Event_Details_Page(this._details);
  @override
  _Event_Details_PageState createState() => _Event_Details_PageState(_details);
}

class _Event_Details_PageState extends State<Event_Details_Page> {
  EventDetails _eventDetails;
  _Event_Details_PageState(this._eventDetails);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: _eventDetailBody(context,_eventDetails),
    );
  }
}

final topAppBar = new AppBar(
  elevation: 0.1,
  automaticallyImplyLeading: false,
  backgroundColor: Colors.black.withOpacity(0.8),
  title: Text("EVENT DETAILS",
    style: new TextStyle(
      fontSize: ScreenUtil(allowFontScaling: true).setSp(50),
    ),
  ),
);

Container _eventDetailBody(context,EventDetails _eventDetails) => Container(
decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
       fit: BoxFit.cover)
  //color: Colors.white
),
  child: Container(color: Colors.black.withOpacity(0.4),
    child: Padding(
      padding:  EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
      child: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(_eventDetails.title,style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(80),fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(10),horizontal: ScreenUtil.getInstance().setWidth(40)),
            child: Container(height: ScreenUtil.getInstance().setHeight(2),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(50)),
            child: Text(_eventDetails.subTitle,style: TextStyle(color: Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(60)),),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
            child: Container(height: ScreenUtil.getInstance().setHeight(500),
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover,
                  image: NetworkImage(_eventDetails.imageURL)
                )
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
            child: Container(
              child: Text(_eventDetails.desc,style: TextStyle(color:Colors.white,fontSize: ScreenUtil(allowFontScaling: true).setSp(45)),),
            ),
          )

        ],
      ),
    ),
  ),
);