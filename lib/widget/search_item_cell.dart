import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:conlamduoc/core/R.dart';

class SearchItemCell extends StatelessWidget {
  final EdgeInsets padding;
  final Color bgColor;
  final String imageLeading;
  String imageTrailing;
  final String title;
  final double  titleSize;
  final Widget description;

  SearchItemCell({
   @required this.imageLeading,
    @required this.title,
    @required this.description,
    this.titleSize = 17,
    this.imageTrailing,
    this.padding = const EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
    dynamic trailing,
    this.bgColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    print(this.titleSize);
    return Container(
      height: 80,
      padding: padding,
      color: this.bgColor,
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
            height: 60,
            width: 60,
            child: Image.asset(imageTrailing),
          ):Container()
        ],
      ),
    );
  }
}
