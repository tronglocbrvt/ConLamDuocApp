
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/forget_password/change_pass_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class OTPPage extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              R.images.welcomeBackground,
              width: R.appRatio.deviceWidth,
              height: R.appRatio.deviceHeight,
              fit: BoxFit.cover,
            ),
            Column(
                children: <Widget>[
                  SizedBox(height: 320),
                  Container(
                    width: 300,
                    child: Text("Vui lòng nhập mã OTP đã được gửi đến số điện thoại của bạn"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing10,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _otpController,
                      decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: R.appRatio.appSpacing25),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(50.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white),
                    ),
                  ),
                  SizedBox(height: R.appRatio.appSpacing20,),
                  FlatButton(
                    onPressed: ()=>_checkOTP(context),
                    color: Color(0xFFFFC300),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    child: Container( 
                      child: Text("Xác nhận", style: TextStyle(fontSize: 20),),
                      padding: EdgeInsets.only(top:10,bottom:10),
                    ),
                  )

                ]
              )
            
          ],
        ),
      ),
    );
  }

  _checkOTP(BuildContext context)
  {
    //Check here

    //Demo code = 123456
    if (_otpController.text == "123456")
    {
      //Navigate
      pushPage(context, ChangePasswordPage());
    }
    else
    {
      String msg = "Mã OTP không đúng";
      showAlert(context, R.strings.notice, msg, null);
    }


  }

}
