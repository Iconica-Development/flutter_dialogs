// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";

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
