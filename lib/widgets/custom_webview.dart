import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String selectedUrl;
  final PreferredSizeWidget appBar;
  final bool hasLoadingIndicator;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  CustomWebView({
    Key key,
    @required this.selectedUrl,
    this.appBar,
    this.hasLoadingIndicator = false,
  })  : assert(selectedUrl != null && hasLoadingIndicator != null),
        assert(selectedUrl.length != 0),
        super(key: key);

  @override
  CustomWebViewState createState() => CustomWebViewState();
}

class CustomWebViewState extends State<CustomWebView> {
  /*
    + CAN BE USED:
    final CookieManager cookieManager = CookieManager();
  */

  /*
    + CAN BE USED
    void _getAllCookies(
      WebViewController controller, BuildContext context) async {
      final String cookies =
          await controller.evaluateJavascript('document.cookie');
      List<String> cookieList = cookies.split(';');
      for (int i = 0; i < cookieList.length; ++i) {
        print("Cookie $i: ${cookieList[i]}");
      }
    }
  */

  bool _isLoading;
  double _loadingValue;
  WebViewController _wvController;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _loadingValue = 0.0;
  }

  void _updateLoading(bool status) {
    if (!widget.hasLoadingIndicator) return;
    if (_isLoading == status) return;
    if (!mounted) return;
    if (status) {
      setState(() {
        _isLoading = status;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _loadingValue = 0.25;
        });
      });
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _loadingValue = 0.45;
        });
      });
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _loadingValue = 0.65;
        });
      });
    } else {
      setState(() {
        _loadingValue = 1.0;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _isLoading = status;
          _loadingValue = 0.0;
        });
      });
    }
  }

  void reloadWebView() {
    _wvController.reload();
  }

  Future<bool> canGoBack() async {
    return await _wvController.canGoBack();
  }

  void goBack() {
    _wvController.goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          WebView(
            initialUrl: widget.selectedUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              widget._controller.complete(webViewController);
              _wvController = webViewController;
            },
            onPageStarted: (url) {
              _updateLoading(true);
            },
            onPageFinished: (value) {
              _updateLoading(false);
            },
          ),
          (_isLoading
              ? LinearProgressIndicator(
                  backgroundColor: Color.fromRGBO(52, 182, 122, 0.25),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF34b67a)),
                  value: _loadingValue,
                )
              : Container()),
        ],
      ),
    );
  }
}
