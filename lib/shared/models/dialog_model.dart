import 'package:flutter/cupertino.dart';

class AlertData {
  AlertData({
    @required this.message,
    this.actionText,
    this.title,
    this.btnColor,
  });

  String message;
  String actionText;
  String title;
  Color btnColor;
}

class BottomSheetItem {
  BottomSheetItem({
    this.name,
    this.icon,
    this.id,
  });

  String id;
  String name;
  IconData icon;
}

class ToastData {
  ToastData({
    @required this.context,
    @required this.msg,
    this.actionText,
  });

  String msg;
  String actionText;
  BuildContext context;
}

class ConfirmDialogData {
  ConfirmDialogData({
    @required this.message,
    this.yesText,
    this.noText,
    this.title,
  });

  String message;
  String yesText;
  String noText;
  String title;
}

class PromptDialogData {
  PromptDialogData({
    @required this.message,
    this.actionBtn,
    this.title,
    this.placeholder,
    this.initialValue,
  });

  String message;
  String actionBtn;
  String title;
  String initialValue;
  String placeholder;
}

class ModalConfig {
  ModalConfig({
    @required this.content,
    @required this.context,
    this.resolver,
    this.dismissible = true,
  });

  Widget content;
  Function(dynamic res) resolver;
  bool dismissible;
  BuildContext context;
}
