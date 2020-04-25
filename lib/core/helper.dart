

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/main.dart';
import 'package:conlamduoc/core/define.dart';
import 'package:conlamduoc/manager/raw_data_manager.dart';

// === MAIN === //
Future<void> initialize(BuildContext context) async {
  await setLanguage("en");
  R.initAppRatio(context);
  RawDataManager.initRawData();
}

enum RouteType {
  push,
  present,
  show,
}

Future setLanguage(String lang) async{
  String jsonContent = await rootBundle.loadString("assets/localization/$lang.json");
  R.initLocalized(jsonContent);
}

// === ALERT === //
Future<T> showAlert<T>(BuildContext context, String title, String message, List<Widget> actions) {
  if (actions == null) {
    actions = [
      CupertinoButton(
        child: Text(R.strings.ok),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ];
  }

  return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: actions,
        );
      });
}

Future<T> showActionSheet<T>(BuildContext context, Widget builderItem, double height, List<Widget> actions, [EdgeInsets padding = const EdgeInsets.all(20)]) {
  Widget buttonContent;
  if (actions.length == 2) {
    Widget left = actions[0];
    Widget right = actions[1];

    buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        left,
        SizedBox(width: 20),
        right,
      ],
    );
  }
  else {
    buttonContent = Column(
      children: actions,
    );
  }

  return showCupertinoModalPopup<T>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Container(
          padding: padding,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))
          ),
          child: Column(
            children: <Widget>[
              builderItem,
              SizedBox(height: 30),
              buttonContent,
            ],
          ),
        ),
      );
    },
  );
}


int _errorCode = 0;
void setErrorCode(int code) {
  _errorCode = code;
}



void showSystemMessage(BuildContext context) {
  if (_errorCode != 0) {
    Future.delayed(Duration(seconds: 0), () {
      String message;
      switch (_errorCode) {
        case LOGOUT_CODE:
          _errorCode = 0;
          return;

        case ACCESS_DENY:
          _errorCode = 0;
          message = R.strings.error + "$ACCESS_DENY";
          break;

        default:
          _errorCode = 0;
          message = "";
          return;
      }
      showAlert(context, R.strings.notice, message, [
        CupertinoButton(
          child: Text(R.strings.ok),
          onPressed: () => pop(context),
        )
      ]);
    });
  }
}





// === NAVIGATOR === //
void showPage<T>(BuildContext context, Widget page) {
  hideLoading(context);

  // TODO: pop all route
  //Navigator.of(context).popUntil((route) => route.isFirst);

  Route route = _NoAnimateRoute(fullscreenDialog: true, builder: (context) => page);
  Navigator.of(context).pushReplacement(route);
}

Future<T> pushPage<T>(BuildContext context, Widget page) {
  if (_errorCode == MAINTENANCE) {
    showSystemMessage(context);
    return null;
  }

  hideLoading(context);

  Route<T> route = _FullPageRoute<T>(animationType: RouteType.push, builder: (context) => page);
  return Navigator.of(context).push(route);
}

Future<T> presentPage<T>(BuildContext context, Widget page) {
  if (_errorCode == MAINTENANCE) {
    showSystemMessage(context);
    return null;
  }

  hideLoading(context);

  Route<T> route = _FullPageRoute<T>(animationType: RouteType.present, builder: (context) => page);
  return Navigator.of(context).push(route);
}

Future<T> replacePage<T>(BuildContext context, Widget page, {dynamic result}) {
  if (_errorCode == MAINTENANCE) {
    showSystemMessage(context);
    return null;
  }

  hideLoading(context);

  CupertinoPageRoute<T> route = CupertinoPageRoute<T>(fullscreenDialog: true, builder: (context) => page);
  return Navigator.of(context).pushReplacement(route, result: result);
}

void pop(BuildContext context, [dynamic object]) {
  Navigator.of(context).pop(object);
}



// === VALIDATE === //
int getPlatform() {
  return Platform.isIOS ? PlatformType.iOS.index : PlatformType.Android.index;
}



// === LOADING === //
_IndicatorRoute _indicator;

void showLoading(BuildContext context) {
  if (_indicator == null) {
    _indicator = _IndicatorRoute();

//    Future.delayed(Duration.zero, () => Navigator.of(context, rootNavigator: true).push(_indicator));
    Navigator.of(context, rootNavigator: true).push(_indicator);
  }
}

void hideLoading(BuildContext context) {
  if (_indicator != null) {
    Navigator.of(context, rootNavigator: true).pop(_indicator);
    _indicator = null;
  }
}

class _IndicatorRoute<T> extends ModalRoute {
  _IndicatorRoute({bool barrierDismissible = true, String barrierLabel, Color barrierColor = const Color(0x80000000), RouteSettings settings})
      : assert(barrierDismissible != null),
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        super(settings: settings) {
    Future.delayed(loadingTimeout, () {
      isClosable = true;
    });
  }

  final Duration loadingTimeout = Duration(seconds: 30);
  bool isClosable = false;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Future<RoutePopDisposition> willPop() {
    if (!isClosable) return Future.value(RoutePopDisposition.doNotPop);
    return super.willPop();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return GestureDetector(
      onTap: () {
        if (isClosable) hideLoading(context);
      },
      child: Semantics(
        child: CupertinoActivityIndicator(
          radius: 20,
          animating: true,
        ),
        scopesRoute: true,
        explicitChildNodes: true,
      ),
    );
  }
}


class _NoAnimateRoute<T> extends CupertinoPageRoute<T> {
  _NoAnimateRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class _FullPageRoute<T> extends PageRoute<T> {
  _FullPageRoute({
    @required this.builder,
    this.title,
    RouteSettings settings,
    this.maintainState = true,
    this.animationType,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(opaque),
        super(settings: settings, fullscreenDialog: true);

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  final String title;

  final animationType;

  ValueNotifier<String> _previousTitle;

  ValueListenable<String> get previousTitle {
    assert(
      _previousTitle != null,
      'Cannot read the previousTitle for a route that has not yet been installed',
    );
    return _previousTitle;
  }

  @override
  void didChangePrevious(Route<dynamic> previousRoute) {
    final String previousTitleString = previousRoute is CupertinoPageRoute ? previousRoute.title : null;
    if (_previousTitle == null) {
      _previousTitle = ValueNotifier<String>(previousTitleString);
    } else {
      _previousTitle.value = previousTitleString;
    }
    super.didChangePrevious(previousRoute);
  }

  @override
  final bool maintainState;

  @override
  // A relatively rigorous eyeball estimation.
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is CupertinoPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog;
  }

  static bool isPopGestureInProgress(PageRoute<dynamic> route) {
    return route.navigator.userGestureInProgress;
  }

  bool get popGestureInProgress => isPopGestureInProgress(this);

  bool get popGestureEnabled => _isPopGestureEnabled(this);

  static bool _isPopGestureEnabled<T>(PageRoute<T> route) {
    // If there's nothing to go back to, then obviously we don't support
    // the back gesture.
    if (route.isFirst) return false;
    // If the route wouldn't actually pop if we popped it, then the gesture
    // would be really confusing (or would skip internal routes), so disallow it.
    if (route.willHandlePopInternally) return false;
    // If attempts to dismiss this route might be vetoed such as in a page
    // with forms, then do not allow the user to dismiss the route with a swipe.
    if (route.hasScopedWillPopCallback) return false;
    // Fullscreen dialogs aren't dismissible by back swipe.
    if (route.fullscreenDialog) return false;
    // If we're in an animation already, we cannot be manually swiped.
    if (route.animation.status != AnimationStatus.completed) return false;
    // If we're being popped into, we also cannot be swiped until the pop above
    // it completes. This translates to our secondary animation being
    // dismissed.
    if (route.secondaryAnimation.status != AnimationStatus.dismissed) return false;
    // If we're in a gesture already, we cannot start another.
    if (isPopGestureInProgress(route)) return false;

    // Looks like a back gesture would be welcome!
    return true;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final Widget result = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
    assert(() {
      if (result == null) {
        throw FlutterError('The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return result;
  }

  static Widget buildPageTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    RouteType routeType,
    Widget child,
  ) {
    if (routeType == RouteType.present) {
      return CupertinoFullscreenDialogTransition(
        // animation: animation,
        child: child,
      );
    } else {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: isPopGestureInProgress(route),
        child: child,
      );
    }
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return buildPageTransitions<T>(this, context, animation, secondaryAnimation, animationType, child);
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}



