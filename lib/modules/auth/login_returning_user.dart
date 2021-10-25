import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_art/shared/utils/color.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/custom_button.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/textform_field_with_icon.dart';

class LoginReturningUser extends StatefulWidget {
  const LoginReturningUser({Key key}) : super(key: key);

  @override
  _LoginReturningUserState createState() => _LoginReturningUserState();
}

class _LoginReturningUserState extends State<LoginReturningUser> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: deviceWidth(context), maxHeight: deviceHeight(context)),
    //     designSize: Size(deviceWidth(context), deviceHeight(context)),
    //     orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: backGroundGrey,
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
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: bunkerDark,
                          size: 16,
                        ),
                      ),
                      VSpace(8.h),
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
                      VSpace(120.h),
                      Styles.bold("Welcome back, Temitope",
                          fontSize: 20.sp, color: bunkerDark),
                      VSpace(8.h),
                      Styles.regular("You can log in to continue",
                          fontSize: 14.sp, color: mecuryGrey, height: 1.7),
                      VSpace(52.h),
                      TextFormFieldWithIcon(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility),
                      ),
                      VSpace(24.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Styles.semiBold("Forgot Password?",
                            color: activeGreen, fontSize: 14.sp),
                      ),
                      VSpace(60.h),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            title: "Log in",
                            isActive: true,
                            onPress: () {
                              print("Login In");
                            }),
                      ),
                      VSpace(60.h),
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
