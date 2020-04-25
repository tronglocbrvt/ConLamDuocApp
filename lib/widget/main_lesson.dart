import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/lesson/lesson_detail.dart';
import 'package:flutter/material.dart';

class MainLesson extends StatelessWidget {
  final int id;
  final String thumbnailImageUrl;
  final String title;
  final String content;
  final int coins;
  final String lessonField;
  final String videoUrl;

  static final double radius = 10;

  const MainLesson({
    @required this.id,
    this.thumbnailImageUrl,
    this.title,
    this.content,
    this.coins,
    this.lessonField,
    this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushPage(
          context,
          LessonDetail(
            selectedUrl: this.videoUrl,
            title: this.title,
            coins: this.coins,
            content: this.content,
            lessonField: this.lessonField,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(maxHeight: 140),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(1.0, 1.0),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: R.colors.lightOrange,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(radius + 2)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                child: Image.asset(
                  this.thumbnailImageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      this.title.toUpperCase(),
                      textScaleFactor: 1.0,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // Coins & Lesson field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Xu: ${this.coins}",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: R.colors.gray808080,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Loại: ${this.lessonField}",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: R.colors.gray808080,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // Content
                  Text(
                    this.content,
                    textScaleFactor: 1.0,
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
