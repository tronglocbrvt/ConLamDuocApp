import 'package:flutter/material.dart';
import 'package:conlamduoc/util/image_cache_manager.dart';

class AvatarView extends StatelessWidget {
  final String avatarImageURL;
  final double avatarImageSize;
  final BoxShadow avatarBoxShadow;
  final BoxBorder avatarBoxBorder;
  final bool enableSquareAvatarImage;
  final double radiusSquareBorder;
  final Function pressAvatarImage;
  final String supportImageURL;

  AvatarView({
    @required this.avatarImageURL,
    @required this.avatarImageSize,
    this.avatarBoxShadow,
    this.avatarBoxBorder,
    this.enableSquareAvatarImage = false,
    this.radiusSquareBorder = 5,
    this.pressAvatarImage,
    this.supportImageURL,
  });

  @override
  Widget build(BuildContext context) {
    double _supportImageSize = this.avatarImageSize / 4;

    return Center(
      child: Container(
        width: this.avatarImageSize,
        height: this.avatarImageSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: (this.enableSquareAvatarImage
              ? BorderRadius.all(Radius.circular(this.radiusSquareBorder))
              : BorderRadius.all(Radius.circular(this.avatarImageSize / 2))),
          border: this.avatarBoxBorder,
          boxShadow: (this.avatarBoxShadow != null
              ? [
                  this.avatarBoxShadow,
                ]
              : null),
        ),
        child: GestureDetector(
          onTap: () {
            if (this.pressAvatarImage != null) {
              this.pressAvatarImage();
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: (this.enableSquareAvatarImage
                    ? BorderRadius.all(Radius.circular(this.radiusSquareBorder))
                    : BorderRadius.all(
                        Radius.circular(this.avatarImageSize / 2))),
                child: ImageCacheManager.getImage(
                  url: this.avatarImageURL,
                  height: this.avatarImageSize,
                  width: this.avatarImageSize,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: (this.supportImageURL == null ||
                        this.supportImageURL.length == 0
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(_supportImageSize / 2),
                        ),
                        child: ImageCacheManager.getImage(
                          url: this.supportImageURL,
                          height: _supportImageSize,
                          width: _supportImageSize,
                          fit: BoxFit.cover,
                        ),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
