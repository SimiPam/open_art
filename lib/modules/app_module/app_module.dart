import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_routing.dart';
import 'package:open_art/modules/my_account/my_account.module.dart';
import 'package:open_art/router/route_composer.dart';
import 'package:open_art/shared/models/route_model.dart';

class AppModule {
  AppModule();

  static final List<RouteOption> routes = <RouteOption>[
    RouteOption(
      path: '',
      builder: (BuildContext context, AjanuwRouting<Object> r) {
        // typical page not found example
        return Container(
          child: const Text('Page not found'),
        );
      },
    ),

    /// Example
    ...RouteComposer.compose(
      'account',
      MyAccountModule.routes,
    ),
    // Add other route modules here
  ];
}
