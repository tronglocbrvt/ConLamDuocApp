import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:conlamduoc/core/R.dart';

class SearchItemCell extends StatefulWidget {
  @override
  _SearchItemCellState createState() => _SearchItemCellState();
  
  final EdgeInsets padding;
  final Color bgColor;
  final AssetImage imageLeading;
  Widget imageTrailing;
  Widget trailingAfterTap;
  final String title;
  final double  titleSize;
  final Widget description;
  final GestureTapCallback onTap;

  SearchItemCell({
   @required this.imageLeading,
    @required this.title,
    @required this.description,
    @required this.onTap,
    this.trailingAfterTap,
    this.titleSize = 17,
    this.imageTrailing,
    this.padding = const EdgeInsets.all(10),
    dynamic trailing,
    this.bgColor = Colors.white,
  });

}

class _SearchItemCellState extends State<SearchItemCell> {

  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    print(widget.titleSize);
    return GestureDetector( 
      onTap: this.widget.onTap,
      child: Container(
      width: R.appRatio.deviceWidth - 40,
      constraints: BoxConstraints(maxHeight: 100),
      decoration: BoxDecoration(
        color: this.widget.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: Offset(1.0, 1.0),
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Container(
          constraints:BoxConstraints(maxHeight: (R.appRatio.deviceWidth-40)*0.2, maxWidth: (R.appRatio.deviceWidth-40)*0.2),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.imageLeading
              )
          )),
          widget.imageTrailing!=null?
          Container( 
            width: (R.appRatio.deviceWidth-40)*0.6,
            height: 80,
            alignment: Alignment.topLeft,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( 
            alignment: Alignment.centerLeft,
              child: Text(widget.title, overflow: TextOverflow.ellipsis,
               style: TextStyle(fontSize: widget.titleSize, fontWeight: FontWeight.bold),),
            ),
            Container( 
            height: 40,
            alignment: Alignment.centerLeft,
              child: widget.description,
            )
          ],),
          ):Container( 
            constraints: BoxConstraints(maxWidth: (R.appRatio.deviceWidth-40)*0.6),
            height: 80,
            alignment: Alignment.topLeft,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( 
            alignment: Alignment.centerLeft,
              child: Text(widget.title, overflow: TextOverflow.ellipsis,
               style: TextStyle(fontSize: widget.titleSize, fontWeight: FontWeight.bold),),
            ),
            Container( 
            height: 40,
            alignment: Alignment.centerLeft,
              child: widget.description,
            )
          ],),),
          tapped==false?
          widget.imageTrailing!=null? Container( 
            child: GestureDetector( 
              child: widget.imageTrailing,
              onTap: (){
                if (widget.trailingAfterTap!=null)
                {
                  setState(() {
                    tapped = !tapped;
                  });
                }
              },
            ),
          ):Container():
          widget.trailingAfterTap!=null? Container( 
            width: (R.appRatio.deviceWidth-40)*0.2,
            child: GestureDetector( 
              child: widget.trailingAfterTap,
              onTap: (){setState(() {
                tapped = !tapped;
              });},
            ),
          ):Container()
        ],
      ),
    ),
    );
  }
}
