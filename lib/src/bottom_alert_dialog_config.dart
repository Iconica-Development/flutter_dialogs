// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  tertiary,
}

typedef ButtonBuilder = Widget Function(
  BuildContext context, {
  required String text,
  required void Function() onPressed,
  ButtonType buttonType,
});

typedef CloseButtonBuilder = Widget Function(
  BuildContext context, {
  required void Function() onPressed,
});

class BottomAlertDialogConfig extends InheritedWidget {
  const BottomAlertDialogConfig({
    required super.child,
    ButtonBuilder? buttonBuilder,
    CloseButtonBuilder? closeButtonBuilder,
    this.yesText = 'Yes',
    this.noText = 'No',
    this.backgroundColor,
    super.key,
  })  : _buttonBuilder = buttonBuilder,
        _closeButtonBuilder = closeButtonBuilder;

  final ButtonBuilder? _buttonBuilder;
  final CloseButtonBuilder? _closeButtonBuilder;
  final String yesText;
  final String noText;
  final Color? backgroundColor;

  ButtonBuilder get buttonBuilder =>
      _buttonBuilder ??
      (
        context, {
        required onPressed,
        required text,
        buttonType = ButtonType.tertiary,
      }) {
        var theme = Theme.of(context);
        switch (buttonType) {
          case ButtonType.primary:
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(theme.colorScheme.primary),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(text),
            );
          case ButtonType.secondary:
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(text),
            );
          case ButtonType.tertiary:
            return ElevatedButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(text),
            );
        }
      };

  CloseButtonBuilder get closeButtonBuilder =>
      _closeButtonBuilder ??
      (context, {required onPressed}) {
        return IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.close,
            size: 25,
            color: Colors.black,
          ),
        );
      };

  static BottomAlertDialogConfig of(BuildContext context) {
    var result =
        context.dependOnInheritedWidgetOfExactType<BottomAlertDialogConfig>();
    assert(result != null, 'No BottomAlertDialogConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(BottomAlertDialogConfig oldWidget) =>
      buttonBuilder != oldWidget.buttonBuilder ||
      closeButtonBuilder != oldWidget.closeButtonBuilder;
}
