
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/manager/user_manager.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/challenge/challenge_upload.dart';
import 'package:conlamduoc/page/signup/signup_page.dart';
import 'package:conlamduoc/page/forget_password/otp_page.dart';
import 'package:conlamduoc/widget/image_input_field.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeDetail extends StatelessWidget {

  static BuildContext challengeDetailContext;
  final int id;
  final String name;
  final int coin;
  final String image;

  const ChallengeDetail({
    @required this.id,
    this.image,
    this.name,
    this.coin
  });
   
   static final AppBar customAppBar = AppBar(
    centerTitle: true,
    backgroundColor: R.colors.green,
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: R.colors.strongBlue),
      onPressed: () => pop(challengeDetailContext),
    ),
    title: Text(
      R.strings.content,
      textScaleFactor: 1.0,
      style: TextStyle(
        color: R.colors.strongBlue,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );

  static Image wall;

  @override
  Widget build(BuildContext context) {
    challengeDetailContext = context;
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Image.asset(image),
            SizedBox(height: 20,),
            UIButton(
                text: R.strings.challenge,
                textColor: R.colors.strongBlue,
                textSize: 16,
                color: R.colors.oldYellow,
                width: 150,
                height: 40,
                enableShadow: true,
                enable: true,
                fontWeight: FontWeight.bold,
                onTap: () async {
                  print(UserManager.currentUser.name);
                  pushPage(context, ChallengeUpload( 
                    challengeCoins: coin,
                    challengeId: id,
                    challengeName: name,
                    userId: UserManager.currentUser.userId,
                    avatarUrl: UserManager.currentUser.img,
                    fullName: UserManager.currentUser.name,
                  ));
                  //openSelectPhoto(context);
                },
              ),
              
          ],),
        )
      )
    );
  }

  Future<void> openSelectPhoto(BuildContext context) async{
    try {
      var newFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 500, maxHeight: 500);
    } catch (error) {
      print(error);
    }
  }

}
