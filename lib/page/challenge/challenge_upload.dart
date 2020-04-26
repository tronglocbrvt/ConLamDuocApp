import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/util/image_cache_manager.dart';
import 'package:conlamduoc/widget/avatar_view.dart';
import 'package:conlamduoc/widget/custom_cell.dart';
import 'package:conlamduoc/widget/custom_dialog.dart/custom_alert_dialog.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ChallengeUpload extends StatefulWidget {

  final int challengeId;
  final int challengeCoins;
  final String challengeName;

  final int userId;
  final String avatarUrl;
  final String fullName;
  final String content;

  // imageUrl will be used first if both are not null
  final String imageUrl;
  final String videoUrl;

  ChallengeUpload({
    @required this.challengeId,
    @required this.challengeCoins,
    this.challengeName = "",
    @required this.userId,
    this.avatarUrl = "",
    this.fullName = "",
    this.content = "",
    this.imageUrl = "",
    this.videoUrl = "",
  });

  @override
  _ChallengeUploadState createState() => _ChallengeUploadState();
}

class _ChallengeUploadState extends State<ChallengeUpload> {
  static VideoPlayerController videoPlayerController;
  static ChewieController chewieController;
  bool _isLiked;

  File image;
  File video;

  bool isTakeImg;
  @override
  void initState() {
    super.initState();
    isTakeImg = _getChallengeType();
    print("istake "+isTakeImg.toString());
  }


  Widget _buildContent() {
    if (image != null) {
      return Container(
        constraints: BoxConstraints(maxHeight: 350),
        decoration: BoxDecoration(
          border: Border.all(
            color: R.colors.oldYellow,
            width: 2,
          ),
        ),
        child: Image.file(image),
      );
    }

    if (video != null) {
      videoPlayerController = VideoPlayerController.file(video);
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 9,
        allowFullScreen: true,
        autoInitialize: true,
        allowMuting: true,
        autoPlay: false,
        looping: false,
        placeholder: Container(
          color: R.colors.grayABABAB,
        ),
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
      );

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: R.colors.oldYellow,
            width: 2,
          ),
        ),
        child: Chewie(
          controller: chewieController,
        ),
      );
    }

    return Container();
  }


  @override
  void dispose() {
    if (widget.videoUrl.length != 0) {
      videoPlayerController.dispose();
      chewieController.dispose();
    }
    super.dispose();
  }

  bool _getChallengeType(){
    bool re = false;
    RawDataManager.challengeList.forEach((chal){
      print(widget.challengeId.toString());
      if (chal.id == widget.challengeId)
        re = chal.isTakeImg;
    });
    return re;
  }

  Widget build(BuildContext context) {
    Widget _buildWidget = Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: R.colors.appBarBackground,
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
      body: Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 15,
        left: 15,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: Offset(1.0, 1.0),
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCell(
          avatarView: AvatarView(
            avatarImageURL: widget.avatarUrl!=null?widget.avatarUrl:R.myIcons.avatar,
            avatarImageSize: 60,
            avatarBoxBorder: Border.all(
              width: 2,
              color: R.colors.oldYellow,
            ),
            pressAvatarImage: () {
              // TODO: Code here
              print("[MAIN FEED] Pressing avatar image");
            },
          ),
          title: widget.fullName,
          subTitle: widget.challengeName,
          subTitleStyle: TextStyle(
            color: R.colors.strongOrange,
            fontSize: 14,
          ),
          enableAddedContent: false,
          enableFFButton: true,
          pressFFButton: (){
            if (isTakeImg){
              openCamera(context);
            }
            else
              openCameraRecord(context);
            },
          pressFFButton2: (){
            if (isTakeImg){
                openSelectPhoto(context);
              }
              else
                openSelectVideo(context);
            }
          
        ),

        
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              maxLines: 2,
            //controller: _passwordController,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(20),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white),
          ),
        ),
        image!=null || video!= null? 
        SizedBox(
          height: 25,
        ):Container(),
        _buildContent(),
        SizedBox(
          height: 25,
        ),
        Padding( 
          padding: EdgeInsets.only(left: 100, right: 100),
          child: FlatButton(
          onPressed: () async {
            await showCustomAlertDialog(
                    context,
                    title: R.strings.notice,
                    content: "Video của bạn se được kiểm định và upload",
                    firstButtonText: R.strings.ok,
                    firstButtonFunction: () => pop(context),
                  );
          },
          color: Color(0xFFFFC300),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          child: Container( 
            child: Text("Xác nhận", style: TextStyle(fontSize: 20),),
            padding: EdgeInsets.only(top:10,bottom:10),
          ),
        ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ))
    );

    return NotificationListener<OverscrollIndicatorNotification>(
        child: _buildWidget,
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        });
  }

  Future<void> openSelectPhoto(BuildContext context) async{
    try {
      var newFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 500, maxHeight: 500);
      print(newFile.toString());
      if(newFile!=null)
      {
        setState(() {
          image = newFile;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> openCamera(BuildContext context) async{
    try {
      var newFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 500, maxHeight: 500);
      print(newFile.toString());
      if(newFile!=null)
      {
        setState(() {
          image = newFile;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> openSelectVideo(BuildContext context) async{
    try {
      var newFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
      print(newFile.toString());
      if(newFile!=null)
      {
        setState(() {
          video = newFile;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> openCameraRecord(BuildContext context) async{
    try {
      var newFile = await ImagePicker.pickVideo(source: ImageSource.camera);
      print(newFile.toString());
      if(newFile!=null)
      {
        setState(() {
          video = newFile;
        });
      }
    } catch (error) {
      print(error);
    }
  }
  
}
