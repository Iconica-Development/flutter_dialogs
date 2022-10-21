import 'package:flutter/material.dart';

class PopUpData {
  PopUpData(
    this.duration, {
    this.icon,
    this.text,
    this.custom,
    this.backgroundColor,
    this.textColor,
  });

  IconData? icon;
  String? text;
  Duration duration;
  Widget? custom;

  Color? backgroundColor;
  Color? textColor;
}
