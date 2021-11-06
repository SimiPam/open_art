import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestsListPage extends StatefulWidget {
  final Map<dynamic, dynamic> guests;
  final eventName;
  final String eventkey;
  const GuestsListPage({this.guests, this.eventName, this.eventkey});

  @override
  _GuestsListPageState createState() => _GuestsListPageState();
}

class _GuestsListPageState extends State<GuestsListPage> {
  // AppThemeModel appThemeModel;
  final _formKey = GlobalKey<FormState>();
  String eventKey = "";

  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventKey = widget.eventkey;
    _ref = FirebaseDatabase.instance
        .reference()
        .child("path")
        .child(eventKey)
        .child("guestlist");
    // appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.guests.toString());
    return Consumer<AppThemeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor:
            model.lightAppTheme ? amTheme.background : pmTheme.background,
        body: SafeArea(
          child: Container(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: Column(
              children: [
                Container(
                  width: deviceWidth(context),
                  padding: EdgeInsets.only(
                      left: 20.w,
                      right: 30.w,
                      top: deviceHeight(context) / 20,
                      bottom: deviceHeight(context) / 40),
                  decoration: BoxDecoration(
                    color: model.lightAppTheme
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: model.lightAppTheme
                                    ? amTheme.black
                                    : pmTheme.black,
                              )),
                          HSpace(15.h),
                          Center(
                            child: Styles.extraBold(
                              widget.eventName,
                              color: model.lightAppTheme
                                  ? amTheme.titleActive
                                  : pmTheme.titleActive,
                              fontSize: deviceWidth(context) / 15,
                            ),
                          ),
                        ],
                      ),
                      InkResponse(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.search,
                            size: 31,
                            color: model.lightAppTheme
                                ? amTheme.black
                                : pmTheme.black,
                          )),
                    ],
                  ),
                ),
                VSpace(20.h),
                Expanded(
                  child: Container(
                    child: FirebaseAnimatedList(
                        // itemCount: 2,
                        query: _ref,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return InkResponse(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Styles.semiBold(
                                        snapshot.value["firstname"],
                                        fontSize: 18.sp,
                                        color: model.lightAppTheme
                                            ? amTheme.titleActive
                                            : pmTheme.titleActive,
                                        lines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      HSpace(2.sp),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 8.w,
                                            height: 8.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: snapshot.value["status"]
                                                  ? amTheme.green
                                                  : amTheme.red,
                                            ),
                                          ),
                                          HSpace(8.sp),
                                          Styles.regular(
                                              snapshot.value["status"]
                                                  ? "checked in"
                                                  : "absent",
                                              color: model.lightAppTheme
                                                  ? amTheme.titleActive
                                                  : pmTheme.line,
                                              fontSize: 12.sp)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: deviceHeight(context) / 15,
                                  // indent: deviceWidth(context) / 15,
                                  // endIndent: deviceWidth(context) / 15,
                                  color: amTheme.fade,
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          );
                        }),
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
