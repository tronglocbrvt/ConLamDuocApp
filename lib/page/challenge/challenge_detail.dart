
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/page/forget_password/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

class ChallengeDetail extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container()
    );
  }

  _goToAppPage(BuildContext context)
  {
    //Check logic here

    //Navigate
    pushPage(context, AppPage());
  }

}
