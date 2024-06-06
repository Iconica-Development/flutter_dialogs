// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_dialogs/src/bottom_alert_dialog_config.dart";

class BottomAlertDialogAction extends StatelessWidget {
  const BottomAlertDialogAction({
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.tertiary,
    super.key,
  });
  final String text;
  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var config = BottomAlertDialogConfig.of(context);
    var buttonBuilder = config.buttonBuilder;
    var translatedText = text;
    if (text == "shell.alertdialog.button.yes") {
      translatedText = config.yesText;
    } else if (text == "shell.alertdialog.button.no") {
      translatedText = config.noText;
    }
    return buttonBuilder.call(
      context,
      text: translatedText,
      onPressed: onPressed,
      buttonType: buttonType,
    );
  }
}

class BottomAlertDialog extends StatelessWidget {
  factory BottomAlertDialog.custom({
    required Widget body,
    required List<Widget> buttons,
    List<BottomAlertDialogAction>? actions,
    bool? closeButton,
  }) =>
      BottomAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        actions: actions,
        body: (_) => body,
      );

  factory BottomAlertDialog.singleButtonIcon({
    required Widget title,
    required Widget body,
    required Widget icon,
    required String buttonText,
    required VoidCallback onPressed,
    ButtonType buttonType = ButtonType.tertiary,
    bool? closeButton,
  }) =>
      BottomAlertDialog.icon(
        closeButton: closeButton,
        title: title,
        icon: icon,
        body: body,
        buttons: [
          BottomAlertDialogAction(
            text: buttonText,
            buttonType: buttonType,
            onPressed: onPressed,
          ),
        ],
      );

  factory BottomAlertDialog.yesOrNoIcon({
    required Widget title,
    required Widget body,
    required Widget icon,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
  }) =>
      BottomAlertDialog.icon(
        closeButton: closeButton,
        title: title,
        body: body,
        icon: icon,
        buttons: _getYesNoDialogButtons(focusYes, otherSecondary, onYes, onNo),
      );

  factory BottomAlertDialog.yesOrNo({
    required Widget title,
    required Widget body,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
  }) =>
      BottomAlertDialog.multiButton(
        closeButton: closeButton,
        title: title,
        body: body,
        buttons: const [],
        actions: _getYesNoDialogButtons(focusYes, otherSecondary, onYes, onNo),
      );

  factory BottomAlertDialog.icon({
    required Widget title,
    required Widget icon,
    required Widget body,
    required List<Widget> buttons,
    List<BottomAlertDialogAction>? actions,
    bool? closeButton,
  }) =>
      BottomAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        actions: actions,
        body: (context) => Column(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: title,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: body,
            ),
          ],
        ),
      );

  factory BottomAlertDialog.multiButton({
    required Widget title,
    required Widget body,
    required List<BottomAlertDialogAction> buttons,
    List<BottomAlertDialogAction>? actions,
    bool? closeButton,
  }) =>
      BottomAlertDialog._(
        closeButton: closeButton,
        buttons: buttons,
        actions: actions,
        body: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: title,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: body,
            ),
          ],
        ),
      );
  factory BottomAlertDialog.singleButton({
    required Widget title,
    required Widget body,
    required String buttonText,
    required VoidCallback onPressed,
    ButtonType buttonType = ButtonType.tertiary,
    bool? closeButton,
  }) =>
      BottomAlertDialog.multiButton(
        closeButton: closeButton,
        title: title,
        body: body,
        buttons: [
          BottomAlertDialogAction(
            text: buttonText,
            onPressed: onPressed,
            buttonType: buttonType,
          ),
        ],
      );
  const BottomAlertDialog._({
    required this.buttons,
    required this.body,
    this.actions,
    this.closeButton = false,
  });
  final List<Widget> buttons;
  final WidgetBuilder body;
  final bool? closeButton;
  final List<BottomAlertDialogAction>? actions;

  static List<BottomAlertDialogAction> _getYesNoDialogButtons(
    bool focusYes,
    bool otherSecondary,
    VoidCallback onYes,
    VoidCallback onNo,
  ) =>
      <BottomAlertDialogAction>[
        if (focusYes) ...[
          BottomAlertDialogAction(
            text: "shell.alertdialog.button.no",
            buttonType:
                otherSecondary ? ButtonType.secondary : ButtonType.tertiary,
            onPressed: onNo,
          ),
        ],
        BottomAlertDialogAction(
          text: "shell.alertdialog.button.yes",
          buttonType: focusYes
              ? ButtonType.primary
              : otherSecondary
                  ? ButtonType.secondary
                  : ButtonType.tertiary,
          onPressed: onYes,
        ),
        if (!focusYes) ...[
          BottomAlertDialogAction(
            text: "shell.alertdialog.button.no",
            buttonType: ButtonType.primary,
            onPressed: onNo,
          ),
        ],
      ];

  @override
  Widget build(BuildContext context) {
    var config = BottomAlertDialogConfig.of(context);

    return Column(
      children: [
        const Spacer(),
        AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor:
              config.backgroundColor ?? Theme.of(context).cardColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        body.call(context),
                        Padding(
                          padding: EdgeInsets.only(
                            top: buttons.isNotEmpty ? 40 : 0,
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: (actions == null) ? buttons : actions!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (closeButton ?? false) ...[
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: config.closeButtonBuilder.call(
                        context,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
