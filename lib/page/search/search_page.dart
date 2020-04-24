import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/page/challenge/challenge_page.dart';
import 'package:conlamduoc/page/lesson/lesson_page.dart';
import 'package:conlamduoc/page/profile/profile_pae.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/widget/search_item_cell.dart';

class SearchPage extends StatelessWidget{

  final TextEditingController _searchController = TextEditingController();

  
      

  @override 
  Widget build(BuildContext context){
    List<Widget> listFriends = [
          SizedBox(height: 20,),
          Container( 
            width: R.appRatio.deviceWidth,
            child: Text("Bạn bè", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: RawDataManager.userList[0].name,
            description: Text("10 tuổi"),
            imageTrailing: R.myIcons.appbarChallenge,),
           SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: RawDataManager.userList[1].name,
            description: Text("9 tuổi"),
            imageTrailing: R.myIcons.appbarChallenge,),
          SizedBox(height: 10,),
          Container( 
            alignment: Alignment.centerRight,
            width: R.appRatio.deviceWidth,
            child: GestureDetector( 
              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
            ),
          ),];

    List<Widget> listChallenge = [
          SizedBox(height: 20,),
          Container( 
            width: R.appRatio.deviceWidth,
            child: Text("Thử thách", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: "Rửa tay 6 bước",
            description: Text("10 xu"),
            imageTrailing: R.myIcons.appbarChallenge,),
           SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: "Vẽ tranh gia đình",
            description: Text("10 xu"),
            imageTrailing: R.myIcons.appbarChallenge,),
          SizedBox(height: 10,),
          Container( 
            alignment: Alignment.centerRight,
            width: R.appRatio.deviceWidth,
            child: GestureDetector( 
              onTap: ()=>pushPage(context, ChallengePage()),
              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
            ),
          ),];


    List<Widget> listLesson = [
          SizedBox(height: 20,),
          Container( 
            width: R.appRatio.deviceWidth,
            child: Text("Bài học", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: "Cá voi có tuổi thọ bao lâu",
            titleSize: 14,
            description: Text("10 xu")),
           SearchItemCell(
            imageLeading: R.myIcons.appbarGame,
            title: "Khả năng không tưởng của một chiếc bút chì",
            titleSize: 14,
            description: Text("10 xu"),),
          SizedBox(height: 10,),
          Container( 
            alignment: Alignment.centerRight,
            width: R.appRatio.deviceWidth,
            child: GestureDetector( 
              onTap: ()=>pushPage(context, LessonPage()),
              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
            ),
          ),];

  List<Widget> list = [];
  
    list.addAll(listFriends);
    list.addAll(listChallenge);
    list.addAll(listLesson);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: CupertinoNavigationBar(
        backgroundColor: R.colors.navigationBar,
        leading: Image.asset(R.images.logo, width: R.appRatio.appWidth70,),
        middle: Container( 
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: TextField(
            controller: _searchController,
            decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(left: R.appRatio.appSpacing25),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
            ),
            filled: true,
            hintText: "Bạn cần tìm gì ...",
            hintStyle: new TextStyle(fontSize: 13, color: Colors.grey[800]),
            fillColor: Colors.white),
          ),
        ),
        trailing: GestureDetector( 
          onTap: ()=>{},
          child: Image.asset(R.myIcons.appbarSearch, height: R.appRatio.appSpacing30,),
        ),
      ),
      backgroundColor: R.colors.appBackground,
      body: SafeArea( 
        child: Padding( 
          padding: EdgeInsets.only(left:20, right: 20),
          child: SingleChildScrollView( 
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: list,
        ),
          )
      ),
    ));
  }
}