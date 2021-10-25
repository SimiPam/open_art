import 'package:flutter/material.dart';
import 'package:open_art/core/gaurds/app_guard.dart';
import 'package:open_art/core/service_injector/service_injector.dart';
import 'package:open_art/router/app_router.dart';
import 'package:rxdart/rxdart.dart';

class RouterService {
  PublishSubject<String> route$ = PublishSubject<String>();
  String _currentRoute = '';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  void _onRouteChange([String path]) {
    _currentRoute = path;

    route$.add(path);
  }

  void pushNamed(String path) {
    if (path == _currentRoute) {
      print('Trying to navigate to already existing url');
      return;
    }

    si.layoutService.updateMenu(null);
    AppRouter.router.pushNamed(path);
    _onRouteChange(path);
  }

  void rebaseAndRoute(List<String> urls) {
    final String first = urls.removeAt(0);

    clearAndPush(first);
    for (int i = 0; i < urls.length; i++) {
      pushNamed(urls.elementAt(i));
    }
  }

  void clearAndPush(String path, [bool Function(Route<dynamic> r) handler]) {
    handler ??= (Route<dynamic> route) {
      return route.settings.name == AppGuard.route;
    };

    si.layoutService.updateMenu(null);
    AppRouter.router.pushNamedAndRemoveUntil(path, handler);
    _onRouteChange(path);
  }

  void pushReplacementNamed(String path, {bool patientProfile = false}) {
    if (!patientProfile) {
      si.layoutService.updateMenu(null);
    }

    AppRouter.router.pushReplacementNamed(path);
    _onRouteChange(path);
  }

  void pop() {
    si.layoutService.updateMenu(null);
    AppRouter.router.pop();
    _onRouteChange();
  }
}
