// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dialogs demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Dialogs demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopUpParent(
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
                  PopUpService.instance.showIconText('test');
                },
                child: const Text('Show popup'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  DialogService.instance.showDialog(
                    context: context,
                    builder: (_) => IconicaAlertDialog.multiButton(
                      closeButton: true,
                      title: 'title',
                      body: 'body',
                      iconButton: (context, onPressed) => IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.dangerous),
                      ),
                      primaryButton: (onPressed, child, context) =>
                          ElevatedButton(
                        onPressed: () {
                          debugPrint('custom button');
                          onPressed.call();
                        },
                        child: child,
                      ),
                      buttons: [
                        AlertDialogAction(
                          primary: true,
                          text: 'test',
                          onPressed: () {
                            debugPrint('test');
                          },
                        ),
                        AlertDialogAction(
                          secondary: true,
                          text: 'test',
                          onPressed: () {
                            debugPrint('test');
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show dialog'),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
