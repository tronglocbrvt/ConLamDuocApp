
import 'dart:io';

import 'package:conlamduoc/core/define.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/manager/user_manager.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:path_provider/path_provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
  }
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  Gender _radioValue = Gender.Male;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              R.images.welcomeBackground,
              width: R.appRatio.deviceWidth,
              height: R.appRatio.deviceHeight,
              fit: BoxFit.cover,
            ),
            Align( 
              alignment: Alignment.center,
              child: Container(      
              height: 340,
              margin: EdgeInsets.only(),
              child: ScrollConfiguration( 
                behavior: MyBehavior(),
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //SizedBox(height: R.appRatio.appWidth300 - R.appRatio.appSpacing20),
                  Container(
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    margin: EdgeInsets.only(left: R.appRatio.appSpacing45),
                    child: Text("Họ tên"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _nameController,
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
                    child: Text("Ngày sinh"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container( 
                        width: 270,
                        child: TextField(
                          controller: _birthdayController,
                          enabled: false,
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
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                            _birthdayController.text = '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
                          }, currentTime: DateTime.now(), locale: LocaleType.vi);
                          },
                        child: Image.asset(R.myIcons.calendar,width: 30, height: 50,),
                        )
                    ],),
                  ),
                  SizedBox(height: R.appRatio.appSpacing15,),
                  Container(
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    margin: EdgeInsets.only(left: R.appRatio.appSpacing45),
                    child: Text("Giới tính"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    height: 40,
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: Gender.Male,
                              groupValue: _radioValue,
                              title:Text("Nam"),
                              activeColor: Colors.red,
                              onChanged: (val) {
                              setState(() {
                                _radioValue = Gender.Male;
                              });
                            },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: Gender.Female,
                              groupValue: _radioValue,
                              title: Text("Nữ"),
                              activeColor: Colors.red,
                              onChanged: (val) {
                              setState(() {
                                _radioValue = Gender.Female;
                              });
                            },
                            ),
                          ),
                    ],)
                  ),
                  SizedBox(height: R.appRatio.appSpacing20,),
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
                  Container(
                    width: R.appRatio.deviceWidth - (R.appRatio.appSpacing50*2),
                    margin: EdgeInsets.only(left: R.appRatio.appSpacing45),
                    child: Text("SĐT phụ huynh"),
                  ),
                  SizedBox(height: R.appRatio.appSpacing5,),
                  Container( 
                    padding: EdgeInsets.only(left: R.appRatio.appSpacing50, right: R.appRatio.appSpacing50),
                    child: TextField(
                      controller: _phoneController,
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
                  SizedBox(height: R.appRatio.appSpacing20,),
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
                    onPressed: ()=>_signUp(context),
                    color: Color(0xFFFFC300),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    child: Container( 
                      child: Text("Tạo tài khoản", style: TextStyle(fontSize: 20),),
                      padding: EdgeInsets.only(top:10,bottom:10),
                    ),
                  )

                ]
              )
            ),
              )
            ),
            ),
             
          ],
        ),
      ),
    );
  }


  _signUp(BuildContext context){
    User newUser = new User();
    newUser.userId = RawDataManager.userList.length;
    newUser.name = _nameController.text;
    newUser.username = _usernameController.text;
    newUser.phone = _phoneController.text;
    newUser.email = _emailController.text;
    newUser.gender = _radioValue;

    RawDataManager.userList.add(newUser);
    UserManager.currentUser.copy(newUser);
    print(UserManager.currentUser.toJson().toString());
    
    pushPage(context, AppPage());
  }

 
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}