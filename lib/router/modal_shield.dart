import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/dims.dart';
import 'package:open_art/shared/utils/themes/theme.dart';

class ModalShield extends StatefulWidget {
  @override
  _ModalShieldState createState() {
    return _ModalShieldState();
  }
}

class _ModalShieldState extends State<ModalShield> {
  int _modalCount = 0;
  StreamSubscription<int> _modal$;

  @override
  void initState() {
    // _modal$ = si.dialogService.modal$.listen((int value) {
    //   setState(() {
    //     _modalCount = value;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
        top: Dims.dx(60),
      ),
      duration: const Duration(
        milliseconds: 100,
      ),
      color: pmTheme.black.withOpacity(0.5),
      width: Dims.deviceSize.width,
      height: _modalCount > 0 ? Dims.dx(16) : 0,
    );
  }

  @override
  void dispose() {
    _modal$.cancel();

    super.dispose();
  }
}
