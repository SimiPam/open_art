import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:open_art/core/service_injector/service_injector.dart';
import 'package:open_art/core/services/utilities_service.dart';
import 'package:open_art/shared/models/layout_model.dart';
import 'package:open_art/shared/models/user_model.dart';
import 'package:open_art/shared/utils/dims.dart';
import 'package:open_art/shared/utils/role_routes.dart';

class AppGuard extends StatefulWidget {
  static const String route = '/guard';

  @override
  _AppGuardState createState() {
    return _AppGuardState();
  }
}

class _AppGuardState extends State<AppGuard> {
  bool _authCheck = false;

  @override
  void initState() {
    super.initState();

    print('Guarding app url path...');

    _handleGuardPermission();
  }

  void _checkStockedStatus() {
    Future<int>.delayed(
      const Duration(seconds: 8),
    ).then((int value) async {
      if (!_authCheck) {
        await si.authService.signOut();

        si.layoutService.updateLayout(LayoutConfig());
        si.routerService.pushNamed('/auth/login');
      }
    });
  }

  List<String> _getRoleRoute(User user) {
    final List<String> roles = <String>[];

    if (user.userType.id == 4) {
      var roleRoutes3 = RoleRoutes;
      var roleRoutes2 = roleRoutes3;
      var roleRoutes = roleRoutes2;
      //roles.add(roleRoutes.records);
    } else if (user.userType.id == 2) {
      if (user.serviceCenter.id == 1) {
        roles.add(RoleRoutes.inPatientDoctor);
      } else if (user.serviceCenter.id == 2) {
        roles.add(RoleRoutes.outPatientDoctor);
      }
      // switch (user.department.id) {
      //   // more doctor options will come here later

      //   default:
      //     {
      //       roles.add(RoleRoutes.inPatientDoctor);
      //       roles.add(RoleRoutes.outPatientDoctor);
      //     }
      // }
    } else if (user.userType.id == 3) {
      // nurse
      if (user.serviceCenter.id == 1) {
        roles.add(RoleRoutes.inPatientNurse);
      } else if (user.serviceCenter.id == 2) {
        roles.add(RoleRoutes.outPatientNurse);
      }
    }

    final String prevRole = si.storeService.getDataSync<String>('activeRole');
    if (roles.isNotEmpty && roles.contains(prevRole)) {
      roles.insert(0, prevRole);
    }

    return roles;
  }

  Future<String> _getValidUrl() async {
    _authCheck = false;
    _checkStockedStatus();

    final bool isLoggedIn = await si.authService.isLoggedIn();
    _authCheck = true;

    if (isLoggedIn) {
      // get currently logged in user
      final User user = (await si.userService.getCurrentUser().first).data;

      if (user != null) {
        final List<String> roles = _getRoleRoute(user);
        return roles.isNotEmpty ? ('/app/' + roles[0]) : '';
      }

      si.layoutService.updateLayout(LayoutConfig());
      return '/auth/login';
    } else {
      si.layoutService.updateLayout(LayoutConfig());
      return '/auth/login';
    }
  }

  Future<void> _handleGuardPermission() async {
    // handle guard checks here
    final String url = await _getValidUrl();

    if (url.isNotEmpty) {
      si.routerService.pushReplacementNamed(url);

      if (url.startsWith('/app/')) {
        Future<int>.delayed(const Duration(milliseconds: 500))
            .then((int value) {
          si.layoutService.updateLayout(
            LayoutConfig(
              type: AppLayoutTypes.DASHBOARD,
            ),
          );
        });

        si.storeService.setDataSync('activeRole', url.split('/').last);
      }
    } else {
      // take the user to denied route
      print('permission denied page route here');
    }
  }

  @override
  Widget build(BuildContext context) {
    return UtilitiesService.progress(
      size: Dims.dx(50),
    );
  }
}
