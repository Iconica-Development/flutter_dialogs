// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/src/popup_data.dart';
import 'package:flutter_dialogs/src/popup_parent.dart';

class PopUpService {
  static PopUpService? _instance;
  static PopUpService get instance => _instance ??= PopUpService();

  late PopUpParentState currentState;

  void showIconText(
    String text, {
    Duration duration = const Duration(seconds: 3),
    IconData icon = Icons.info_outline,
    Color? backgroundColor,
    Color? textColor,
  }) {
    currentState.displayPopUp(PopUpData(
      duration,
      text: text,
      icon: icon,
      backgroundColor: backgroundColor,
      textColor: textColor,
    ));
  }

  void showCustom(
    Widget custom, {
    Duration duration = const Duration(seconds: 3),
  }) {
    currentState.displayPopUp(PopUpData(
      duration,
      custom: custom,
    ));
  }
}
