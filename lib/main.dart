import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/page/app/app_page.dart';
import 'package:conlamduoc/page/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

import 'main.reflectable.dart';
import 'package:flutter/services.dart';
import 'core/R.dart';


void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ConLamDuocApp());
}

GlobalKey<_ConLamDuocAppState> _appGlobalkey = GlobalKey();
bool _needInit = true;

class ConLamDuocApp extends StatefulWidget {
  final Widget child;
  ConLamDuocApp({this.child}) : super(key: _appGlobalkey);
  @override
  _ConLamDuocAppState createState() => _ConLamDuocAppState();
}

class _ConLamDuocAppState extends State<ConLamDuocApp> {
  Key key = new UniqueKey();

  void restart() {
    setState(() {
      key = new UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Con làm được',
      key: key,
      theme: ThemeData(
        primaryColor: Color(0xFFFD632C),
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    _initApp();
    return Scaffold(
      body: Center(
        child: Image.asset(
          R.images.logo,
          width: 200,
        ),
      ),
    );
  }

  Future<void> _initApp() {
    return Future.delayed(
            Duration(milliseconds: 2000), () => initialize(context))
        .then((_) => showPage(context, WelcomePage()));
  }
}
