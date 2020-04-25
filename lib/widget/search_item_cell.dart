import 'package:conlamduoc/widget/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:conlamduoc/core/R.dart';

class SearchItemCell extends StatefulWidget {
  @override
  _SearchItemCellState createState() => _SearchItemCellState();

  final EdgeInsets padding;
  final Color backgroundColor;
  final String imageLeading;
  final Widget imageTrailing;
  final Widget imageTrailingAfterTap;
  final String title;
  final double titleSize;
  final Widget description;
  final GestureTapCallback onTap;

  SearchItemCell({
    @required this.imageLeading,
    @required this.title,
    @required this.description,
    @required this.onTap,
    this.imageTrailingAfterTap,
    this.titleSize = 16,
    this.imageTrailing,
    this.padding = const EdgeInsets.all(10),
    dynamic trailing,
    this.backgroundColor = Colors.white,
  });
}

class _SearchItemCellState extends State<SearchItemCell> {
  static final double radius = 10;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Container(
        width: R.appRatio.deviceWidth,
        constraints: BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
          color: this.widget.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AvatarView(
              avatarImageURL: widget.imageLeading,
              avatarImageSize: 60,
              avatarBoxBorder: Border.all(
                width: 2,
                color: R.colors.oldYellow,
              ),
              pressAvatarImage: () {
                // TODO: Code here
                print("[SEARCH ITEM CELL] Pressing avatar image");
              },
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: widget.titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  widget.description,
                ],
              ),
            ),
            (tapped == false)
                ? (widget.imageTrailing != null)
                    ? GestureDetector(
                        child: widget.imageTrailing,
                        onTap: () {
                          if (widget.imageTrailingAfterTap != null) {
                            setState(() {
                              tapped = !tapped;
                            });
                          }
                        },
                      )
                    : Container()
                : (widget.imageTrailingAfterTap != null)
                    ? GestureDetector(
                        child: widget.imageTrailingAfterTap,
                        onTap: () {
                          setState(() {
                            tapped = !tapped;
                          });
                        },
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
