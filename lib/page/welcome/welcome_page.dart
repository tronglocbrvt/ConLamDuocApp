import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/manager/user_manager.dart';
import 'package:conlamduoc/page/forget_password/forget_pass_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class WelcomePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: R.colors.green,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
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
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Login username
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
                  _buildInputBox(_usernameController),
                  SizedBox(
                    height: 25,
                  ),
                  // Mật khẩu
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
                  // Create new account & forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _signUp(context),
                        child: Text(
                          R.strings.createNewAccount,
                          style: TextStyle(color: R.colors.strongBlue),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pushPage(context, ForgetPasswordPage());
                        },
                        child: Text(
                          R.strings.forgotPassword,
                          style: TextStyle(color: R.colors.strongBlue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: R.appRatio.deviceWidth,
                    child: GestureDetector(
                      child: Container(
                        width: R.appRatio.appWidth150,
                        height: R.appRatio.appHeight50,
                        child: Image.asset(R.images.button_login),
                      ),
                      onTap: () => _singIn(context),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _singIn(BuildContext context) {
    // print(RawDataManager.userList[0].username);
    // if((_usernameController.text == RawDataManager.userList[0].username)
    // ||(_usernameController.text == RawDataManager.userList[1].username)
    // && _passwordController.text =="123")
    //   showPage(context, AppPage());
    // else
    //   showAlert(context, R.strings.notice, "Đăng nhập không thành công", null);

    //Debug
    print(RawDataManager.userList[0].name);
    UserManager.currentUser.copy(RawDataManager.userList[0]);
    pushPage(context, AppPage());
  }

  _signUp(BuildContext context) {
    pushPage(context, SignUpPage());
  }
}
