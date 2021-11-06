import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/scan/scan_page.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/snack_bar.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'guest_list_page.dart';

class GuestsPage extends StatefulWidget {
  final bool isScan;
  const GuestsPage({this.isScan = false});

  @override
  _GuestsPageState createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  AppThemeModel appThemeModel;
  final _formKey = GlobalKey<FormState>();
  String qrString = "Not Scanned";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrString = value;
        });

        Scaffold.of(context).showSnackBar(snackBar(
            message: "Check in successful",
            context: context,
            duration: 2,
            bgColor: amTheme.green));

        ///display error message
        // Scaffold.of(context).showSnackBar(snackBar(
        //     message: Provider.of<ProductModel>(context, listen: false).deleteWishListProductMessage,
        //     context: context,
        //     duration: 2,
        //     bgColor: brickRed
        // ));
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(snackBar(
          message: "Check in unsuccessful",
          context: context,
          duration: 2,
          bgColor: amTheme.red));
      setState(() {
        qrString = "unable to read the qr";
      });
    }
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
                          "Guests",
                          color: appThemeModel.lightAppTheme
                              ? amTheme.titleActive
                              : pmTheme.titleActive,
                          fontSize: deviceWidth(context) / 15,
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace(10.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return InkResponse(
                            onTap: () {
                              widget.isScan
                                  ? scanQR()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GuestsListPage(),
                                      ),
                                    );
                            },
                            child: Container(
                              // margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),

// height: 170,
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 9, horizontal: 35),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Colors.white60,
                                border: Border.all(
                                    width: 1.0,
                                    color: appThemeModel.lightAppTheme
                                        ? amTheme.line
                                        : pmTheme.line),
                                // borderRadius: BorderRadius.circular(15.r),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.r),
                                  topLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r),
                                  bottomLeft: Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                // padding:  EdgeInsets.fromLTRB(20, 10, 20, 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Styles.semiBold(
                                      "Event one",
                                      fontSize: 18.sp,
                                      color: appThemeModel.lightAppTheme
                                          ? amTheme.titleActive
                                          : pmTheme.titleActive,
                                      lines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    VSpace(2.sp),
                                    Styles.regular("Created: 18/06/2021",
                                        color: appThemeModel.lightAppTheme
                                            ? amTheme.titleActive
                                            : pmTheme.line,
                                        fontSize: 12.sp)
                                  ],
                                ),
                              ),
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
