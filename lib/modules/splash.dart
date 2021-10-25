import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_art/shared/utils/utils.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the 360*690(dp)
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: deviceWidth(context), maxHeight: deviceHeight(context)),
        designSize: Size(deviceWidth(context), deviceHeight(context)),
        orientation: Orientation.portrait);
    return Scaffold(
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/splash.png"))),
      ),
    );
  }
}
