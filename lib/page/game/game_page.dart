import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/page/game/game_play_page.dart';
import 'package:conlamduoc/widget/loading_dot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => _getGameList());
  }

  void _getGameList() {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildWidget = Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
        backgroundColor: R.colors.appBarBackground,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: Image.asset(R.images.logo),
        ),
        title: Text(
          R.strings.game.toUpperCase(),
          textScaleFactor: 1.0,
          style: TextStyle(
            color: R.colors.strongBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => pushPage(context, ProfilePage()),
              child: Image.asset(
                R.myIcons.appbarProfile,
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
      ),
      backgroundColor: R.colors.appBackground,
      body: (_isLoading
          ? LoadingDotStyle02()
          : Center(
              child: Stack(
                children: <Widget>[
                  Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(R.images.game_background),
                    ),
                  ),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(R.images.game_name),
                      GestureDetector( 
                        child: Image.asset(R.images.button_play, width: 100, height: 100,),
                        onTap: (){
                          pushPage(context, GamePlay());
                        },
                      )
                    ],),
                  
              ],) 
          
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
