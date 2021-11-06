import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_routing.dart';
import 'package:open_art/shared/models/route_model.dart';

class AuthModule {
  AuthModule();

  static final List<RouteOption> routes = <RouteOption>[
    RouteOption(
      path: 'login',
      builder: (BuildContext context, AjanuwRouting<Object> r) {
        // return LoginFirstUser();
      },
    ),
  ];
}
