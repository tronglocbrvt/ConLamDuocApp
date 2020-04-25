
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/page/forget_password/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
 
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
                  SizedBox(height: R.appRatio.appWidth300 - R.appRatio.appSpacing20),
                  Container(
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    margin: EdgeInsets.only(left: R.appRatio.appSpacing45),
                    child: Text("Email phụ huynh"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _emailController,
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
                    onPressed: (){pushPage(context, OTPPage());},
                    color: Color(0xFFFFC300),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    child: Container( 
                      child: Text("Lấy lại mật khẩu", style: TextStyle(fontSize: 20),),
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

}
