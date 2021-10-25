import 'package:flutter/material.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppThemeModel appThemeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appThemeModel.lightAppTheme ? amTheme.inBetween : pmTheme.inBetween,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 1,
        backgroundColor:
            appThemeModel.lightAppTheme ? amTheme.inBetween : pmTheme.inBetween,
        centerTitle: true,
        title: Image.asset(
          "assets/images/Logo.png",
          scale: 3,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: ListView(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //
              //   ),
              //   child: ,
              // ),
              Center(
                child: Styles.bold(
                  "Discover, collect, and sell",
                  color: appThemeModel.lightAppTheme
                      ? amTheme.layer
                      : pmTheme.layer,
                  align: TextAlign.center,
                  fontSize: 18.sp,
                ),
              ),
              Center(
                child: Styles.bold(
                  "Your Digital Art",
                  color:
                      appThemeModel.lightAppTheme ? amTheme.text : pmTheme.text,
                  align: TextAlign.center,
                  fontSize: 32.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
