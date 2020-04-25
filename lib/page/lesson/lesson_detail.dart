import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/widget/custom_dialog.dart/custom_alert_dialog.dart';
import 'package:conlamduoc/widget/custom_videoplayer.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonDetail extends StatefulWidget {
  final String selectedUrl;
  final String title;
  final String content;
  final int coins;
  final String lessonField;

  const LessonDetail({
    this.selectedUrl,
    this.title,
    this.content,
    this.coins,
    this.lessonField,
  })  : assert(selectedUrl != null),
        assert(selectedUrl.length != 0);

  @override
  _LessonDetailState createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  static BuildContext _lessonDetailContext;
  GlobalKey<CustomVideoPlayerState> _cvps = GlobalKey<CustomVideoPlayerState>();
  bool _enableReceiveCoinsBtn;

  @override
  void initState() {
    super.initState();
    _enableReceiveCoinsBtn = false;
  }

  static final AppBar customAppBar = AppBar(
    centerTitle: true,
    backgroundColor: R.colors.green,
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: R.colors.strongBlue),
      onPressed: () => pop(_lessonDetailContext),
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

  void _canReceiveCoins() {
    setState(() {
      _enableReceiveCoinsBtn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _lessonDetailContext = context;
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Container(
          width: R.appRatio.deviceWidth,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                widget.title,
                textScaleFactor: 1.0,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Coins & Lesson field
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Xu: ${widget.coins}",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.oldYellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Loại: ${widget.lessonField}",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: R.colors.oldYellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Content
              Text(
                widget.content,
                textScaleFactor: 1.0,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Video
              CustomVideoPlayer(
                selectedUrl: widget.selectedUrl,
                appBar: customAppBar,
                key: _cvps,
                callBackVideoFinished: () => _canReceiveCoins(),
                autoPlay: true,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  R.strings.lessonWarn,
                  textScaleFactor: 1.0,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: R.colors.gray808080,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              UIButton(
                text: R.strings.receiveCoins,
                textColor:
                    (_enableReceiveCoinsBtn ? Colors.black : Colors.white),
                textSize: 16,
                color: R.colors.oldYellow,
                width: 150,
                height: 40,
                enableShadow: true,
                enable: _enableReceiveCoinsBtn,
                fontWeight: FontWeight.bold,
                onTap: () async {
                  await showCustomAlertDialog(
                    context,
                    title: R.strings.content,
                    content: R.strings.receiveCoinsSuccessfully,
                    firstButtonText: R.strings.ok,
                    firstButtonFunction: () => pop(context),
                  );

                  Future.delayed(
                    Duration(milliseconds: 600),
                    () => pop(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
