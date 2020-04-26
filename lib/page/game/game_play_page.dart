import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/widget/custom_dialog.dart/custom_alert_dialog.dart';
import 'package:conlamduoc/widget/loading_dot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

class GamePlay extends StatefulWidget {
  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  bool _isLoading;
  bool correct;
  bool hasAnswer;

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
        hasAnswer = false;
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
          : correct!=null && correct == true?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(R.images.layout_game4),
              ),
            ),)
          :Center(
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
                  Align( 
                    alignment: Alignment.center,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      correct!=null? correct? 
                      
                      Image.asset(R.images.game_correct, width: 200,): 
                      Image.asset(R.images.game_inCorect, width: 200):Container(),
                      SizedBox(height: 40,),
                      _buildQuestion(0),
                      SizedBox(height: 80,),
                      _buildOption(0,0),
                      SizedBox(height: 10,),
                      _buildOption(0,1),
                      SizedBox(height: 10,),
                      _buildOption(0,2),
                      SizedBox(height: 10,),
                      _buildOption(0,3),
                    ],),
                  )
                  
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


  _buildQuestion(int id){
    return Container( 
      padding: EdgeInsets.all(20),
      width: R.appRatio.deviceWidth - 40,
      height: 80,
        constraints: BoxConstraints(maxHeight: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: R.colors.green, //                   <--- border color
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(1.0, 1.0),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child:Align( 
          alignment: Alignment.center,
          child:  Text(RawDataManager.quizList[id].question),
        ),
    );
  }

  

  _buildOption(int id, int optionID){
    return GestureDetector( 
      child: Container( 
        padding: EdgeInsets.all(20),
        height: 60,
        width: R.appRatio.deviceWidth - 40,
          constraints: BoxConstraints(maxHeight: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: R.colors.green, //                   <--- border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2.0,
                offset: Offset(1.0, 1.0),
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
          child: Align( 
            alignment: Alignment.center,
              child: Text(RawDataManager.quizList[id].options[optionID]),
            ),
          ),
        onTap: (){_checkAnswer(id, optionID);}
    );
  }

  _checkAnswer(int quizID, int optionID)
  {
    if (correct!=null)
      return;
    bool isCorrect = false;
    print("Check");
    print("index: "+ RawDataManager.quizList[quizID].answer.toString());
    if (optionID == RawDataManager.quizList[quizID].answer.index)
    {
      isCorrect = true;
    }
    else{
      isCorrect = false;
    }

    setState(() {
      correct = isCorrect;
      hasAnswer = true;
    });
  }
}
