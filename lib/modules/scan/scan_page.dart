import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/settings/widgets/outline_btn.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrString = "Not Scanned";
  String barcode = "";
  AppThemeModel appThemeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appThemeModel = Provider.of<AppThemeModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          appThemeModel.lightAppTheme ? amTheme.background : pmTheme.background,
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            qrString,
            style: TextStyle(color: Colors.blue, fontSize: 34),
          ),
          ElevatedButton(onPressed: scanQR, child: Text("Scan QR Code")),
          SizedBox(width: width),
        ],
      ),
    );
  }

  // Future scan() async {
  //   try {
  //     String barcode = (await BarcodeScanner.scan()) as String;
  //     setState(() => this.barcode = barcode);
  //   } on PlatformException catch (e) {
  //     if (e.code == BarcodeScanner.CameraAccessDenied) {
  //       setState(() {
  //         this.barcode = 'The user did not grant the camera permission!';
  //       });
  //     } else {
  //       setState(() => this.barcode = 'Unknown error: $e');
  //     }
  //   } on FormatException {
  //     setState(() => this.barcode =
  //         'null (User returned using the "back"-button before scanning anything. Result)');
  //   } catch (e) {
  //     setState(() => this.barcode = 'Unknown error: $e');
  //   }
  // }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrString = value;
        });
      });
    } catch (e) {
      setState(() {
        qrString = "unable to read the qr";
      });
    }
  }
}
