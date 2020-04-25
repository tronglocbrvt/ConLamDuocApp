import 'package:flutter/material.dart';
import 'package:conlamduoc/util/reflector.dart';
import 'package:conlamduoc/model/mapper_object.dart';

class R {
  static final _Color colors = _Color();
  static Strings strings = Strings();
  static final _Images images = _Images();
  static final Styles styles = Styles();

  static AppRatio appRatio = AppRatio();
  static _MyIcons myIcons = _MyIcons();

  static void initLocalized(String jsonContent) {
    R.strings = MapperObject.create<Strings>(jsonContent);
  }

  static void initAppRatio(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    appRatio.setUpAppRatio(
        size.width, size.height, devicePixelRatio, textScaleFactor);
  }
}

class AppRatio {
  /* 
    + This is private variables.
    + Figma design information.
  */
  final double _figmaDeviceWidth = 411;
  final double _figmaDeviceHeight = 731;

  final double _figmaFontSize12 = 12;
  final double _figmaFontSize14 = 14;
  final double _figmaFontSize16 = 16;
  final double _figmaFontSize18 = 18;
  final double _figmaFontSize20 = 20;
  final double _figmaFontSize22 = 22;
  final double _figmaFontSize24 = 24;
  final double _figmaFontSize26 = 26;
  final double _figmaFontSize28 = 28;

  final double _figmaWidth70 = 70;
  final double _figmaWidth80 = 80;
  final double _figmaWidth150 = 150;
  final double _figmaWidth181 = 181;
  final double _figmaWidth200 = 200;
  final double _figmaWidth250 = 250;
  final double _figmaWidth300 = 300;
  final double _figmaWidth381 = 381;

  final double _figmaHeight25 = 25;
  final double _figmaHeight30 = 30;
  final double _figmaHeight40 = 40;
  final double _figmaHeight50 = 50;
  final double _figmaHeight60 = 60;
  final double _figmaHeight70 = 70;
  final double _figmaHeight80 = 80;
  final double _figmaHeight320 = 320;

  final double _figmaSpacing5 = 5;
  final double _figmaSpacing10 = 10;
  final double _figmaSpacing15 = 15;
  final double _figmaSpacing20 = 20;
  final double _figmaSpacing25 = 25;
  final double _figmaSpacing30 = 30;
  final double _figmaSpacing35 = 35;
  final double _figmaSpacing40 = 40;
  final double _figmaSpacing45 = 45;
  final double _figmaSpacing50 = 50;

  final double _figmaIconSize15 = 15;
  final double _figmaIconSize18 = 18;
  final double _figmaIconSize20 = 20;
  final double _figmaIconSize25 = 25;
  final double _figmaIconSize30 = 30;
  final double _figmaIconSize35 = 35;
  final double _figmaIconSize40 = 40;

  final double _figmaAppBarIconSize = 22;
  final double _figmaWelcomPageLogoTextSize = 160;
  final double _figmaDropDownImageSquareSize = 40;
  final double _figmaDropDownArrowIconSize = 32;

  final double _figmaAvatarSize130 = 130;
  final double _figmaAvatarSize150 = 150;

  /* 
    + This is public variables.
    + Information of device screen.
  */
  double deviceWidth;
  double deviceHeight;
  double devicePixelRatio;
  double textScaleFactor;

  /*
    + This is public variables.
    + Official and real object information.
  */
  double appFontSize12;
  double appFontSize14;
  double appFontSize16;
  double appFontSize18;
  double appFontSize20;
  double appFontSize22;
  double appFontSize24;
  double appFontSize26;
  double appFontSize28;

  double appWidth70;
  double appWidth80;
  double appWidth150;
  double appWidth181;
  double appWidth200;
  double appWidth250;
  double appWidth300;
  double appWidth381;

  double appHeight25;
  double appHeight30;
  double appHeight40;
  double appHeight50;
  double appHeight60;
  double appHeight70;
  double appHeight80;
  double appHeight320;

  double appSpacing5;
  double appSpacing10;
  double appSpacing15;
  double appSpacing20;
  double appSpacing25;
  double appSpacing30;
  double appSpacing35;
  double appSpacing40;
  double appSpacing45;
  double appSpacing50;

  double appIconSize15;
  double appIconSize18;
  double appIconSize20;
  double appIconSize25;
  double appIconSize30;
  double appIconSize35;
  double appIconSize40;

  double appAppBarIconSize;
  double appWelcomPageLogoTextSize;
  double appDropDownImageSquareSize;
  double appDropDownArrowIconSize;

  double appAvatarSize130;
  double appAvatarSize150;

  /*
    + This is private function.
    + Formula for finding suitable size of object
  */
  double _computeWidth(num figmaObjSize) {
    return (this.deviceWidth / this._figmaDeviceWidth) * figmaObjSize;
  }

  double _computeHeight(num figmaObjSize) {
    double result =
        (this.deviceHeight / this._figmaDeviceHeight) * figmaObjSize;
    return (result <= figmaObjSize)
        ? result
        : ((result <= figmaObjSize + 10)
            ? figmaObjSize
            : ((result <= figmaObjSize + 20)
                ? (figmaObjSize + 10)
                : (figmaObjSize + 15)));
  }

  double _computeFontSize(double desiredFontSize) {
    double result = ((this.textScaleFactor == 1.0)
        ? (_computeWidth(desiredFontSize))
        : (desiredFontSize - (desiredFontSize * (this.textScaleFactor - 1.0))));
    return (result > desiredFontSize) ? desiredFontSize : result;
  }

  /* 
    + This is public function.
    + This is used when initializing application.
    + Set up app ratio.
  */
  void setUpAppRatio(double deviceWidth, double deviceHeight,
      double devicePixelRatio, double textScaleFactor) {
    // Store device width and height
    this.deviceWidth = deviceWidth;
    this.deviceHeight = deviceHeight;
    this.devicePixelRatio = devicePixelRatio;
    this.textScaleFactor = textScaleFactor;
    // print("Width x Height x DPR x TSF: $deviceWidth, $deviceHeight, $devicePixelRatio, $textScaleFactor");

    // Find font size
    appFontSize12 = _computeFontSize(this._figmaFontSize12);
    appFontSize14 = _computeFontSize(this._figmaFontSize14);
    appFontSize16 = _computeFontSize(this._figmaFontSize16);
    appFontSize18 = _computeFontSize(this._figmaFontSize18);
    appFontSize20 = _computeFontSize(this._figmaFontSize20);
    appFontSize22 = _computeFontSize(this._figmaFontSize22);
    appFontSize24 = _computeFontSize(this._figmaFontSize24);
    appFontSize26 = _computeFontSize(this._figmaFontSize26);
    appFontSize28 = _computeFontSize(this._figmaFontSize28);
    // print("Font size: ${this._figmaFontSize22}, $appFontSize22 - ${this._figmaFontSize18}, $appFontSize18");

    // Find width & height of objects
    appWidth70 = _computeWidth(this._figmaWidth70);
    appWidth80 = _computeWidth(this._figmaWidth80);
    appWidth150 = _computeWidth(this._figmaWidth150);
    appWidth181 = _computeWidth(this._figmaWidth181);
    appWidth200 = _computeWidth(this._figmaWidth200);
    appWidth250 = _computeWidth(this._figmaWidth250);
    appWidth300 = _computeWidth(this._figmaWidth300);
    appWidth381 = _computeWidth(this._figmaWidth381);

    appHeight25 = _computeHeight(this._figmaHeight25);
    appHeight30 = _computeHeight(this._figmaHeight30);
    appHeight40 = _computeHeight(this._figmaHeight40);
    appHeight50 = _computeHeight(this._figmaHeight50);
    appHeight60 = _computeHeight(this._figmaHeight60);
    appHeight70 = _computeHeight(this._figmaHeight70);
    appHeight80 = _computeHeight(this._figmaHeight80);
    appHeight320 = _computeHeight(this._figmaHeight320);

    // Find spacing
    appSpacing5 = _computeWidth(this._figmaSpacing5);
    appSpacing10 = _computeWidth(this._figmaSpacing10);
    appSpacing15 = _computeWidth(this._figmaSpacing15);
    appSpacing20 = _computeWidth(this._figmaSpacing20);
    appSpacing25 = _computeWidth(this._figmaSpacing25);
    appSpacing30 = _computeWidth(this._figmaSpacing30);
    appSpacing35 = _computeWidth(this._figmaSpacing35);
    appSpacing40 = _computeWidth(this._figmaSpacing40);
    appSpacing45 = _computeWidth(this._figmaSpacing45);
    appSpacing50 = _computeWidth(this._figmaSpacing50);

    // Find icon size
    appIconSize15 = _computeWidth(this._figmaIconSize15);
    appIconSize18 = _computeWidth(this._figmaIconSize18);
    appIconSize20 = _computeWidth(this._figmaIconSize20);
    appIconSize25 = _computeWidth(this._figmaIconSize25);
    appIconSize30 = _computeWidth(this._figmaIconSize30);
    appIconSize35 = _computeWidth(this._figmaIconSize35);
    appIconSize40 = _computeWidth(this._figmaIconSize40);

    // Find size of other things
    appAppBarIconSize = _computeWidth(this._figmaAppBarIconSize);
    appWelcomPageLogoTextSize =
        _computeWidth(this._figmaWelcomPageLogoTextSize);
    appDropDownImageSquareSize =
        _computeWidth(this._figmaDropDownImageSquareSize);
    appDropDownArrowIconSize = _computeWidth(this._figmaDropDownArrowIconSize);

    // Find size of avatars
    appAvatarSize130 = _computeWidth(this._figmaAvatarSize130);
    appAvatarSize150 = _computeWidth(this._figmaAvatarSize150);

    /*
      ...
      Define MORE here
      ...
    */
  }
}

class _Color {
  // Gradient color
  final Gradient uiGradient = LinearGradient(colors: [
    Color(0xFFFC8800),
    Color(0xFFF26B30),
    Color(0xFFEE4C3E),
    Color(0xFFDA2A16)
  ], stops: [
    0.0,
    0.25,
    0.5,
    1.0
  ]);

  /*
    + [NgocVo] Unused colors
      - final Color yellow = Color(0xFFFC8800);
      - final Color red = Color(0xFFDA2A16);
      - final Color pinkRed = Color(0xFFEE4C3E);
      - final Color blue = Color(0xFF03318C);
  */

  // Official/Main/Common color of app
  Color greenColor = Color(0xFFC6FF59);
  Color lightGreenColor = Color(0xFFF1FFD6);
  Color gray808080 = Color(0xFF808080);
  Color grayABABAB = Color(0xFFABABAB);
  Color oldYellow = Color(0xFFF9C86A);
  Color strongOrange = Color(0xFFFD632C);
  Color blurMajorOrange = Color.fromRGBO(253, 99, 44, 0.5);
  Color lightOrange = Color(0xFFFFC300);
  Color strongBlue = Color(0xFF173F5F);
  Color nicePink = Color(0xFFFFA09E);

  Color contentText = Color(0xFF000000);
  Color orangeNoteText = Color(0xFFFD632C);
  Color normalNoteText = Color(0xFF808080);
  Color lighterNormalNoteText = Color(0xFFABABAB);
  Color appBackground = Color(0xFFFFFFFF);
  Color boxBackground = Color(0xFFFFFFFF);
  Color sectionBackgroundLayer = Color.fromRGBO(255, 235, 222, 0.2);
  Color btnShadow = Color.fromRGBO(0, 0, 0, 0.5);
  Color textShadow = Color.fromRGBO(0, 0, 0, 0.25);
  Color tabLayer = Color.fromRGBO(253, 99, 44, 0.1);
  Color discussionLayer = Color.fromRGBO(253, 99, 44, 0.2);
  Color notiLayer = Color.fromRGBO(253, 99, 44, 0.2);

  Color navigationBar = Color(0xFFC6FF59);
}

class _MyIcons {
  final String appbarFeed = 'assets/icons/home.png';
  final String appbarLesson = 'assets/icons/lesson.png';
  final String appbarChallenge = 'assets/icons/challenge.png';
  final String appbarGame = 'assets/icons/game.png';
  final String appbarProfile = 'assets/icons/profile.png';
  final String appbarSearch = 'assets/icons/search.png';
  final String calendar = "assets/icons/calendar.png";
  final String avatar = "assets/icons/icon_avatar.png";
  final String appbarCloseWhiteBold = 'assets/icons/close_whitebold.png';
  final String add_friend = "assets/icons/add_friend.png";
}

class _Images {
  final String logo = 'assets/logo/logo.png';
  final String welcomeBackground = 'assets/images/welcome_background.png';
  final String button_challenge = "assets/images/button_challenge.png";
  final String button_join = "assets/images/button_join.png";
  final String button_like_color = "assets/images/button_like_color.png";
  final String button_like_nocolor = "assets/images/button_like_nocolor.png";
  final String button_login = "assets/images/button_login.png";
  final String button_quiz = "assets/images/button_quiz.png";
  final String button_joinclass = "assets/images/button_joinclass.png";
  final String title_challenge = "assets/images/title_challenge.png";
  final String title_game = "assets/images/title_game.png";
  final String title_hello = "assets/images/title_hello.png";
  final String title_home = "assets/images/title_home.png";
  final String title_lesson = "assets/images/title_lesson.png";
  final String title_profile = "assets/images/title_profile.png";

  final String avatar = "assets/images/avatar.png";

  final String whale_image = "assets/images/whale_image.png";
}

@reflector
class Strings {
  String ok;
  String error;
  String notice;

  String feed;
  String lesson;
  String challenge;
  String friend;
  String game;
  String profile;
  String search;
  String searchHint;

  String content;
  String lessonWarn;
  String receiveCoins;
  String receiveCoinsSuccessfully;
}

class Styles {}
