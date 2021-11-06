import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/settings/widgets/outline_btn.dart';
import 'package:open_art/modules/settings/widgets/switch.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppThemeModel appThemeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: appThemeModel.lightAppTheme
            ? amTheme.background
            : pmTheme.background,
        body: SafeArea(
          child: Container(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: deviceWidth(context),
                  padding: EdgeInsets.only(
                      left: 20.h,
                      top: deviceHeight(context) / 20,
                      bottom: deviceHeight(context) / 40),
                  decoration: BoxDecoration(
                    color: appThemeModel.lightAppTheme
                        ? amTheme.background
                        : pmTheme.background,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color.fromARGB(15, 0, 0, 0),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 1.0))
                    ],
                  ),
                  child: Row(
                    children: [
                      InkResponse(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: appThemeModel.lightAppTheme
                                ? amTheme.black
                                : pmTheme.black,
                          )),
                      HSpace(15.h),
                      Center(
                        child: Styles.extraBold(
                          "My Account",
                          color: appThemeModel.lightAppTheme
                              ? amTheme.titleActive
                              : pmTheme.titleActive,
                          fontSize: deviceWidth(context) / 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceHeight(context) / 40),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                  ),
                  child: Container(
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          amTheme.green,
                          amTheme.brightgreen,
                        ],
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     spreadRadius: 1,
                      //     blurRadius: 1,
                      //     offset: Offset(0, 1), // changes position of shadow
                      //   ),
                      // ],
                      // borderRadius: BorderRadius.circular(15.r),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          topLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                          bottomLeft: Radius.circular(3.r)),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) / 15,
                        vertical: deviceWidth(context) / 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: amTheme.text,
                                child: Icon(
                                  // CupertinoIcons.photo_camera,
                                  CupertinoIcons.person,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: deviceWidth(context) / 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Styles.bold(
                                      "Simi Pam Dachomo",
                                      color: appThemeModel.lightAppTheme
                                          ? amTheme.white
                                          : pmTheme.black,
                                      lines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18.sp,
                                    ),
                                    VSpace(deviceHeight(context) / 100),
                                    Styles.bold(
                                      "user@email.com",
                                      color: amTheme.inputBackground,
                                      lines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                    ),
                                    VSpace(deviceHeight(context) / 130),
                                    Styles.bold(
                                      "01234567890",
                                      color: amTheme.inputBackground,
                                      lines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider(
                //   height: deviceHeight(context) / 15,
                //   indent: deviceWidth(context) / 15,
                //   endIndent: deviceWidth(context) / 15,
                //   color: amTheme.fade,
                //   thickness: 1,
                // ),
                Container(
                  width: deviceWidth(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth(context) / 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.bold("Switch to Darkmode",
                          color: appThemeModel.lightAppTheme
                              ? amTheme.black
                              : pmTheme.black,
                          fontSize: 16.sp),
                      SwitchScreen(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth(context) / 15,
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChangePassword()),
                      // );
                    },
                    child: Styles.bold("Change Password",
                        color: appThemeModel.lightAppTheme
                            ? amTheme.black
                            : pmTheme.black,
                        fontSize: 16.sp),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth(context) / 15,
                        right: deviceWidth(context) / 15,
                        bottom: deviceHeight(context) / 35),
                    child: CustomOutlineButton(
                        lightmode: appThemeModel.lightAppTheme,
                        title: "Log Out",
                        textIsBold: true,
                        onPress: () {
                          // bottomNavViewModel.reset();
                          // authViewModel.logout();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Landing()),
                          // );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
