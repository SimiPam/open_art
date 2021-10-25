import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_art/shared/utils/color.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/custom_button.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/textform_field_with_icon.dart';

class LoginFirstUser extends StatefulWidget {
  const LoginFirstUser({Key key}) : super(key: key);

  @override
  _LoginFirstUserState createState() => _LoginFirstUserState();
}

class _LoginFirstUserState extends State<LoginFirstUser> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: deviceWidth(context), maxHeight: deviceHeight(context)),
    //     designSize: Size(375, 812),
    //     orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: amTheme.white,
      body: Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FaIcon(FontAwesomeIcons.chevronLeft, color: bunkerDark, size: 16,),
                      ),
                      VSpace(16.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/dot_1.png")
                              ],
                            ),
                            VSpace(3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/dot_2.png")
                              ],
                            ),
                          ],
                        ),
                      ),
                      VSpace(50.h),
                      Styles.bold(
                        "Log in",
                        fontSize: 20.sp,
                        color: bunkerDark
                      ),
                      VSpace(8.h),
                      Styles.regular(
                        "Hello, sign in to start booking consulations\nwith our doctors",
                        fontSize: 14.sp,
                        color: mecuryGrey,
                        height: 1.4
                      ),
                      VSpace(36.h),
                      TextFormFieldWithIcon(
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: Icon(Icons.check_circle),
                      ),
                      VSpace(16.h),
                      TextFormFieldWithIcon(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility),
                      ),
                      VSpace(24.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Styles.semiBold("Forgot Password?",
                            color: activeGreen,
                            fontSize: 14.sp
                        ),
                      ),
                      VSpace(60.h),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            title: "Log in",
                            isActive: false,
                            onPress: () {
                              print("Login In");
                            }),
                      ),
                      VSpace(45.h),
                      Container(
                        width: deviceWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Styles.regular("Don't have an account?"),
                            HSpace(3.w),
                            Styles.regular("Sign up", color: activeGreen)
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
