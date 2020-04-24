
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class WelcomePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    child: Text("Tên đăng nhập"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _usernameController,
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
                  SizedBox(height: R.appRatio.appSpacing15,),
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
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2) - R.appRatio.appSpacing45,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: ()=>_signUp(context),
                        child: Text("Tạo tài khoản mới", style: TextStyle(color: Colors.lightBlue),),
                        ),
                      GestureDetector(
                        child: Text("Quên mật khẩu?", style: TextStyle(color: Colors.lightBlue),),
                        )
                    ],),
                  ),
                  SizedBox(height: R.appRatio.appSpacing20,),
                  GestureDetector(
                    child: Container(
                      width: R.appRatio.appWidth200,                      
                      child: Image.asset(R.images.button_login),
                    ),
                    onTap: ()=>_singIn(context),
                  )
                ]
              )
            
          ],
        ),
      ),
    );
  }

  _singIn(BuildContext context){
    // print(RawDataManager.userList[0].username);
    // if((_usernameController.text == RawDataManager.userList[0].username)
    // ||(_usernameController.text == RawDataManager.userList[1].username)
    // && _passwordController.text =="123")
    //   showPage(context, AppPage());
    // else
    //   showAlert(context, R.strings.notice, "Đăng nhập không thành công", null);

    //Debug
    print(RawDataManager.userList[0].username);
    pushPage(context, AppPage());

  }

  _signUp(BuildContext context){
    pushPage(context, SignUpPage());
  }

}
