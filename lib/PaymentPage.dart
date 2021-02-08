import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_app_official/Student_Details.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  Student_Details _student_details;
  PaymentPage(this._student_details);

  @override
  _PaymentPageState createState() => _PaymentPageState(_student_details);
}

class _PaymentPageState extends State<PaymentPage> {
  Student_Details student;
  _PaymentPageState(this.student);
  Future _transaction;
  double amt;

  getFee() async {
    await FirebaseDatabase.instance.reference().child("Fee").
    once().then((DataSnapshot snapshot){
      amt = double.parse(snapshot.value['Fees']);
    });
  }


  Future<String> initiateTransaction(String app) async {

    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: 'maniarjun71@okicici',
      receiverName: 'Right Sports Academy',
      transactionRefId: '1234',
      transactionNote: 'Monthly Fee - ' + student.name + ', Sport: ' + student.sport + ', Age: ' + student.age +
          ', Class: ' + student.std.toString() ,
      amount: amt??300,
    );

    String response = await upi.startTransaction();

    return response;
  }

  @override
  void initState() {
    super.initState();
    getFee();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/RSA_background_1.jpg"),
              fit: BoxFit.cover),
          // color: Colors.white
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: ListView(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("PAYMENT",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/15),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("RECIPIENT:",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                    Text(" MR. R. MANIKANDAN",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("NET BANKING",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/17),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("A/C NUMBER:",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/60,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("736701500089",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
                      child: GestureDetector(onTap: (){
                        Clipboard.setData(ClipboardData(text:"736701500089" ));
                        Fluttertoast.showToast(
                          msg: "Copied to Clipboard",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                        );
                        setState(() {
                        });
                      },
                          child: Icon(Icons.content_copy,size: MediaQuery.of(context).size.width/15,color: Colors.white,)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("IFSC:",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/60,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("ICIC0007367",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
                      child: GestureDetector(onTap: (){
                        Fluttertoast.showToast(
                          msg: "Copied to Clipboard",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                        );
                        setState(() {
                          Clipboard.setData(ClipboardData(text:"ICIC0007367" ));
                        });
                      },
                          child: Icon(Icons.content_copy,size: MediaQuery.of(context).size.width/15,color: Colors.white,)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("BHIM-UPI PAYMENT",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/17),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("UPI - ID:",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/60,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("maniarjun71@okicici",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
                      child: GestureDetector(onTap: (){
                        Fluttertoast.showToast(
                          msg: "Copied to Clipboard",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                        );
                        setState(() {
                          Clipboard.setData(ClipboardData(text:"maniarjun71@okicici" ));
                        });
                      },
                          child: Icon(Icons.content_copy,size: MediaQuery.of(context).size.width/15,color: Colors.white,)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Phone Number:",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/50,
                    left: MediaQuery.of(context).size.width/15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("9884062191",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/20),),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
                      child: GestureDetector(onTap: (){
                        Fluttertoast.showToast(
                          msg: "Copied to Clipboard",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(40),
                        );
                        setState(() {
                          Clipboard.setData(ClipboardData(text:"abcd@upiidbank" ));
                        });
                      },
                          child: Icon(Icons.content_copy,size: MediaQuery.of(context).size.width/15,color: Colors.white,)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
                child: Text('Pay now with Google Pay'),
                onPressed: () {
                  _transaction = initiateTransaction(UpiIndiaApps.GooglePay);
                  setState(() {});
                }),
        ),
        FutureBuilder(
          future: _transaction,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null)
                return Text(' ');
              else {
                switch (snapshot.data.toString()) {
                  case UpiIndiaResponseError.APP_NOT_INSTALLED:
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/50),
                      child: Text("App is not installed!",
                        style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20,
                            fontWeight: FontWeight.bold)
                        ,),
                    );
                    break;
                  case UpiIndiaResponseError.INVALID_PARAMETERS:
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/50),
                      child: Text(
                        'Requested payment is invalid.',
                          style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20,
                          fontWeight: FontWeight.bold)
                      ),
                    );
                    break;
                  case UpiIndiaResponseError.USER_CANCELLED:
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/50),
                      child: Text(
                        'It seems like you cancelled the transaction.',
                          style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20,
                              fontWeight: FontWeight.bold)
                      ),
                    );
                    break;
                  case UpiIndiaResponseError.NULL_RESPONSE:
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/50),
                      child: Text(
                        'No data received',
                          style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/20,
                              fontWeight: FontWeight.bold)
                      ),
                    );
                    break;
                  default:
                    UpiIndiaResponse _upiResponse;
                    _upiResponse = UpiIndiaResponse(snapshot.data);
                    String txnId = _upiResponse.transactionId;
                    String resCode = _upiResponse.responseCode;
                    String txnRef = _upiResponse.transactionRefId;
                    String status = _upiResponse.status;
                    String approvalRef = _upiResponse.approvalRefNo;
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/60,
                      horizontal: MediaQuery.of(context).size.width/20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Transaction Id: $txnId \n\n' +
                              'Response Code: $resCode \n\n' +
                              'Status: $status \n\n', style: TextStyle(color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width/20,
                          fontWeight: FontWeight.bold),),
                        ],
                      ),
                    );
                }
              }
          },
        )
      ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}
