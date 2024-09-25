import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);



class AppConstant{
  /// ------ Splash Screen Images
  ///---------------SharePrefs
  static const String onBoarding = 'onBoarding';
  static const String isSkipped = 'isSkipped';
  static  String getOnBoarding = '';
  static  String getIsSkipped = '';
  // final User? user = authResults.user;
  // static userId = user.ui;

  void toastMassage(String massage,bool onError){
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: onError==false ? Colors.green.withOpacity(0.9) :  Colors.redAccent,
        textColor: onError==false ? Colors.white : Colors.white,
        fontSize: 16
    );
  }

  static spinKitCircle() => const Center(
    child: SpinKitWave(
      size: 70,
      color: Colors.orange,
    ),
  );

}

extension EmptySpace on num
{
  SizedBox get ht => SizedBox(height:toDouble());
  SizedBox get wd => SizedBox(width:toDouble());
}