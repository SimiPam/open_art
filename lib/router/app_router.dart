import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_route.dart';
import 'package:flutter_ajanuw_router/ajanuw_routing.dart';
import 'package:flutter_ajanuw_router/flutter_ajanuw_router.dart';
import 'package:open_art/core/gaurds/app_guard.dart';
import 'package:open_art/modules/app_module/app_module.dart';
import 'package:open_art/modules/auth/auth_routes.dart';
import 'package:open_art/router/route_animation.dart';
import 'package:open_art/router/route_composer.dart';
import 'package:open_art/shared/models/route_model.dart';

List<RouteOption> routeOpts = <RouteOption>[
  RouteOption(
    builder: null,
    path: '',
    title: 'PlateauMed',
    redirectTo: AppGuard.route,
  ),
  RouteOption(
    path: AppGuard.route.substring(1),
    builder: (BuildContext context, AjanuwRouting<Object> r) {
      return AppGuard();
    },
  ),
  RouteOption(
    path: '**',
    // @TODO: handle some logic here to ensure navigation to destination and for deep-linking
    redirectTo: AppGuard.route,
    //   builder: (BuildContext ctx, AjanuwRouting<Object> r) {
    //     print(r.settings.name);

    //     return Container();
    //   },
  ),

  // Module routes
  ...RouteComposer.compose(
    'auth',
    AuthModule.routes,
  ),

  ...RouteComposer.compose(
    'app',
    AppModule.routes,
  ),
];

class AppRouter {
  AppRouter();

  static AjanuwRouter router = AjanuwRouter();
  static final List<AjanuwRoute<Object>> routes =
      routeOpts.map((RouteOption e) {
    return AjanuwRoute<Object>(
      title: e.title,
      path: e.path,
      redirectTo: e.redirectTo,
      builder: e.builder,
      maintainState: e.persist ?? false,
      transitionDuration: transitionDuration(),
      transitionsBuilder: transitionsBuilder,
    );
  }).toList();
}
