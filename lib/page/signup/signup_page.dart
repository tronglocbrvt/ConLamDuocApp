import 'dart:io';

import 'package:conlamduoc/core/define.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/manager/user_manager.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/widget/my_date_picker/my_date_picker.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  Gender _radioValue = Gender.Male;

  static DateTime _dateTime;

  void _onChangedSearchBox(TextEditingController controller, String data) {
    // TODO: Implement here
  }

  void _onSubmittedSearchBox(TextEditingController controller, String data) {
    if (data.length == 0) return;
    // TODO: Implement here
  }

  void _clearSearchBoxContent(TextEditingController controller) {
    controller.clear();
  }

  Widget _buildInputBox(TextEditingController controller,
      {enable: true, obscureText: false}) {
    return Container(
      width: R.appRatio.deviceWidth,
      height: 40,
      decoration: BoxDecoration(
        color: (enable ? Colors.white : R.colors.grayABABAB),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Input box
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: TextField(
                enabled: enable,
                obscureText: obscureText,
                controller: controller,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                onSubmitted: (data) => _onSubmittedSearchBox(controller, data),
                onChanged: (data) => _onChangedSearchBox(controller, data),
                cursorColor: R.colors.strongBlue,
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: R.strings.info,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ),
              ),
            ),
          ),
          // Clear text button
          GestureDetector(
            onTap: () => _clearSearchBoxContent(controller),
            child: Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: R.colors.strongBlue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(
                R.myIcons.appbarCloseWhiteBold,
                width: 8,
                height: 8,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showBirthdayDateTimePicker(TextEditingController controller) async {
    final DateTime today = new DateTime.now();
    final datePick = await showMyDatePicker(
        context: context,
        initialDate: today,
        firstDate: new DateTime(1900),
        lastDate: today);

    if (datePick != null && datePick != _dateTime) {
      String temp = DateFormat("dd/MM/yyyy").format(datePick);

      // TODO: Update birthday of user => Code here

      setState(() {
        _dateTime = datePick;
        controller.text = temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: R.colors.green,
      body: SafeArea(
          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        Image.asset(
          R.images.welcomeBackground,
          width: R.appRatio.deviceWidth,
          height: R.appRatio.deviceHeight,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          height: 300,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Fullname
                  Text(
                    R.strings.fullName,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_nameController),
                  SizedBox(
                    height: 25,
                  ),
                  // -------------
                  // Birthday
                  Text(
                    R.strings.birthday,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                            _buildInputBox(_birthdayController, enable: false),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              _showBirthdayDateTimePicker(_birthdayController),
                          child: Image.asset(
                            R.myIcons.calendar,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
// -------------
                  // Radio
                  Text(
                    R.strings.gender,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          value: Gender.Male,
                          groupValue: _radioValue,
                          title: Text(
                            R.strings.male,
                            style: TextStyle(fontSize: 14),
                          ),
                          activeColor: R.colors.strongBlue,
                          onChanged: (val) {
                            setState(() {
                              _radioValue = Gender.Male;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: Gender.Female,
                          groupValue: _radioValue,
                          title: Text(
                            R.strings.female,
                            style: TextStyle(fontSize: 14),
                          ),
                          activeColor: R.colors.strongBlue,
                          onChanged: (val) {
                            setState(() {
                              _radioValue = Gender.Female;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // -------------
                  // Parent email
                  Text(
                    R.strings.parentEmail,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_emailController),
                  SizedBox(
                    height: 25,
                  ),
                  // -------------
                  // Parent phone
                  Text(
                    R.strings.parentPhone,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_phoneController),
                  SizedBox(
                    height: 25,
                  ),
                  // -------------
                  // Username
                  Text(
                    R.strings.username,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_usernameController, enable: true),
                  SizedBox(
                    height: 25,
                  ),
                  // -----------------
                  // Forget password
                  Text(
                    R.strings.password,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_passwordController, obscureText: true),
                  SizedBox(
                    height: 25,
                  ),
                  // ---------------
                  // Retype password
                  Text(
                    R.strings.retypePassword,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildInputBox(_retypePasswordController, obscureText: true),
                  SizedBox(
                    height: 25,
                  ),
                  // ------------------
                  // Create account
                  Container(
                    width: R.appRatio.deviceWidth,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => _signUp(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: R.colors.oldYellow,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: UIButton(
                          text: R.strings.create,
                          textColor: R.colors.strongBlue,
                          textSize: 16,
                          color: R.colors.oldYellow,
                          width: 160,
                          height: 40,
                          radius: 100,
                          enableShadow: true,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }

  _signUp(BuildContext context) {
    User newUser = new User();
    newUser.userId = RawDataManager.userList.length;
    newUser.fullName = _nameController.text;
    newUser.username = _usernameController.text;
    newUser.parentPhone = _phoneController.text;
    newUser.parentEmail = _emailController.text;
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
