import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';

//  final TextEditingController _searchController = TextEditingController();
//  @override
//  Widget build(BuildContext context){
//    List<Widget> listFriends = [
//          SizedBox(height: 20,),
//          Container(
//            width: R.appRatio.deviceWidth,
//            child: Text("Bạn bè", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//          ),
//          SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: RawDataManager.userList[0].name,
//            description: Text("10 tuổi"),
//            imageTrailing: R.myIcons.appbarChallenge,),
//           SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: RawDataManager.userList[1].name,
//            description: Text("9 tuổi"),
//            imageTrailing: R.myIcons.appbarChallenge,),
//          SizedBox(height: 10,),
//          Container(
//            alignment: Alignment.centerRight,
//            width: R.appRatio.deviceWidth,
//            child: GestureDetector(
//              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
//            ),
//          ),];
//
//    List<Widget> listChallenge = [
//          SizedBox(height: 20,),
//          Container(
//            width: R.appRatio.deviceWidth,
//            child: Text("Thử thách", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//          ),
//          SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: "Rửa tay 6 bước",
//            description: Text("10 xu"),
//            imageTrailing: R.myIcons.appbarChallenge,),
//           SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: "Vẽ tranh gia đình",
//            description: Text("10 xu"),
//            imageTrailing: R.myIcons.appbarChallenge,),
//          SizedBox(height: 10,),
//          Container(
//            alignment: Alignment.centerRight,
//            width: R.appRatio.deviceWidth,
//            child: GestureDetector(
//              onTap: ()=>pushPage(context, ChallengePage()),
//              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
//            ),
//          ),];
//
//
//    List<Widget> listLesson = [
//          SizedBox(height: 20,),
//          Container(
//            width: R.appRatio.deviceWidth,
//            child: Text("Bài học", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//          ),
//          SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: "Cá voi có tuổi thọ bao lâu",
//            titleSize: 14,
//            description: Text("10 xu")),
//           SearchItemCell(
//            imageLeading: R.myIcons.appbarGame,
//            title: "Khả năng không tưởng của một chiếc bút chì",
//            titleSize: 14,
//            description: Text("10 xu"),),
//          SizedBox(height: 10,),
//          Container(
//            alignment: Alignment.centerRight,
//            width: R.appRatio.deviceWidth,
//            child: GestureDetector(
//              onTap: ()=>pushPage(context, LessonPage()),
//              child: Text("Xem tất cả", style: TextStyle(color: Colors.lightBlue),),
//            ),
//          ),];
//
//  List<Widget> list = [];
//
//    list.addAll(listFriends);
//    list.addAll(listChallenge);
//    list.addAll(listLesson);
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
//      appBar: CupertinoNavigationBar(
//        backgroundColor: R.colors.navigationBar,
//        leading: Image.asset(R.images.logo, width: R.appRatio.appWidth70,),
//        middle: Container(
//          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
//          child: TextField(
//            controller: _searchController,
//            decoration: new InputDecoration(
//            contentPadding: EdgeInsets.only(left: R.appRatio.appSpacing25),
//            border: new OutlineInputBorder(
//              borderRadius: const BorderRadius.all(
//                const Radius.circular(50.0),
//              ),
//            ),
//            filled: true,
//            hintText: "Bạn cần tìm gì ...",
//            hintStyle: new TextStyle(fontSize: 13, color: Colors.grey[800]),
//            fillColor: Colors.white),
//          ),
//        ),
//        trailing: GestureDetector(
//          onTap: ()=>{},
//          child: Image.asset(R.myIcons.appbarSearch, height: R.appRatio.appSpacing30,),
//        ),
//      ),
//      backgroundColor: R.colors.appBackground,
//      body: SafeArea(
//        child: Padding(
//          padding: EdgeInsets.only(left:20, right: 20),
//          child: SingleChildScrollView(
//            child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: list,
//        ),
//          )
//      ),
//    ));
//  }


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static TextEditingController _textSearchController;
  static FocusNode _searchFocusNode;
  final double _preferredHeightSize = 110.0;

  @override
  void initState() {
    super.initState();
    _textSearchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _requireSearchBoxFocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onChangedSearchBox(data) {
    // TODO: Implement here
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

  void _clearSearchBoxFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget _buildAppBarSearchBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 75, 20, 0),
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
                  hintText: R.strings.hintFriendName,
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

  Widget _buildAppBarLeading() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        child: Image.asset(
          R.images.logo,
          width: R.appRatio.appWidth70,
        ),
      ),
      onTap: () {
        _clearSearchBoxFocus();
        Future.delayed(Duration(milliseconds: 300), () {
          pop(context);
        });
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        R.strings.search,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: R.colors.strongBlue,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(_preferredHeightSize), // here the desired height
        child: AppBar(
          backgroundColor: R.colors.greenColor,
          leading: _buildAppBarLeading(),
          titleSpacing: 0.0,
          title: _buildAppBarTitle(),
          flexibleSpace: _buildAppBarSearchBox(),
        ),
      ),
      body: Center(
        child: Text("Tìm kiếm"),
      ),
    );
  }
