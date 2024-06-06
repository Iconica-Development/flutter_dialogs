// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_dialogs/src/popup_data.dart";

class PopUp extends StatelessWidget {
  const PopUp({
    required this.popUpData,
    this.onTap,
    super.key,
  });

  final void Function()? onTap;
  final PopUpData popUpData;

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: popUpData.textColor ?? Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.571,
        );
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: popUpData.backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                popUpData.icon,
                color: style?.color,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: Text(
                  popUpData.text ?? "",
                  style: style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
