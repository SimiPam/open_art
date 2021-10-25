import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_art/core/gaurds/app_guard.dart';
import 'package:open_art/core/service_injector/service_injector.dart';
import 'package:open_art/shared/models/api_model.dart';
import 'package:open_art/shared/models/auth_model.dart';
import 'package:open_art/shared/utils/dims.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/widgets/action_button.dart';
import 'package:open_art/shared/widgets/space.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _Inputs _inputs = _Inputs();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dims.deviceSize.width,
      height: Dims.deviceSize.height,
      color: pmTheme.page,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: Dims.dx(350.0),
              padding: EdgeInsets.all(Dims.dx(15)),
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome to SBSC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: pmTheme.black,
                        fontSize: Dims.dx(24.0),
                        fontFamily: 'Gilroy',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700),
                  ),
                  VSpace(Dims.dx(11)),
                  Text(
                    'Please enter your username and password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: pmTheme.greyIcon,
                        fontSize: Dims.dx(16.0),
                        fontFamily: 'Gilroy',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                  VSpace(Dims.dx(30.0)),
                  Form(
                    child: Column(
                      children: <Widget>[
                        // CustomTextField(
                        //   val: _inputs.username,
                        //   hint: 'Username',
                        //   action: TextInputAction.next,
                        //   fontSize: Dims.dx(16.0),
                        //   color: pmTheme.lowerText,
                        //   height: Dims.dx(48.0),
                        //   radius: Dims.dx(10.0),
                        //   lns: 1,
                        //   borderColor: pmTheme.halfFade,
                        //   fillColor: pmTheme.white,
                        //   parentPadding: Dims.dx(15),
                        //   onChange: (String v) {
                        //     setState(() {
                        //       _inputs.username = v;
                        //     });
                        //   },
                        // ),
                        // VSpace(Dims.dx(30.0)),
                        // CustomTextField(
                        //   val: _inputs.pin,
                        //   hint: 'Password',
                        //   action: TextInputAction.next,
                        //   fontSize: Dims.dx(16.0),
                        //   color: pmTheme.lowerText,
                        //   height: Dims.dx(48.0),
                        //   radius: Dims.dx(10.0),
                        //   parentPadding: Dims.dx(15),
                        //   borderColor: pmTheme.halfFade,
                        //   fillColor: pmTheme.white,
                        //   visibleText: false,
                        //   onChange: (String v) {
                        //     setState(() {
                        //       _inputs.pin = v;
                        //     });
                        //   },
                        // ),
                        VSpace(Dims.dx(30.0)),
                        ActionButton(
                          text: 'Login',
                          clicked: _doLogin,
                          disabled: !_isValid(),
                          loading: _loading,
                          fontSize: Dims.dx(16.0),
                          height: Dims.dx(50.0),
                          color: pmTheme.blue,
                          textColor: pmTheme.white,
                          radius: BorderRadius.circular(Dims.dx(10.1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValid() {
//return true;
    return _inputs.username.isNotEmpty && _inputs.pin.isNotEmpty;
  }

  Future<void> _doLogin() async {
    setState(() {
      _loading = true;
    });
// login here
    final ApiResponse<AuthPayload> res =
        await si.authService.login(_inputs.username, _inputs.pin);

    if (res.error) {
      // si.dialogService.toast(
      //   ToastData(
      //     context: context,
      //     msg: res.message,
      //   ),
      // );

      setState(() {
        _loading = false;
      });
    } else {
      si.storageService.setItem('auth_data', json.encode(res.data.toJson()));
      si.routerService.pushReplacementNamed(AppGuard.route);
    }
  }
}

class _Inputs {
  _Inputs() {
    username = '';
    pin = '';
  }

  String username;
  String pin;
}
