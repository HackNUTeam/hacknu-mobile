import 'package:flutter/material.dart';

class NavigatorApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  final RouteFactory route;
  const NavigatorApp({super.key, required this.navKey, required this.route});

  @override
  State<NavigatorApp> createState() => _NavigatorAppState();
}

class _NavigatorAppState extends State<NavigatorApp> {
  GlobalKey<NavigatorState> get navKey => widget.navKey;
  RouteFactory get routes => widget.route;

  @override
  Widget build(BuildContext context) {
    return Navigator(key: navKey, onGenerateRoute: widget.route);
  }
}
