import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/src/popup.dart';
import 'package:flutter_dialogs/src/popup_data.dart';
import 'package:flutter_dialogs/src/popup_service.dart';

class PopUpParent extends StatefulWidget {
  const PopUpParent({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<PopUpParent> createState() => PopUpParentState();
}

class PopUpParentState extends State<PopUpParent> {
  PopUpData? _popUp;
  bool _showPopUp = false;
  int _popUpId = 0;

  final Queue<PopUpData> _popUpQueue = Queue();

  void displayPopUp(PopUpData popUp) {
    if (_showPopUp == true) {
      _popUpQueue.add(popUp);
      return;
    }
    var id = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _popUp = popUp;
      _showPopUp = true;
      _popUpId = id;
    });
    Future.delayed(popUp.duration, () {
      _closePopUp(id);
    });
  }

  void _closePopUp(int id) {
    if (mounted && _popUpId == id) {
      setState(() {
        _showPopUp = false;
      });
      if (_popUpQueue.isNotEmpty) {
        var popUp = _popUpQueue.removeFirst();
        displayPopUp(popUp);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      PopUpService.instance.currentState = this;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          alignment: Alignment.bottomCenter,
          child: AnimatedCrossFade(
            firstChild: SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            secondChild: _popUp?.custom ??
                PopUp(
                  popUpData: _popUp ?? PopUpData(const Duration(seconds: 3)),
                  onTap: () {
                    _closePopUp(_popUpId);
                  },
                ),
            crossFadeState: _showPopUp
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ),
      ],
    );
  }
}
