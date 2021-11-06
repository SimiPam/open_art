import 'package:flutter/material.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:provider/provider.dart';

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;
  AppThemeModel appThemeModel;

  void toggleSwitch(bool value) {
    appThemeModel.switchAppTheme();
    // if (isSwitched == false) {
    //
    //   setState(() {
    //     isSwitched = true;
    //   });
    //   print('Switch Button is ON');
    // } else {
    //   setState(() {
    //     isSwitched = false;
    //   });
    //   print('Switch Button is OFF');
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1,
        child: Switch(
          onChanged: toggleSwitch,
          value: appThemeModel.lightAppTheme,
          activeColor: amTheme.black,
          activeTrackColor: amTheme.green,
          inactiveThumbColor: amTheme.green,
          inactiveTrackColor: pmTheme.line,
        ));
  }
}
