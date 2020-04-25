import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/model/feed.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/widget/loading_dot.dart';
import 'package:conlamduoc/widget/main_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  static final double radius = 10;
  bool _isLoading;
  List<Feed> feedList;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    feedList = List();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getFeedList());
  }

  void _getFeedList() {
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

    feedList.addAll(RawDataManager.feedList);
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
          R.images.title_home,
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
              itemCount: feedList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                Feed element = feedList[index];
                int id = element.id;
                int userId = element.userId;
                String videoUrl = element.videoUrl;
                String imageUrl = element.imageUrl;
                DateTime createdAt = element.createdAt;
                String content = element.content;
                String fullName = element.fullName;
                String avatarUrl = element.avatarUrl;
                String challengeName = element.challengeName;
                bool isLiked = element.isLiked;
                int challengeId = element.challengeId;
                int challengeCoins = element.challengeCoins;

                return Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: (index == feedList.length - 1 ? 15 : 0),
                    right: 15,
                    left: 15,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        offset: Offset(1.0, 1.0),
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: MainFeed(
                    id: id,
                    challengeId: challengeId,
                    challengeCoins: challengeCoins,
                    challengeName: challengeName,
                    avatarUrl: avatarUrl,
                    isLiked: isLiked,
                    content: content,
                    fullName: fullName,
                    createdAt: createdAt,
                    videoUrl: videoUrl,
                    imageUrl: imageUrl,
                    userId: userId,
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
