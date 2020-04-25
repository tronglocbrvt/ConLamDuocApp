import 'dart:io';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/challenge/challenge_page.dart';
import 'package:conlamduoc/page/feed/feed_page.dart';
import 'package:conlamduoc/page/game/game_page.dart';
import 'package:conlamduoc/page/lesson/lesson_page.dart';
import 'package:conlamduoc/page/search/search_page.dart';
import 'package:conlamduoc/widget/custom_dialog.dart/custom_exit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  CupertinoTabController _tabController;
  int _selectedPage;

  final List<Widget> _pages = [
    FeedPage(),
    LessonPage(),
    ChallengePage(),
    GamePage(),
    SearchPage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () => _initUserData());
    _selectedPage = 0;
    _tabController = CupertinoTabController(initialIndex: _selectedPage);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initUserData() async {
    // TODO: Code here
  }

  void _onTabChanged(int index) {
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  final List<BottomNavigationBarItem> _tabItems = [
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarFeed, width: 18, height: 18),
      activeIcon: Image.asset(R.myIcons.appbarFeed, width: 26, height: 26),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarLesson, width: 18, height: 18),
      activeIcon: Image.asset(R.myIcons.appbarLesson, width: 28, height: 28),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarChallenge, width: 20, height: 20),
      activeIcon: Image.asset(R.myIcons.appbarChallenge, width: 30, height: 30),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarGame, width: 18, height: 18),
      activeIcon: Image.asset(R.myIcons.appbarGame, width: 26, height: 26),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(R.myIcons.appbarSearch, width: 18, height: 18),
      activeIcon: Image.asset(R.myIcons.appbarSearch, width: 26, height: 26),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        bool isExit = await showCustomExitDialog<bool>(context);
        if (isExit) {
          exit(0);
          return Future.value(true);
        }
        return Future.value(false);
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: CupertinoTabScaffold(
          controller: _tabController,
          tabBar: CupertinoTabBar(
            items: _tabItems,
            onTap: (pos) => _onTabChanged(pos),
            backgroundColor: Colors.white,
          ),
          tabBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
        ),
      ),
    );
  }
}
