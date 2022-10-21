import 'package:flutter/material.dart';

class AlertDialogAction {
  final String text;
  final bool primary;
  final bool secondary;
  final VoidCallback onPressed;

  AlertDialogAction({
    required this.text,
    this.primary = false,
    this.secondary = false,
    required this.onPressed,
  }) : assert(
          !(primary && secondary),
          "AlertDialogAction can't be primary and secondary at the same time",
        );
}

typedef ButtonCallback = Widget Function(
  void Function() onPressed,
  Widget child,
  BuildContext context,
);

typedef IconButtonCallback = Widget Function(
  BuildContext context,
  void Function() onPressed,
);

class IconicaAlertDialog extends StatelessWidget {
  final List<AlertDialogAction> buttons;
  final WidgetBuilder body;
  final bool? closeButton;
  final ButtonCallback? primaryButton;
  final ButtonCallback? secondaryButton;
  final IconButtonCallback? iconButton;

  const IconicaAlertDialog._({
    required this.buttons,
    required this.body,
    this.closeButton = false,
    this.primaryButton,
    this.secondaryButton,
    this.iconButton,
  });

  factory IconicaAlertDialog.singleButton({
    required String title,
    required String body,
    required String buttonText,
    required VoidCallback onPressed,
    bool primary = false,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog.multiButton(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      title: title,
      body: body,
      buttons: [
        AlertDialogAction(
          text: buttonText,
          onPressed: onPressed,
          primary: primary,
        ),
      ],
    );
  }

  factory IconicaAlertDialog.multiButton({
    required String title,
    required String body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog._(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      buttons: buttons,
      body: (context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              body,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  factory IconicaAlertDialog.icon({
    required String title,
    required Widget icon,
    required String body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog._(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      buttons: buttons,
      body: (context) => Column(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              body,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  factory IconicaAlertDialog.yesOrNo({
    required String title,
    required String body,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog.multiButton(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      title: title,
      body: body,
      buttons: _getYesNoDialogButtons(focusYes, otherSecondary, onYes, onNo),
    );
  }

  factory IconicaAlertDialog.yesOrNoIcon({
    required String title,
    required String body,
    required Widget icon,
    required VoidCallback onYes,
    required VoidCallback onNo,
    bool focusYes = true,
    bool otherSecondary = false,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog.icon(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      title: title,
      body: body,
      icon: icon,
      buttons: _getYesNoDialogButtons(focusYes, otherSecondary, onYes, onNo),
    );
  }

  factory IconicaAlertDialog.singleButtonIcon({
    required String title,
    required String body,
    required Widget icon,
    required String buttonText,
    required VoidCallback onPressed,
    bool primary = false,
    bool secondary = false,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog.icon(
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
      closeButton: closeButton,
      title: title,
      icon: icon,
      body: body,
      buttons: [
        AlertDialogAction(
          text: buttonText,
          primary: primary,
          secondary: secondary,
          onPressed: onPressed,
        ),
      ],
    );
  }

  factory IconicaAlertDialog.custom({
    required Widget body,
    required List<AlertDialogAction> buttons,
    bool? closeButton,
    ButtonCallback? primaryButton,
    ButtonCallback? secondaryButton,
    IconButtonCallback? iconButton,
  }) {
    return IconicaAlertDialog._(
      closeButton: closeButton,
      buttons: buttons,
      body: (_) => body,
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      iconButton: iconButton,
    );
  }

  static List<AlertDialogAction> _getYesNoDialogButtons(
    bool focusYes,
    bool otherSecondary,
    VoidCallback onYes,
    VoidCallback onNo, {
    String no = 'No',
    String yes = 'Yes',
  }) {
    return <AlertDialogAction>[
      if (focusYes) ...[
        AlertDialogAction(
          text: no,
          primary: !focusYes,
          secondary: !focusYes && otherSecondary,
          onPressed: onNo,
        ),
      ],
      AlertDialogAction(
        text: yes,
        primary: focusYes,
        secondary: !focusYes && otherSecondary,
        onPressed: onYes,
      ),
      if (!focusYes) ...[
        AlertDialogAction(
          text: no,
          primary: !focusYes,
          secondary: focusYes && otherSecondary,
          onPressed: onNo,
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).cardColor,
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
                                right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: buttons.map(
                                (e) {
                                  if (e.primary) {
                                    return primaryButton?.call(
                                          e.onPressed,
                                          Text(e.text),
                                          context,
                                        ) ??
                                        ElevatedButton(
                                          onPressed: e.onPressed,
                                          child: Text(e.text),
                                        );
                                  } else {
                                    return secondaryButton?.call(
                                          e.onPressed,
                                          Text(e.text),
                                          context,
                                        ) ??
                                        TextButton(
                                          onPressed: e.onPressed,
                                          child: Text(e.text),
                                        );
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (closeButton ?? false) ...[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: iconButton?.call(context, () {
                              Navigator.pop(context);
                            }) ??
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                      ),
                    ),
                  ],
                ],
              )),
        )
      ],
    );
  }
}
