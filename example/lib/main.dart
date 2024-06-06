// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_dialogs/flutter_dialogs.dart";

void main() {
  runApp(const DialogDemoApp());
}

class DialogDemoApp extends StatelessWidget {
  const DialogDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Flutter Dialogs demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DialogDemoPage(title: "Flutter Dialogs demo"),
        builder: (context, child) => BottomAlertDialogConfig(
          child: child ?? const SizedBox.shrink(),
        ),
      );
}

class DialogDemoPage extends StatefulWidget {
  const DialogDemoPage({required this.title, super.key});

  final String title;

  @override
  State<DialogDemoPage> createState() => _DialogDemoPageState();
}

class _DialogDemoPageState extends State<DialogDemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopUpParent(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                  onPressed: () {
                    PopUpService.instance.showIconText("test");
                  },
                  child: const Text("Show popup"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async => DialogService.instance.showDialog(
                    context: context,
                    builder: (_) => IconicaAlertDialog.multiButton(
                      closeButton: true,
                      title: "title",
                      body: "body",
                      iconButton: (context, onPressed) => IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.dangerous),
                      ),
                      primaryButton: (onPressed, child, context) =>
                          ElevatedButton(
                        onPressed: () {
                          debugPrint("custom button");
                          onPressed.call();
                        },
                        child: child,
                      ),
                      buttons: [
                        AlertDialogAction(
                          primary: true,
                          text: "test",
                          onPressed: () {
                            debugPrint("test");
                          },
                        ),
                        AlertDialogAction(
                          secondary: true,
                          text: "test",
                          onPressed: () {
                            debugPrint("test");
                          },
                        ),
                      ],
                    ),
                  ),
                  child: const Text("Show dialog"),
                ),
                const Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.singleButton(
                      closeButton: true,
                      title: const Text("Confirm"),
                      body: const Text(
                        "Click the button to dismiss",
                      ),
                      buttonText: "Ok",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  child: const Text("BottomAlertDialog.singleButton"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.multiButton(
                      title: const Text("Favorite Color"),
                      body: const Text(
                        "Choose your favorite color",
                      ),
                      buttons: [
                        BottomAlertDialogAction(
                          text: "Red",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.primary,
                        ),
                        BottomAlertDialogAction(
                          text: "Green",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.primary,
                        ),
                        BottomAlertDialogAction(
                          text: "Blue",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.primary,
                        ),
                        BottomAlertDialogAction(
                          text: "Yellow",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.primary,
                        ),
                      ],
                    ),
                  ),
                  child: const Text("BottomAlertDialog.multiButton"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.singleButtonIcon(
                      closeButton: true,
                      title: const Text("Confirm"),
                      body: const Text(
                        "Click the button to dismiss",
                      ),
                      icon: const Icon(
                        Icons.info,
                        color: Colors.blue,
                      ),
                      buttonText: "Ok",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  child: const Text("BottomAlertDialog.singleButtonIcon"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.icon(
                      closeButton: true,
                      title: const Text("Favorite Car"),
                      body: const Text(
                        "Choose your favorite car brand",
                      ),
                      icon: const Icon(
                        Icons.car_rental_sharp,
                      ),
                      buttons: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("BMW"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Opel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Mercedes"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Kia"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Skoda"),
                        ),
                      ],
                    ),
                  ),
                  child: const Text("BottomAlertDialog.icon"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.yesOrNo(
                      title: const Text("Question"),
                      body: const Text(
                        "Do you really wanna do this?",
                      ),
                      onYes: () {
                        Navigator.of(context).pop();
                      },
                      onNo: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  child: const Text("BottomAlertDialog.yesOrNo"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.yesOrNoIcon(
                      title: const Text("Question"),
                      body: const Text(
                        "Do you really wanna do this?",
                      ),
                      onYes: () {
                        Navigator.of(context).pop();
                      },
                      onNo: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.question_mark_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  child: const Text("BottomAlertDialog.yesOrNoIcon"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.custom(
                      closeButton: true,
                      body: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            const Text("Custom Dialog with PageView"),
                            Flexible(
                              child: PageView(
                                children: const [
                                  Center(child: Text("Page 1")),
                                  Center(child: Text("Page 2")),
                                  Center(child: Text("Page 3")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      buttons: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  ),
                  child: const Text("BottomAlertDialog.custom"),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text("Multiple chained dialogs"),
                  onPressed: () async => showDialog(
                    context: context,
                    builder: (context) => BottomAlertDialog.yesOrNo(
                      closeButton: true,
                      title: const Text("Pokémon"),
                      body: const Text(
                        "Do you want to choose your starter Pokémon?",
                      ),
                      onYes: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => BottomAlertDialog.multiButton(
                            title: const Text("Starter Pokémon"),
                            body: const Text("Choose a starter Pokémon"),
                            buttons: [
                              BottomAlertDialogAction(
                                text: "Turtwig",
                                buttonType: ButtonType.secondary,
                                onPressed: () =>
                                    _showDoneDialog(context, "Turtwig"),
                              ),
                              BottomAlertDialogAction(
                                text: "Chimchar",
                                buttonType: ButtonType.secondary,
                                onPressed: () =>
                                    _showDoneDialog(context, "Chimchar"),
                              ),
                              BottomAlertDialogAction(
                                text: "Piplup",
                                buttonType: ButtonType.secondary,
                                onPressed: () =>
                                    _showDoneDialog(context, "Piplup"),
                              ),
                            ],
                          ),
                        );
                      },
                      onNo: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _showDoneDialog(BuildContext context, String name) async {
    Navigator.pop(context);
    await showDialog(
      context: context,
      builder: (context) => BottomAlertDialog.icon(
        title: const Text("Good choice!"),
        icon: Icon(
          Icons.catching_pokemon,
          color: Color(name.hashCode).withAlpha(255),
        ),
        body: Text("You chose $name to be your starter Pokémon."),
        buttons: const [
          CloseButton(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
