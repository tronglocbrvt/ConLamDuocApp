import 'package:flutter/material.dart';
import 'package:conlamduoc/core/R.dart';

class UIButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final GestureTapCallback onTap;
  final Gradient gradient;
  final Color color;
  final String text;
  final Color textColor;
  final double textSize;
  final bool enable;
  final Border border;
  final FontWeight fontWeight;
  final bool enableShadow;
  final BoxShadow boxShadow;

  UIButton({
    this.width = double.maxFinite,
    this.height = 55,
    this.radius = 5,
    this.onTap,
    this.gradient,
    this.color,
    this.text,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.enable = true,
    this.border,
    this.fontWeight = FontWeight.w500,
    this.enableShadow = true,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    Gradient gr;
    Color cl;
    if (this.enable) {
      gr = this.gradient;
      cl = this.color;
    } else {
      gr = null;
      cl = Color(0xff515151);
    }

    return GestureDetector(
      child: Container(
        width: this.width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(this.radius)),
          border: this.border,
          gradient: gr,
          color: cl,
          boxShadow: (this.enableShadow
              ? [
                  (this.boxShadow == null
                      ? BoxShadow(
                          blurRadius: 4.0,
                          offset: Offset(1.0, 1.0),
                          color: R.colors.btnShadow,
                        )
                      : this.boxShadow),
                ]
              : null),
        ),
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: this.textSize,
                color: this.textColor,
                fontWeight: this.fontWeight)),
      ),
      onTap: (this.enable && this.onTap != null) ? this.onTap : null,
    );
  }
}

class UIImageButton extends StatelessWidget {
  final Image image;
  final double width;
  final double height;
  final GestureTapCallback onTap;

  UIImageButton({
    this.image,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: this.width,
        height: this.height,
        child: this.image,
      ),
    );
  }
}
