import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/color.dart';

abstract class IToastMessage {
  void showToast(ToastMessageData data);
}

class ToastMessageData {
  final String msg;
  final ToastMessageTime time;
  final Color backgroundColor;
  final ToastMessagePosition position;

  ToastMessageData({
    required this.msg,
    this.time = ToastMessageTime.short,
    this.backgroundColor = CustomColors.deepSpace,
    this.position = ToastMessagePosition.bottom,
  });
}

enum ToastMessageTime {
  /// Show Short toast for 1 sec
  short,

  /// Show Long toast for 5 sec
  long,
}

enum ToastMessagePosition {
  bottom,
}

extension ToastMessagePositionExtension on ToastMessagePosition {
  ToastGravity get toToastGravity {
    switch (this) {
      case ToastMessagePosition.bottom:
        return ToastGravity.BOTTOM;
      default:
        return ToastGravity.BOTTOM;
    }
  }
}

class ToastMessage implements IToastMessage {
  @override
  void showToast(ToastMessageData data) {
    Fluttertoast.showToast(
      msg: data.msg,
      toastLength: Toast.values[data.time.index],
      backgroundColor: data.backgroundColor,
      gravity: data.position.toToastGravity,
    );
  }
}
