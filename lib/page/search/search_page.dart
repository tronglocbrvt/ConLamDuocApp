import 'dart:convert';

import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/model/lesson.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/widget/search_item_cell.dart';
import 'package:conlamduoc/widgets/main_lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static TextEditingController _textSearchController;
  static FocusNode _searchFocusNode;
  final double _preferredHeightSize = 110.0;
  final int _tabBarLength = 3;

  bool _isLoading;
  List<User> userList;
  List<Lesson> lessonList;

  void _getNotificationList() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = !_isLoading;
      });
    });

    lessonList.addAll(RawDataManager.lessonList);
  }
  
  _buildUserlist()
  {
    
  }

  _buildLessonList()
  {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 40
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: lessonList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          Lesson element = lessonList[index];
          int id = element.id;
          String title = element.nameLesson;
          String content = element.content;
          int coins = element.coins;
          String lessonField = element.lessonField;
          String thumbnailImageUrl = element.thumbnailImageUrl;
          String webUrl = element.webUrl;

          return Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: (index == lessonList.length - 1
                  ? 15
                  : 0),
            ),
            child: MainLesson(
              id: id,
              content: content,
              thumbnailImageUrl: thumbnailImageUrl,
              title: title,
              coins: coins,
              lessonField: lessonField,
              webUrl: webUrl,
            ),
          );
        },
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    _textSearchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _requireSearchBoxFocus();
     _isLoading = true;
    lessonList = List();
    userList = List();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getNotificationList());
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onChangedSearchBox(data) {
    
    print(tiengviet(data));
    this.lessonList.clear();
    if (data=="")
    {
      setState(() {
        this.lessonList.addAll(RawDataManager.lessonList);
      });
    }
    else{
    List<Lesson> temp = new List<Lesson>();
    RawDataManager.lessonList.forEach((lesson){
      if (tiengviet(lesson.nameLesson).toLowerCase().contains(tiengviet(data).toString().toLowerCase()))
        temp.add(lesson);
    });
    setState(() {
      this.lessonList.addAll(temp);
    });
    }
    
  }

  void _onSubmittedSearchBox(data) {
    if (data.length == 0) return;
    // TODO: Implement here
  }

  void _clearSearchBoxContent() {
    _textSearchController.clear();
  }

  void _requireSearchBoxFocus() {
    Future.delayed(Duration(milliseconds: 500), () {
      _searchFocusNode.requestFocus();
    });
  }

//  void _clearSearchBoxFocus() {
//    FocusScopeNode currentFocus = FocusScope.of(context);
//    if (!currentFocus.hasPrimaryFocus) {
//      currentFocus.unfocus();
//    }
//  }

  Widget _buildAppBarSearchBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
      width: R.appRatio.deviceWidth,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Input box
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _textSearchController,
                focusNode: _searchFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                onSubmitted: (data) => _onSubmittedSearchBox(data),
                onChanged: (data) => _onChangedSearchBox(data),
                cursorColor: R.colors.greenColor,
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: R.strings.searchHint,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ),
              ),
            ),
          ),
          // Clear text button
          GestureDetector(
            onTap: () => _clearSearchBoxContent(),
            child: Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: R.colors.greenColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(
                R.myIcons.appbarCloseWhiteBold,
                width: 8,
                height: 8,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildTabBarTitle() {
    return [
      // Tab: Friends
      Tab(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            R.strings.friend.toUpperCase(),
            style: TextStyle(
              color: R.colors.strongBlue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // Tab: Challenges
      Tab(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            R.strings.challenge.toUpperCase(),
            style: TextStyle(
              color: R.colors.strongBlue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // Tab: Lessons
      Tab(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            R.strings.lesson.toUpperCase(),
            style: TextStyle(
              color: R.colors.strongBlue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildWidget = MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: _tabBarLength,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_preferredHeightSize),
            // here the desired height
            child: AppBar(
              backgroundColor: R.colors.greenColor,
              flexibleSpace: _buildAppBarSearchBox(),
              bottom: TabBar(
                indicatorColor: R.colors.strongBlue,
                indicatorWeight: 3,
                tabs: _buildTabBarTitle(),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // TODO: Display listview of ALL routes and FAVORITE routes
              
              Center(
              child: 
              SearchItemCell(
                onTap: null,
                imageLeading: R.myIcons.appbarGame, 
                title: "AAAA",
                description: Text("AAA"),)),
              Center(child: Text("Listview of CHALLENGES")),
              Center(child: _buildLessonList()),
            ],
          ),
        ),
      ),
    );

    return NotificationListener<OverscrollIndicatorNotification>(
        child: _buildWidget,
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        });
  }
}
