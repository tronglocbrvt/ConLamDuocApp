import "package:flutter/material.dart";
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/util/image_cache_manager.dart';

class CustomPopupMenu extends StatefulWidget {
  final List items;
  final Function onSelected;
  final Image popupImage;

  /*
    Structure of the "items" variable: 
    [
      {
        "iconURL": "...",                [This has value of an ASSET]
        "iconSize": R.appRatio.appIconSize15
        "title": "Block this post",
      },
      ...
    ]
  */

  CustomPopupMenu({
    @required this.items,
    @required this.onSelected(index),
    @required this.popupImage,
  }) : assert(items != null && onSelected != null && popupImage != null);

  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      child: PopupMenuButton<dynamic>(
        padding: EdgeInsets.all(0),
        elevation: 4.0,
        initialValue: null,
        onSelected: widget.onSelected,
        icon: widget.popupImage,
        itemBuilder: (BuildContext context) {
          List popupList = List<PopupMenuEntry<dynamic>>();
          for (int i = 0; i < widget.items.length; ++i) {
            dynamic element = widget.items[i];
            double iconSize = element['iconSize'];
            if (iconSize <= 2.0) {
              element = R.appRatio.appIconSize15;
            }
            popupList.add(
              PopupMenuItem(
                value: i,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: ImageCacheManager.getImage(
                        url: element['iconURL'],
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      element['title'],
                      style: TextStyle(
                        fontSize: R.appRatio.appFontSize18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return popupList;
        },
      ),
    );
  }
}
