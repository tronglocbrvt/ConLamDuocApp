import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/model/lesson.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/widget/loading_dot.dart';
import 'package:conlamduoc/widget/main_lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool _isLoading;
  List<Lesson> lessonList;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    lessonList = List();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getLessonList());
  }

  void _getLessonList() {
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

  @override
  Widget build(BuildContext context) {
    Widget _buildWidget = Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: R.colors.navigationBar,
        leading: Image.asset(
          R.images.logo,
          width: R.appRatio.appWidth70,
        ),
        middle: Image.asset(
          R.images.title_lesson,
          height: R.appRatio.appSpacing50,
        ),
        trailing: GestureDetector(
          onTap: () => pushPage(context, ProfilePage()),
          child: Image.asset(
            R.myIcons.appbarProfile,
            height: R.appRatio.appSpacing30,
          ),
        ),
      ),
      backgroundColor: R.colors.appBackground,
      body: (_isLoading
          ? LoadingDotStyle02()
          : ListView.builder(
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
                String videoUrl = element.videoUrl;

                return Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: (index == lessonList.length - 1 ? 15 : 0),
                    left: 15,
                    right: 15,
                  ),
                  child: MainLesson(
                    id: id,
                    content: content,
                    thumbnailImageUrl: thumbnailImageUrl,
                    title: title,
                    coins: coins,
                    lessonField: lessonField,
                    videoUrl: videoUrl,
                  ),
                );
              },
            )),
    );

    return NotificationListener<OverscrollIndicatorNotification>(
        child: _buildWidget,
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        });
  }
}
