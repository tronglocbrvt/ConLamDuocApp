import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class FeedPage extends StatelessWidget{

   @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: R.colors.appBackground,
      body: Center(child: Text(R.strings.feed),),
    );
  }
}