import 'package:chewie/chewie.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/util/image_cache_manager.dart';
import 'package:conlamduoc/widget/avatar_view.dart';
import 'package:conlamduoc/widget/custom_cell.dart';
import 'package:conlamduoc/widget/ui_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class MainFeed extends StatefulWidget {
  final int id;

  final int challengeId;
  final int challengeCoins;
  final String challengeName;

  final int userId;
  final String avatarUrl;
  final String fullName;
  final String content;

  final bool isLiked;
  final DateTime createdAt;

  // imageUrl will be used first if both are not null
  final String imageUrl;
  final String videoUrl;

  MainFeed({
    @required this.id,
    @required this.challengeId,
    @required this.challengeCoins,
    this.challengeName = "",
    @required this.userId,
    this.avatarUrl = "",
    this.fullName = "",
    this.content = "",
    this.imageUrl = "",
    this.videoUrl = "",
    this.isLiked = false,
    this.createdAt,
  }) : assert(id != null &&
            challengeId != null &&
            challengeCoins != null &&
            challengeName != null &&
            userId != null &&
            avatarUrl != null &&
            fullName != null &&
            content != null &&
            imageUrl != null &&
            videoUrl != null &&
            isLiked != null);

  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  static VideoPlayerController videoPlayerController;
  static ChewieController chewieController;
  bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
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

  String _processChallengeName() {
    String key = R.strings.challenge.toLowerCase();
    String firstChar = key[0];
    key = key.substring(1);
    key = firstChar.toUpperCase() + key + ": ${widget.challengeName}";
    return key;
  }

  @override
  void dispose() {
    if (widget.videoUrl.length != 0) {
      videoPlayerController.dispose();
      chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          subTitle: _processChallengeName(),
          subTitleStyle: TextStyle(
            color: R.colors.strongOrange,
            fontSize: 14,
          ),
          pressInfo: () {
            // TODO: Code here
            print("[MAIN FEED] Pressing info");
          },
          firstAddedTitleIconURL: R.myIcons.calendar,
          firstAddedTitle:
              DateFormat("dd/MM/yyyy HH:mm").format(widget.createdAt),
          firstAddedTitleIconSize: 12,
          secondAddedTitleIconURL: R.myIcons.coin,
          secondAddedTitle: widget.challengeCoins.toString(),
          secondAddedTitleIconSize: 12,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            widget.content,
            textScaleFactor: 1.0,
            maxLines: 8,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildUrlContent(),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UIImageButton(
              image: Image.asset(
                (_isLiked
                    ? R.images.button_like_color
                    : R.images.button_like_nocolor),
                fit: BoxFit.contain,
              ),
              width: 130,
              height: 40,
              onTap: () => _updateIsLiked(),
            ),
            UIImageButton(
              image: Image.asset(
                R.images.button_challenge,
                fit: BoxFit.contain,
              ),
              width: 130,
              height: 40,
              onTap: () {
                // TODO: Code here
                print("[MAIN FEED] Pushing page 'challenge in detail'");
              },
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
