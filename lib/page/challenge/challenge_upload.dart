import 'package:chewie/chewie.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/profile/profile_page.dart';
import 'package:conlamduoc/util/image_cache_manager.dart';
import 'package:conlamduoc/widget/avatar_view.dart';
import 'package:conlamduoc/widget/custom_cell.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
  }

  void _updateIsLiked() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  Widget _buildUrlContent() {
    if (widget.imageUrl.length != 0) {
      return Container(
        constraints: BoxConstraints(maxHeight: 350),
        decoration: BoxDecoration(
          border: Border.all(
            color: R.colors.oldYellow,
            width: 2,
          ),
        ),
        child: ImageCacheManager.getImage(
          url: widget.imageUrl,
          fit: BoxFit.cover,
        ),
      );
    }

    if (widget.videoUrl.length != 0) {
      videoPlayerController = VideoPlayerController.network(widget.videoUrl);
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

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       CustomCell(
  //         avatarView: AvatarView(
  //           avatarImageURL: widget.avatarUrl,
  //           avatarImageSize: 60,
  //           avatarBoxBorder: Border.all(
  //             width: 2,
  //             color: R.colors.oldYellow,
  //           ),
  //           pressAvatarImage: () {
  //             // TODO: Code here
  //             print("[MAIN FEED] Pressing avatar image");
  //           },
  //         ),
  //         title: widget.fullName,
  //         subTitle: _processChallengeName(),
  //         subTitleStyle: TextStyle(
  //           color: R.colors.strongOrange,
  //           fontSize: 14,
  //         ),
  //         pressInfo: () {
  //           // TODO: Code here
  //           print("[MAIN FEED] Pressing info");
  //         },
  //         // firstAddedTitleIconURL: R.myIcons.calendar,
  //         // firstAddedTitle:
  //         //     DateFormat("dd/MM/yyyy HH:mm").format(widget.createdAt),
  //         // firstAddedTitleIconSize: 12,
  //         // secondAddedTitleIconURL: R.myIcons.coin,
  //         // secondAddedTitle: widget.challengeCoins.toString(),
  //         // secondAddedTitleIconSize: 12,
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(left: 5, right: 5),
  //         child: Text(
  //           widget.content,
  //           textScaleFactor: 1.0,
  //           maxLines: 8,
  //           textAlign: TextAlign.left,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       _buildUrlContent(),
  //       SizedBox(
  //         height: 25,
  //       ),
  //       // Row(
  //       //   mainAxisAlignment: MainAxisAlignment.center,
  //       //   children: [
  //       //     UIImageButton(
  //       //       image: Image.asset(
  //       //         (_isLiked
  //       //             ? R.images.button_like_color
  //       //             : R.images.button_like_nocolor),
  //       //         fit: BoxFit.contain,
  //       //       ),
  //       //       width: 130,
  //       //       height: 40,
  //       //       onTap: () => _updateIsLiked(),
  //       //     ),
  //       //     UIImageButton(
  //       //       image: Image.asset(
  //       //         R.images.button_challenge,
  //       //         fit: BoxFit.contain,
  //       //       ),
  //       //       width: 130,
  //       //       height: 40,
  //       //       onTap: () {
  //       //         // TODO: Code here
  //       //         print("[MAIN FEED] Pushing page 'challenge in detail'");
  //       //       },
  //       //     )
  //       //   ],
  //       // ),
  //       // SizedBox(
  //       //   height: 10,
  //       // ),
  //     ],
  //   );
  //}

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
            avatarImageURL: widget.avatarUrl,
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

        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              maxLines: 3,
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
        //_buildUrlContent(),
        SizedBox(
          height: 25,
        ),
        FlatButton(
          onPressed: (){},
          color: Color(0xFFFFC300),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          child: Container( 
            child: Text("Xác nhận", style: TextStyle(fontSize: 20),),
            padding: EdgeInsets.only(top:10,bottom:10),
          ),
        )
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
}
