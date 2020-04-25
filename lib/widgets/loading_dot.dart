import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:conlamduoc/core/R.dart';

class LoadingDotStyle01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.green,
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
        activeColor: Colors.green,
        inactiveColor: Colors.lightGreen,
        tickCount: 12,
        relativeWidth: 0.8,
        radius: 15,
      ),
    );
  }
}
