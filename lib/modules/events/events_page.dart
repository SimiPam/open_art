import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/guests/guest_list_page.dart';
import 'package:open_art/modules/settings/widgets/outline_btn.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/snack_bar.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsPage extends StatefulWidget {
  final bool isScan;
  final bool isGuest;
  const EventsPage({this.isScan = false, this.isGuest = false});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // AppThemeModel appThemeModel;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _eventName;
  String qrString = "Not Scanned";

  final dbRef = FirebaseDatabase.instance.reference();
  final Query _ref = FirebaseDatabase.instance
      .reference()
      .child("path")
      .orderByChild("eventname");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventName = TextEditingController();
  }

  List<dynamic> vv = [];
  List<dynamic> events = [];
  Future<List<dynamic>> loadCsvFromStorage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        // allowedExtensions: ['csv'],
        // type: FileType.custom,
        );

    print(result.files.first.extension);
    String path = result.files.first.path;
    final csvFile = new File(path).openRead();

    List<List<dynamic>> a = await csvFile
        .transform(utf8.decoder)
        .transform(
          CsvToListConverter(),
        )
        .toList();

    print("fsdlsdsds: " + a.toString());
    print(a.length.toString());
    for (int i = 1; i < a.length; i++) {
      List<dynamic> item = a[i];
      // print("sss: " + item.toString());
      print("uuuu: " + item[0].toString());
      print("jjjj: " + item[1].toString());

      Map<String, dynamic> b = {
        "firstname": item[0].toString(),
        "lastname": item[1].toString(),
        "email": item[2].toString(),
        "status": false,
      };
      print(b.toString());
      vv.add(b);
    }
    print(vv.toString());
    return vv;
  }

  bool isGuestFound = false;
  bool searchMethod({String guestEmail, key}) {
    FirebaseDatabase.instance
        .reference()
        .child("path")
        .child(key)
        .child("guestlist")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        // print(values["email"]);
        if (guestEmail.toLowerCase() == values["email"]) {
          setState(() {
            isGuestFound = true;
          });

          print("USER EXISTS..........................$isGuestFound");
          // return true;
        }
      });
    });
    print("$isGuestFound .......................");
    return isGuestFound;
  }

  Future<void> scanQR(key, context) async {
    // isFound = false;
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR)
          .then((value) {
        print("$value ..........................");
        bool isFound = searchMethod(guestEmail: value, key: key);

        if (isFound) {
          print("USER FOUND.....................");
          Scaffold.of(context).showSnackBar(snackBar(
              message: "Check-in successful",
              context: context,
              duration: 2,
              bgColor: amTheme.green));
        } else {
          print("NOT FOUND.....................");
          Scaffold.of(context).showSnackBar(snackBar(
              message: "Guest not found",
              context: context,
              duration: 2,
              bgColor: amTheme.red));
        }
      });
    } catch (e) {
      print("$e .....................");
      Scaffold.of(context).showSnackBar(snackBar(
          message: "Check-in unsuccessful",
          context: context,
          duration: 2,
          bgColor: amTheme.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor:
            model.lightAppTheme ? amTheme.background : pmTheme.background,
        floatingActionButton: widget.isGuest || widget.isScan
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: amTheme.green,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: model.lightAppTheme
                              ? amTheme.background
                              : pmTheme.background,
                          elevation: 2,
                          content: Stack(
                            clipBehavior: Clip.hardEdge,
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: amTheme.green,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _eventName,
                                        decoration: InputDecoration(
                                          hintText: "Enter Event Name",
                                          hintStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FWt.regular,
                                            color: model.lightAppTheme
                                                ? amTheme.fade
                                                : pmTheme.line,
                                          ),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: model.lightAppTheme
                                                      ? amTheme.fade
                                                      : pmTheme.line)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: amTheme.green)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: amTheme.red)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomOutlineButton(
                                        lightmode: model.lightAppTheme,
                                        title: "Upload Guest List",
                                        txtColor: model.lightAppTheme
                                            ? amTheme.placeholder
                                            : pmTheme.titleActive,
                                        textIsBold: false,
                                        onPress: () {
                                          loadCsvFromStorage();
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Create"),
                                        onPressed: () {
                                          String key =
                                              dbRef.child("path").push().key;
                                          ServerValue.timestamp;
                                          DateFormat dateFormat =
                                              DateFormat("dd/MM/yyyy");
                                          String strDate =
                                              dateFormat.format(DateTime.now());
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            if (_eventName.text.isNotEmpty &&
                                                vv.isNotEmpty) {
                                              String name = _eventName.text;
                                              Map<String, String> event = {
                                                "id": key,
                                                "eventname": name,
                                                "createddate": strDate,
                                              };
                                              dbRef
                                                  .child("path")
                                                  .child(key)
                                                  .set(event)
                                                  .then((value) {
                                                vv.forEach((element) {
                                                  String guestkey = dbRef
                                                      .child("path")
                                                      .child("guestlist")
                                                      .push()
                                                      .key;
                                                  print(element.toString());
                                                  print(element["firstname"]);
                                                  element["guestId"] = guestkey;
                                                  dbRef
                                                      .child("path")
                                                      .child(key)
                                                      .child("guestlist")
                                                      .child(guestkey)
                                                      .set(element);
                                                });
                                                setState(() {
                                                  _eventName.clear();
                                                  vv.clear();
                                                });
                                                Navigator.pop(context);
                                              });
                                            }
                                          }
                                          // Navigator.of(context).pop();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(3.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                ),
              ),
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
                          "Events",
                          color: model.lightAppTheme
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
                    child: FirebaseAnimatedList(
                        query: _ref,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          Map<dynamic, dynamic> eventDetails = snapshot.value;
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio:
                                widget.isGuest || widget.isScan ? 0 : 0.2,
                            secondaryActions: [
                              IconSlideAction(
                                  // caption: "Delete",
                                  foregroundColor: amTheme.red,
                                  color: model.lightAppTheme
                                      ? amTheme.background
                                      : pmTheme.background,
                                  icon: Icons.delete,
                                  onTap: () {
                                    dbRef
                                        .child("path")
                                        .child(snapshot.key)
                                        .remove();
                                  })
                            ],
                            child: InkResponse(
                              onTap: () {
                                widget.isScan
                                    ? scanQR(snapshot.key, context)
                                    : widget.isGuest
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  GuestsListPage(
                                                eventkey: snapshot.key,
                                                eventName:
                                                    eventDetails["eventname"],
                                                guests:
                                                    eventDetails["guestlist"],
                                              ),
                                            ),
                                          )
                                        : null;
                              },
                              // onLongPress: () {
                              //   showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           backgroundColor: model.lightAppTheme
                              //               ? amTheme.background
                              //               : pmTheme.background,
                              //           elevation: 2,
                              //           content: Stack(
                              //             clipBehavior: Clip.hardEdge,
                              //             // overflow: Overflow.visible,
                              //             children: <Widget>[
                              //               Positioned(
                              //                 right: -40.0,
                              //                 top: -40.0,
                              //                 child: InkResponse(
                              //                   onTap: () {
                              //                     Navigator.of(context).pop();
                              //                   },
                              //                   child: CircleAvatar(
                              //                     child: Icon(Icons.close),
                              //                     backgroundColor:
                              //                         amTheme.green,
                              //                   ),
                              //                 ),
                              //               ),
                              //               Form(
                              //                 key: _formKey,
                              //                 child: Column(
                              //                   mainAxisSize: MainAxisSize.min,
                              //                   children: <Widget>[
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               8.0),
                              //                       child: CustomOutlineButton(
                              //                         lightmode:
                              //                             model.lightAppTheme,
                              //                         title:
                              //                             "Upload Guest List",
                              //                         txtColor: model
                              //                                 .lightAppTheme
                              //                             ? amTheme.placeholder
                              //                             : pmTheme.titleActive,
                              //                         textIsBold: false,
                              //                         onPress: () {
                              //                           loadCsvFromStorage();
                              //                         },
                              //                       ),
                              //                     ),
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               8.0),
                              //                       child: Styles.regular(
                              //                           "Upload .csv file. The file should have header set to \'firstname\' and \'lastname\'",
                              //                           color: amTheme.fade),
                              //                     ),
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               8.0),
                              //                       child: ElevatedButton(
                              //                         child: Text("Update"),
                              //                         onPressed: () {
                              //                           vv.forEach((element) {
                              //                             String guestkey = dbRef
                              //                                 .child("path")
                              //                                 .child(
                              //                                     "guestlist")
                              //                                 .push()
                              //                                 .key;
                              //                             print(element
                              //                                 .toString());
                              //                             print(element[
                              //                                 "firstname"]);
                              //                             element["guestId"] =
                              //                                 guestkey;
                              //                             dbRef
                              //                                 .child("path")
                              //                                 .child(
                              //                                     snapshot.key)
                              //                                 .child(
                              //                                     "guestlist")
                              //                                 .child(guestkey)
                              //                                 .update(element)
                              //                                 .then((value) {
                              //                               setState(() {
                              //                                 _eventName
                              //                                     .clear();
                              //                                 vv.clear();
                              //                               });
                              //                               Navigator.pop(
                              //                                   context);
                              //                             });
                              //                           });
                              //                         },
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         );
                              //       });
                              // },
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
                                      color: model.lightAppTheme
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Styles.semiBold(
                                        eventDetails["eventname"],
                                        fontSize: 18.sp,
                                        color: model.lightAppTheme
                                            ? amTheme.titleActive
                                            : pmTheme.titleActive,
                                        lines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      VSpace(2.sp),
                                      Styles.regular(
                                          eventDetails["createddate"],
                                          color: model.lightAppTheme
                                              ? amTheme.titleActive
                                              : pmTheme.line,
                                          fontSize: 12.sp)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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
