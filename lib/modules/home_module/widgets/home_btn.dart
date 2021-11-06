import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBtn extends StatelessWidget {
  final VoidCallback onClick;
  final Color primary;
  final Color secondary;
  final String title;
  final IconData icon;
  const HomeBtn({
    this.onClick,
    this.primary,
    this.secondary,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(3.r)),
          child: Container(
            height: deviceHeight(context),
            width: deviceWidth(context),
            padding: EdgeInsets.only(left: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  primary,
                  secondary.withOpacity(0.8),
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
            child: Stack(
              children: [
                Positioned(
                  bottom: -15.h,
                  right: -40.w,
                  child: Icon(
                    icon,
                    size: 130.sp,
                    color: primary,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: deviceWidth(context) / 4,
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Styles.bold(
                      title,
                      align: TextAlign.left,
                      color: amTheme.offWhite,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
