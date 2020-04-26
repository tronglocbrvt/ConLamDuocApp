import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:conlamduoc/core/helper.dart';

class ImageInputController {
  File _file;

  ImageInputController({
    File file,
  }) : _file = file;

  String base64Data() {
    if(_file == null)
      return null;
    int index = _file.path.lastIndexOf('.') + 1;
    String type = _file.path.substring(index);
    return _file != null ? type + ":" + base64Encode(_file.readAsBytesSync()) : null;
  }

  File file() {
    return _file;
  }
}

class ImageInputField extends StatefulWidget {
  final double width;
  final double height;
  final ImageInputController controller;
  final ImageProvider image;

  const ImageInputField({
    Key key,
    @required this.image,
    @required this.controller,
    this.width,
    this.height,
  }) : super(key: key);

  ImageInputField.asset(
    String name, {
    Key key,
    @required this.controller,
    this.width,
    this.height,
  })  : image = AssetImage(name),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageInputFieldState();
}

class _ImageInputFieldState extends State<ImageInputField> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.controller._file == null ? Container(color: CupertinoColors.lightBackgroundGray, width: widget.width, height: widget.height) : Image.file(widget.controller._file, width: widget.width, height: widget.height);

    if (widget.controller._file == null) {
      if (widget.image == null) {
        child = Container(color: CupertinoColors.darkBackgroundGray, width: widget.width, height: widget.height);
      } else {
        child = Image(image: widget.image, width: widget.width, height: widget.height);
      }
    } else {
      child = Image.file(widget.controller._file, width: widget.width, height: widget.height);
    }

    return GestureDetector(
      onTap: () async {
        File img = await pickImage(context);
        widget.controller._file = img;

        setState(() {});
      },
      child: child,
    );
  }
}
