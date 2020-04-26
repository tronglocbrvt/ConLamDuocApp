import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/forget_password/otp_page.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

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
                  // Forget password
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
                  Container(
                    width: R.appRatio.deviceWidth,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        pushPage(context, OTPPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: R.colors.oldYellow,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: UIButton(
                          text: "Lấy lại mật khẩu",
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
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 180,
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
}
