import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/material.dart';

class _CustomExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.appRatio.deviceWidth,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Text(
              R.strings.exitApp,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          UIButton(
            color: R.colors.green,
            text: R.strings.yes,
            textSize: 16,
            textColor: R.colors.strongBlue,
            fontWeight: FontWeight.bold,
            enableShadow: false,
            height: 40,
            onTap: () {
              pop(context, true);
            },
          ),
          SizedBox(
            height: 10,
          ),
          UIButton(
            color: Colors.white,
            text: R.strings.no,
            textSize: 16,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
            enableShadow: false,
            border: Border.all(
              color: R.colors.grayABABAB,
            ),
            height: 40,
            onTap: () {
              pop(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<T> showCustomExitDialog<T>(BuildContext context) async {
  return await showGeneralDialog<T>(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _CustomExitDialog(),
        ),
      );
    },
  );
}
