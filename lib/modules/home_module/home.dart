import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/events/events_page.dart';
import 'package:open_art/modules/guests/guests_page.dart';
import 'package:open_art/modules/home_module/widgets/home_btn.dart';
import 'package:open_art/modules/settings/settings_page.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';
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
    return Consumer<AppThemeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: appThemeModel.lightAppTheme
            ? amTheme.background
            : pmTheme.background,
        // drawer: Drawer(),
        appBar: AppBar(
          // leading: Icon(
          //   Icons.more_vert_outlined,
          //   color: appThemeModel.lightAppTheme ? amTheme.black : pmTheme.black,
          // ),
          elevation: .5.sp,
          backgroundColor: appThemeModel.lightAppTheme
              ? amTheme.background
              : pmTheme.background,
          centerTitle: true,
          title: Image.asset(
            "assets/images/Logo.png",
            scale: 4.sp,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //
                //   ),
                //   child: ,
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Styles.bold(
                            "Emmanuel,",
                            color: appThemeModel.lightAppTheme
                                ? amTheme.titleActive
                                : pmTheme.titleActive,
                            align: TextAlign.left,
                            fontSize: 26.sp,
                          ),
                          VSpace(5.h),
                          Styles.regular(
                            "Welcome rgtthrhst db,",
                            color: appThemeModel.lightAppTheme
                                ? amTheme.titleActive
                                : pmTheme.titleActive,
                            align: TextAlign.left,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 21.r,
                        backgroundColor: amTheme.primary,
                        child: Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Center(
                //   child: Styles.bold(
                //     "Your Digital Art",
                //     color:
                //         appThemeModel.lightAppTheme ? amTheme.text : pmTheme.text,
                //     align: TextAlign.center,
                //     fontSize: 32.sp,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: deviceWidth(context) / 15),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Flexible(
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               radius: 40,
                //               backgroundColor: amTheme.primary,
                //               child: Icon(
                //                 CupertinoIcons.photo_camera,
                //                 color: Colors.white,
                //               ),
                //             ),
                //             SizedBox(width: deviceWidth(context) / 20),
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "fullname name",
                //                     style: TextStyle(
                //                         fontSize: deviceWidth(context) / 22,
                //                         fontWeight: FontWeight.w700,
                //                         fontFamily: "TTNorms",
                //                         color: amTheme.black),
                //                     maxLines: 2,
                //                     overflow: TextOverflow.ellipsis,
                //                   ),
                //                   VSpace(deviceHeight(context) / 100),
                //                   Text(
                //                     "user@email.email",
                //                     style: TextStyle(
                //                         fontSize: deviceWidth(context) / 27,
                //                         fontWeight: FontWeight.w400,
                //                         fontFamily: "TTNorms",
                //                         color: amTheme.fade),
                //                     maxLines: 2,
                //                     overflow: TextOverflow.ellipsis,
                //                   ),
                //                   VSpace(deviceHeight(context) / 100),
                //                   Text(
                //                     "01234567890",
                //                     style: TextStyle(
                //                         fontSize: deviceWidth(context) / 27,
                //                         fontWeight: FontWeight.w500,
                //                         fontFamily: "TTNorms",
                //                         color: amTheme.fade),
                //                     maxLines: 2,
                //                     overflow: TextOverflow.ellipsis,
                //                   ),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Divider(
                //   height: deviceHeight(context) / 15,
                //   indent: deviceWidth(context) / 15,
                //   endIndent: deviceWidth(context) / 15,
                //   color: amTheme.fade,
                //   thickness: 1,
                // ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 20.h,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              HomeBtn(
                                title: "Events",
                                primary: amTheme.warning,
                                secondary: amTheme.urgent.withOpacity(0.7),
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventsPage(),
                                    ),
                                  );
                                },
                                icon: Icons.calendar_today_outlined,
                              ),
                              HSpace(10.h),
                              HomeBtn(
                                title: "Scan",
                                primary: amTheme.secondary,
                                // secondary: amTheme.inBetween.withOpacity(0.7),
                                secondary: amTheme.urgent,
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventsPage(
                                        isScan: true,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.camera,
                              ),
                              // Expanded(
                              //   child: Container(
                              //     height: deviceHeight(context),
                              //     width: deviceWidth(context),
                              //     padding:
                              //         EdgeInsets.only(left: 20.w, bottom: 30.h),
                              //     decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //         begin: Alignment.bottomLeft,
                              //         end: Alignment.topRight,
                              //         colors: [
                              //           amTheme.secondary,
                              //           amTheme.inBetween.withOpacity(0.7),
                              //         ],
                              //       ),
                              //       borderRadius: BorderRadius.circular(15.r),
                              //     ),
                              //     child: Align(
                              //         alignment: Alignment.bottomLeft,
                              //         child: Container(
                              //           width: deviceWidth(context) / 4,
                              //           child: Styles.bold(
                              //             "Scan",
                              //             align: TextAlign.left,
                              //             color: amTheme.offWhite,
                              //             fontSize: 24.sp,
                              //           ),
                              //         )),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        VSpace(10.h),
                        Expanded(
                          child: Row(
                            children: [
                              HomeBtn(
                                title: "Guests",
                                primary: amTheme.primary,
                                secondary: amTheme.fadeRed,
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventsPage(
                                        isGuest: true,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.people_outline_outlined,
                              ),
                              HSpace(10.h),
                              HomeBtn(
                                title: "Settings",
                                primary: amTheme.green,
                                secondary: amTheme.brightgreen,
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsPage()),
                                  );
                                },
                                icon: Icons.settings,
                              ),
                              // Expanded(
                              //   child: Container(
                              //     height: deviceHeight(context),
                              //     width: deviceWidth(context),
                              //     padding:
                              //         EdgeInsets.only(left: 20.w, bottom: 30.h),
                              //     decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //         begin: Alignment.bottomLeft,
                              //         end: Alignment.topRight,
                              //         colors: [
                              //           amTheme.green,
                              //           amTheme.brightgreen,
                              //         ],
                              //       ),
                              //       borderRadius: BorderRadius.circular(15.r),
                              //     ),
                              //     child: Align(
                              //       alignment: Alignment.bottomLeft,
                              //       child: Container(
                              //         width: deviceWidth(context) / 4,
                              //         child: Styles.bold("Settings",
                              //             align: TextAlign.left,
                              //             color: amTheme.offWhite,
                              //             fontSize: 24.sp),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
