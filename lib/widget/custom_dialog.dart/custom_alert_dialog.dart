import 'package:conlamduoc/core/R.dart';
import 'package:flutter/material.dart';

class _CustomAlertDialog extends StatelessWidget {
  const _CustomAlertDialog({
    Key key,
    @required this.title,
    @required this.content,
    @required this.firstButtonText,
    @required this.firstButtonFunction,
    this.secondButtonText = "",
    this.secondButtonFunction,
  })  : assert(title != null &&
            content != null &&
            firstButtonText != null &&
            firstButtonFunction != null &&
            secondButtonText != null),
        assert(title.length != 0 &&
            content.length != 0 &&
            firstButtonText.length != 0),
        super(key: key);

  final String title;
  final String content;
  final String firstButtonText;
  final Function firstButtonFunction;
  final String secondButtonText;
  final Function secondButtonFunction;

  final double radius = 10;
  static bool existSecondButton = false;

  @override
  Widget build(BuildContext context) {
    if (this.secondButtonText.length != 0 &&
        this.secondButtonFunction != null) {
      existSecondButton = true;
    }
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              color: R.colors.green,
            ),
            child: Text(
              this.title,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: R.colors.strongBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(top: 20, bottom: 15),
            alignment: Alignment.center,
            child: Text(
              this.content,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
                wordSpacing: 2.0,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: (existSecondButton
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                padding: EdgeInsets.all(0),
                textColor: Colors.white,
                splashColor: R.colors.lightGreen,
                child: Container(
                  width: 80,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    this.firstButtonText,
                    style: TextStyle(
                      color: R.colors.strongBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => this.firstButtonFunction(),
              ),
              (existSecondButton
                  ? FlatButton(
                      padding: EdgeInsets.all(0),
                      textColor: Colors.white,
                      splashColor: R.colors.lightGreen,
                      child: Container(
                        width: 80,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          this.secondButtonText,
                          style: TextStyle(
                            color: R.colors.strongBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () => this.secondButtonFunction(),
                    )
                  : Container()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Future<T> showCustomAlertDialog<T>(
  BuildContext context, {
  Key key,
  @required title,
  @required content,
  @required firstButtonText,
  @required firstButtonFunction,
  secondButtonText = "",
  secondButtonFunction,
}) async {
  return await showGeneralDialog(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: anim1,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.center,
          child: _CustomAlertDialog(
            title: title,
            content: content,
            firstButtonText: firstButtonText,
            firstButtonFunction: firstButtonFunction,
            secondButtonText: secondButtonText,
            secondButtonFunction: secondButtonFunction,
          ),
        ),
      );
    },
  );
}
