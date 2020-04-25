import 'package:flutter/material.dart';
import 'package:conlamduoc/util/reflector.dart';
import 'package:conlamduoc/model/mapper_object.dart';

class R {
  static final _Color colors = _Color();
  static Strings strings = Strings();
  static final _Images images = _Images();
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
  final double _figmaFontSize32 = 32;
  final double _figmaFontSize34 = 34;
  final double _figmaFontSize36 = 36;
  final double _figmaFontSize38 = 38;
  final double _figmaFontSize40 = 40;
  final double _figmaFontSize42 = 42;

  final double _figmaWidth40 = 40;
  final double _figmaWidth50 = 50;
  final double _figmaWidth60 = 60;
  final double _figmaWidth70 = 70;
  final double _figmaWidth80 = 80;
  final double _figmaWidth90 = 90;
  final double _figmaWidth100 = 100;
  final double _figmaWidth110 = 110;
  final double _figmaWidth120 = 120;
  final double _figmaWidth130 = 130;
  final double _figmaWidth140 = 140;
  final double _figmaWidth150 = 150;
  final double _figmaWidth160 = 160;
  final double _figmaWidth170 = 170;
  final double _figmaWidth181 = 181;
  final double _figmaWidth190 = 190;
  final double _figmaWidth200 = 200;
  final double _figmaWidth210 = 210;
  final double _figmaWidth220 = 220;
  final double _figmaWidth230 = 230;
  final double _figmaWidth240 = 240;
  final double _figmaWidth250 = 250;
  final double _figmaWidth260 = 260;
  final double _figmaWidth270 = 270;
  final double _figmaWidth280 = 280;
  final double _figmaWidth290 = 290;
  final double _figmaWidth300 = 300;
  final double _figmaWidth310 = 310;
  final double _figmaWidth320 = 320;
  final double _figmaWidth330 = 330;
  final double _figmaWidth340 = 340;
  final double _figmaWidth350 = 350;
  final double _figmaWidth360 = 360;
  final double _figmaWidth370 = 370;
  final double _figmaWidth381 = 381;

  final double _figmaHeight10 = 10;
  final double _figmaHeight15 = 15;
  final double _figmaHeight20 = 20;
  final double _figmaHeight25 = 25;
  final double _figmaHeight30 = 30;
  final double _figmaHeight40 = 40;
  final double _figmaHeight45 = 45;
  final double _figmaHeight50 = 50;
  final double _figmaHeight60 = 60;
  final double _figmaHeight70 = 70;
  final double _figmaHeight80 = 80;
  final double _figmaHeight90 = 90;
  final double _figmaHeight100 = 100;
  final double _figmaHeight110 = 110;
  final double _figmaHeight120 = 120;
  final double _figmaHeight130 = 130;
  final double _figmaHeight140 = 140;
  final double _figmaHeight150 = 150;
  final double _figmaHeight160 = 160;
  final double _figmaHeight170 = 170;
  final double _figmaHeight180 = 180;
  final double _figmaHeight190 = 190;
  final double _figmaHeight200 = 200;
  final double _figmaHeight210 = 210;
  final double _figmaHeight220 = 220;
  final double _figmaHeight230 = 230;
  final double _figmaHeight240 = 240;
  final double _figmaHeight250 = 250;
  final double _figmaHeight260 = 260;
  final double _figmaHeight270 = 270;
  final double _figmaHeight280 = 280;
  final double _figmaHeight290 = 290;
  final double _figmaHeight300 = 300;
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

  final double _figmaIconSize5 = 5;
  final double _figmaIconSize10 = 10;
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
  final double _figmaEventBadgeSize = 80;
  final double _figmaPhotoThumbnailSize = 80;

  final double _figmaAvatarSize80 = 80;
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
  double appFontSize32;
  double appFontSize34;
  double appFontSize36;
  double appFontSize38;
  double appFontSize40;
  double appFontSize42;

  double appWidth40;
  double appWidth50;
  double appWidth60;
  double appWidth70;
  double appWidth80;
  double appWidth90;
  double appWidth100;
  double appWidth110;
  double appWidth120;
  double appWidth130;
  double appWidth140;
  double appWidth150;
  double appWidth160;
  double appWidth170;
  double appWidth181;
  double appWidth190;
  double appWidth200;
  double appWidth210;
  double appWidth220;
  double appWidth230;
  double appWidth240;
  double appWidth250;
  double appWidth260;
  double appWidth270;
  double appWidth280;
  double appWidth290;
  double appWidth300;
  double appWidth310;
  double appWidth320;
  double appWidth330;
  double appWidth340;
  double appWidth350;
  double appWidth360;
  double appWidth370;
  double appWidth381;

  double appHeight10;
  double appHeight15;
  double appHeight20;
  double appHeight25;
  double appHeight30;
  double appHeight40;
  double appHeight45;
  double appHeight50;
  double appHeight60;
  double appHeight70;
  double appHeight80;
  double appHeight90;
  double appHeight100;
  double appHeight110;
  double appHeight120;
  double appHeight130;
  double appHeight140;
  double appHeight150;
  double appHeight160;
  double appHeight170;
  double appHeight180;
  double appHeight190;
  double appHeight200;
  double appHeight210;
  double appHeight220;
  double appHeight230;
  double appHeight240;
  double appHeight250;
  double appHeight260;
  double appHeight270;
  double appHeight280;
  double appHeight290;
  double appHeight300;
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

  double appIconSize5;
  double appIconSize10;
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
  double appEventBadgeSize;
  double appPhotoThumbnailSize;

  double appAvatarSize80;
  double appAvatarSize130;
  double appAvatarSize150;

  /*
    + This is private function.
    + Formula for finding suitable size of object
  */
  double _computeWidth(num figmaObjSize) {
    return ((this.deviceWidth / this._figmaDeviceWidth) * figmaObjSize)
        .roundToDouble();
  }

  double _computeHeight(num figmaObjSize) {
    double result =
        ((this.deviceHeight / this._figmaDeviceHeight) * figmaObjSize)
            .roundToDouble();
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
    this.deviceWidth = deviceWidth.roundToDouble();
    this.deviceHeight = deviceHeight.roundToDouble();
    this.devicePixelRatio = devicePixelRatio.roundToDouble();
    this.textScaleFactor = textScaleFactor.roundToDouble();

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
    appFontSize32 = _computeFontSize(this._figmaFontSize32);
    appFontSize34 = _computeFontSize(this._figmaFontSize34);
    appFontSize36 = _computeFontSize(this._figmaFontSize36);
    appFontSize38 = _computeFontSize(this._figmaFontSize38);
    appFontSize40 = _computeFontSize(this._figmaFontSize40);
    appFontSize42 = _computeFontSize(this._figmaFontSize42);

    // Find width & height of objects
    appWidth40 = _computeWidth(this._figmaWidth40);
    appWidth50 = _computeWidth(this._figmaWidth50);
    appWidth60 = _computeWidth(this._figmaWidth60);
    appWidth70 = _computeWidth(this._figmaWidth70);
    appWidth80 = _computeWidth(this._figmaWidth80);
    appWidth90 = _computeWidth(this._figmaWidth90);
    appWidth100 = _computeWidth(this._figmaWidth100);
    appWidth110 = _computeWidth(this._figmaWidth110);
    appWidth120 = _computeWidth(this._figmaWidth120);
    appWidth130 = _computeWidth(this._figmaWidth130);
    appWidth140 = _computeWidth(this._figmaWidth140);
    appWidth150 = _computeWidth(this._figmaWidth150);
    appWidth160 = _computeWidth(this._figmaWidth160);
    appWidth170 = _computeWidth(this._figmaWidth170);
    appWidth181 = _computeWidth(this._figmaWidth181);
    appWidth190 = _computeWidth(this._figmaWidth190);
    appWidth200 = _computeWidth(this._figmaWidth200);
    appWidth210 = _computeWidth(this._figmaWidth210);
    appWidth220 = _computeWidth(this._figmaWidth220);
    appWidth230 = _computeWidth(this._figmaWidth230);
    appWidth240 = _computeWidth(this._figmaWidth240);
    appWidth250 = _computeWidth(this._figmaWidth250);
    appWidth260 = _computeWidth(this._figmaWidth260);
    appWidth270 = _computeWidth(this._figmaWidth270);
    appWidth280 = _computeWidth(this._figmaWidth280);
    appWidth290 = _computeWidth(this._figmaWidth290);
    appWidth300 = _computeWidth(this._figmaWidth300);
    appWidth310 = _computeWidth(this._figmaWidth310);
    appWidth320 = _computeWidth(this._figmaWidth320);
    appWidth330 = _computeWidth(this._figmaWidth330);
    appWidth340 = _computeWidth(this._figmaWidth340);
    appWidth350 = _computeWidth(this._figmaWidth350);
    appWidth360 = _computeWidth(this._figmaWidth360);
    appWidth370 = _computeWidth(this._figmaWidth370);
    appWidth381 = _computeWidth(this._figmaWidth381);

    appHeight10 = _computeHeight(this._figmaHeight10);
    appHeight15 = _computeHeight(this._figmaHeight15);
    appHeight20 = _computeHeight(this._figmaHeight20);
    appHeight25 = _computeHeight(this._figmaHeight25);
    appHeight30 = _computeHeight(this._figmaHeight30);
    appHeight40 = _computeHeight(this._figmaHeight40);
    appHeight45 = _computeHeight(this._figmaHeight45);
    appHeight50 = _computeHeight(this._figmaHeight50);
    appHeight60 = _computeHeight(this._figmaHeight60);
    appHeight70 = _computeHeight(this._figmaHeight70);
    appHeight80 = _computeHeight(this._figmaHeight80);
    appHeight90 = _computeHeight(this._figmaHeight90);
    appHeight100 = _computeHeight(this._figmaHeight100);
    appHeight110 = _computeHeight(this._figmaHeight110);
    appHeight120 = _computeHeight(this._figmaHeight120);
    appHeight130 = _computeHeight(this._figmaHeight130);
    appHeight140 = _computeHeight(this._figmaHeight140);
    appHeight150 = _computeHeight(this._figmaHeight150);
    appHeight160 = _computeHeight(this._figmaHeight160);
    appHeight170 = _computeHeight(this._figmaHeight170);
    appHeight180 = _computeHeight(this._figmaHeight180);
    appHeight190 = _computeHeight(this._figmaHeight190);
    appHeight200 = _computeHeight(this._figmaHeight200);
    appHeight210 = _computeHeight(this._figmaHeight210);
    appHeight220 = _computeHeight(this._figmaHeight220);
    appHeight230 = _computeHeight(this._figmaHeight230);
    appHeight240 = _computeHeight(this._figmaHeight240);
    appHeight250 = _computeHeight(this._figmaHeight250);
    appHeight260 = _computeHeight(this._figmaHeight260);
    appHeight270 = _computeHeight(this._figmaHeight270);
    appHeight280 = _computeHeight(this._figmaHeight280);
    appHeight290 = _computeHeight(this._figmaHeight290);
    appHeight300 = _computeHeight(this._figmaHeight300);
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
    appIconSize5 = _computeWidth(this._figmaIconSize5);
    appIconSize10 = _computeWidth(this._figmaIconSize10);
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
    appEventBadgeSize = _computeWidth(this._figmaEventBadgeSize);
    appPhotoThumbnailSize = _computeWidth(this._figmaPhotoThumbnailSize);

    // Find size of avatars
    appAvatarSize80 = _computeWidth(this._figmaAvatarSize80);
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
  // Official/Main/Common color of app
  Color appBackground = Color(0xFFF1FFD6);
  Color appBarBackground = Color(0xFFC6FF59);
  Color green = Color(0xFFC6FF59);
  Color blurGreen = Color.fromRGBO(198, 255, 89, 0.75);
  Color lightGreen = Color(0xFFF1FFD6);
  Color gray808080 = Color(0xFF808080);
  Color grayABABAB = Color(0xFFABABAB);
  Color gray515151 = Color(0xFF515151);
  Color oldYellow = Color(0xFFF9C86A);
  Color strongOrange = Color(0xFFFD632C);
  Color blurOrange = Color.fromRGBO(253, 99, 44, 0.5);
  Color lightOrange = Color(0xFFFFC300);
  Color strongBlue = Color(0xFF173F5F);
  Color lightBlue = Color.fromRGBO(23, 63, 95, 0.25);
  Color pink = Color(0xFFFFA09E);
  Color btnShadow = Color.fromRGBO(0, 0, 0, 0.5);

//  Color contentText = Color(0xFF000000);
//  Color orangeNoteText = Color(0xFFFD632C);
//  Color normalNoteText = Color(0xFF808080);
//  Color lighterNormalNoteText = Color(0xFFABABAB);
//  Color boxBackground = Color(0xFFFFFFFF);
//  Color sectionBackgroundLayer = Color.fromRGBO(255, 235, 222, 0.2);
//  Color textShadow = Color.fromRGBO(0, 0, 0, 0.25);
//  Color tabLayer = Color.fromRGBO(253, 99, 44, 0.1);
//  Color discussionLayer = Color.fromRGBO(253, 99, 44, 0.2);
//  Color notiLayer = Color.fromRGBO(253, 99, 44, 0.2);
}

class _MyIcons {
  final String appbarFeed = 'assets/icons/home.png';
  final String appbarLesson = 'assets/icons/lesson.png';
  final String appbarChallenge = 'assets/icons/challenge.png';
  final String appbarGame = 'assets/icons/game.png';
  final String appbarProfile = 'assets/icons/profile.png';
  final String appbarSearch = 'assets/icons/search.png';
  final String calendar = "assets/icons/calendar.png";
  final String coin = "assets/icons/coin.png";
  final String appbarCloseWhiteBold = 'assets/icons/close_whitebold.png';
  final String appbarCheckWhiteBold = 'assets/icons/check_whitebold.png';
  final String avatar = "assets/icons/icon_avatar.png";
  final String add_friend = "assets/icons/add_friend.png";
}

class _Images {
  final String logo = 'assets/logo/logo.png';
  final String logoSquare = 'assets/logo/logo_square.png';
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
  final String default_image = "assets/images/default_image.png";
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
  String follow;
  String unFollow;

  String exitApp;
  String yes;
  String no;

  String content;
  String lessonWarn;
  String receiveCoins;
  String receiveCoinsSuccessfully;
}
