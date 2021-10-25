// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:healing_rays/shared/utils/color.dart';
// import 'package:healing_rays/shared/utils/styles.dart';
//
// PreferredSizeWidget scheduleAppBar(BuildContext context, String title,
//     {bool hasAction = false}) {
//   return AppBar(
//     backgroundColor: white,
//     centerTitle: true,
//     elevation: 0,
//     leading: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Icon(Icons.arrow_back_ios, color: bunkerDark, size: 16)),
//     title: Styles.semiBold(title, color: bunkerDark, fontSize: 16.sp),
//     actions: hasAction
//     ? [
//     Padding(
//       padding: EdgeInsets.only(right: 16.0),
//       child: Icon(
//         Icons.search,
//         color: bunkerDark,
//       ),
//     )
//     ]
//         : null,
//   );
// }
