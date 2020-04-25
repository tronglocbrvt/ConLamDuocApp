import 'package:conlamduoc/core/R.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class LoadingDotStyle01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Color.fromRGBO(52, 182, 122, 1.0),
        ),
      ),
    );
  }
}

class LoadingDotStyle02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NutsActivityIndicator(
        activeColor: Color.fromRGBO(127, 255, 0, 1.0),
        inactiveColor: Color.fromRGBO(127, 255, 0, 0.6),
        tickCount: 12,
        relativeWidth: 0.8,
        radius: 15,
      ),
    );
  }
}
