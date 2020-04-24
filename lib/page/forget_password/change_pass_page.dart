
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/page/forget_password/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class ChangePasswordPage extends StatelessWidget {
   final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();
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
                    child: Text("Mật khẩu"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
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
                  Container(
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    margin: EdgeInsets.only(left: R.appRatio.appSpacing45),
                    child: Text("Nhập lại mật khẩu"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _retypePasswordController,
                      obscureText: true,
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
                    onPressed: ()=> _goToAppPage(context),
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

  _goToAppPage(BuildContext context)
  {
    //Check logic here

    //Navigate
    pushPage(context, AppPage());
  }

}
