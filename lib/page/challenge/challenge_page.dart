import 'package:conlamduoc/page/profile/profile_pae.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class ChallengePage extends StatelessWidget{

   @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: R.colors.navigationBar,
        leading: Image.asset(R.images.logo, width: R.appRatio.appWidth70,),
        middle: Image.asset(R.images.title_challenge, height: R.appRatio.appSpacing50,),
        trailing: GestureDetector( 
          onTap: ()=>pushPage(context, ProfilePage()),
          child: Image.asset(R.myIcons.appbarProfile, height: R.appRatio.appSpacing30,),
        ),
      ),
      backgroundColor: R.colors.appBackground,
      body: Center(child: Text(R.strings.challenge),),
    );
  }
}