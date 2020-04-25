import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:conlamduoc/core/R.dart';

class SearchItemCell extends StatelessWidget {
  final EdgeInsets padding;
  final Color bgColor;
  final String imageLeading;
  Widget imageTrailing;
  final String title;
  final double  titleSize;
  final Widget description;
  final GestureTapCallback onTap;

  SearchItemCell({
   @required this.imageLeading,
    @required this.title,
    @required this.description,
    @required this.onTap,
    this.titleSize = 17,
    this.imageTrailing,
    this.padding = const EdgeInsets.all(10),
    dynamic trailing,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    print(this.titleSize);
    return GestureDetector( 
      onTap: this.onTap,
      child: Container(
      height: 90,
      width: R.appRatio.deviceWidth - 40,
      constraints: BoxConstraints(maxHeight: 100),
      decoration: BoxDecoration(
        color: this.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: Offset(1.0, 1.0),
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Container(
          height: 60,
          width: 60,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imageLeading)
              )
          )),
          imageTrailing!=null?
          Container( 
            width: 200,
            height: 80,
            alignment: Alignment.topLeft,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( 
            alignment: Alignment.centerLeft,
              child: Text(title, overflow: TextOverflow.ellipsis,
               style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),),
            ),
            Container( 
            height: 40,
            alignment: Alignment.centerLeft,
              child: description,
            )
          ],),
          ):Container( 
            width: 260,
            height: 80,
            alignment: Alignment.topLeft,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( 
            alignment: Alignment.centerLeft,
              child: Text(title, overflow: TextOverflow.ellipsis,
               style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),),
            ),
            Container( 
            height: 40,
            alignment: Alignment.centerLeft,
              child: description,
            )
          ],),),
          imageTrailing!=null? Container( 
            child: imageTrailing,
          ):Container()
        ],
      ),
    ),
    );
  }
}
