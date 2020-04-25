import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/model/challenge.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/widget/loading_dot.dart';
import 'package:conlamduoc/widget/main_challenge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  bool _isLoading;
  List<Challenge> challengeList;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    challengeList = List();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getNotificationList());
  }

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

    challengeList.addAll(RawDataManager.challengeList);
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
          R.images.title_challenge,
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
          : Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: challengeList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  Challenge element = challengeList[index];
                  String name = element.nameChallenge;
                  String description = element.describe;
                  String thumbnailImageUrl  = element.thumbnailImageUrl!=null? element.thumbnailImageUrl: R.myIcons.appbarChallenge;
                  int coin = element.coins;
                  return Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: (index == challengeList.length - 1
                          ? 15
                          : 0),
                    ),
                    child: MainChallenge(
                        id: element.id,
                        coins: coin,
                        content: description,
                        title: name,
                        thumbnailImageUrl: thumbnailImageUrl,
                        img: element.img,
                        ));
                        },
              ),
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
