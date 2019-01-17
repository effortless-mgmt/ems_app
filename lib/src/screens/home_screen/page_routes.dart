import 'package:flutter/material.dart';

class SlowMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlowMaterialPageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 750);
}

class SlidePageRoute<T> extends MaterialPageRoute<T> {
  SlidePageRoute(
      {WidgetBuilder builder, RouteSettings settings, bool fullscreenDialog})
      : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).chain(CurveTween(
      curve: Curves.bounceIn,
    ));

    return SlideTransition(
        position: animation.drive(_drawerDetailsTween),
        child: ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child)));
  }
}
