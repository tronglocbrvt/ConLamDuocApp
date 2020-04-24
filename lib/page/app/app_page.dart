
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/page/challenge/challenge_page.dart';
import 'package:conlamduoc/page/feed/feed_page.dart';
import 'package:conlamduoc/page/game/game_page.dart';
import 'package:conlamduoc/page/lesson/lesson_page.dart';
import 'package:conlamduoc/page/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  CupertinoTabController _tabController;
  static FeedPage _feedPage = FeedPage();

  final List<BottomNavigationBarItem> _tabItems = [
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarFeed, width: 28, height: 28),
      activeIcon: Image.asset(R.myIcons.appbarFeed, width: 28, height: 28, color: R.colors.blurMajorOrange),
      //title: Text(R.strings.feed),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarLesson, width: 28, height: 28),
      activeIcon: Image.asset(R.myIcons.appbarLesson, width: 28, height: 28, color: R.colors.blurMajorOrange),
      //title: Text(R.strings.lesson),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarChallenge, width: 28, height: 28),
      activeIcon: Image.asset(R.myIcons.appbarChallenge, width: 28, height: 28, color: R.colors.blurMajorOrange),
      //title: Text(R.strings.challenge),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarGame, width: 28, height: 28),
      activeIcon: Image.asset(R.myIcons.appbarGame, width: 28, height: 28, color: R.colors.blurMajorOrange),
      //title: Text(R.strings.game),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarSearch, width: 28, height: 28),
      activeIcon: Image.asset(R.myIcons.appbarSearch, width: 28, height: 28, color: R.colors.blurMajorOrange),
      //title: Text(R.strings.profile),
    )
  ];

  final List<Widget> _pages = [
    _feedPage,
    LessonPage(), 
    ChallengePage(),
    GamePage(),
    SearchPage(),
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () => _initUserData());

    _tabController = CupertinoTabController();
  }

  @override
  Widget build(BuildContext context) {
    print("- AppPage build");

    return new WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: R.colors.blurMajorOrange,
            inactiveColor: Colors.black,
            items: _tabItems,
          ),
          tabBuilder: (BuildContext context, int index) {
            Widget page = _pages[index];
            return page;
          },
          controller: _tabController,
        ),
      ),
    );
  }

  void _initUserData() async {
   
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
