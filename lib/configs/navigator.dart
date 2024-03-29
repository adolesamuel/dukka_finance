import 'package:flutter/material.dart';

void navigateReplace(BuildContext context, Widget route,
        {bool isDialog = false}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<dynamic>(
        fullscreenDialog: isDialog,
        builder: (BuildContext context) => route,
      ),
    );

void navigateReplaceNamed(BuildContext context, String routeName,
        {Object? args}) =>
    Navigator.pushReplacementNamed(context, routeName, arguments: args);

void navigate(BuildContext context, Widget route, {bool isDialog = false}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => route,
      ),
    );

Future<T?> navigateName<T>(BuildContext context, String routeName,
        {Object? args}) =>
    Navigator.pushNamed<T?>(context, routeName, arguments: args);

void recursivePopAll(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
    recursivePopAll(context);
  }
}

void pushUntil(BuildContext context, Widget route) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    return route;
  }), (Route<dynamic> route) => false);
}

navigatePopUntilNamedRoute(BuildContext context, String routeName) {
  Navigator.popUntil(
    context,
    (route) => route.settings.name == routeName,
  );
}

void popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

void popView(BuildContext context) => Navigator.pop(context);

dynamic navigatorTransparentRoute(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    TransparentRoute(
      builder: (BuildContext context) => route,
    ),
  );
}

class TransparentRoute extends PageRoute<void> {
  final WidgetBuilder builder;

  TransparentRoute({required this.builder, RouteSettings? settings})
      : super(fullscreenDialog: false, settings: settings);

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget result = builder(context);

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final Duration? transitionTime;
  FadeRoute({
    required this.page,
    this.transitionTime,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  @override
  Duration get transitionDuration =>
      transitionTime ?? const Duration(milliseconds: 500);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
