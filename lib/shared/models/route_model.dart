import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_routing.dart';

class RouteOption {
  RouteOption({
    @required this.path,
    this.builder,
    this.title,
    this.persist,
    this.redirectTo,
  });

  String title;
  String path;
  String redirectTo;
  bool persist;
  Widget Function(BuildContext, AjanuwRouting<Object>) builder;
}
