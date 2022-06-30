import 'package:flutter/material.dart';

import '../Logic/controller.dart';
import '../Nova Home/Home.dart';

class ReloadButtonWidget extends StatefulWidget {

  Controller controller;

  ReloadButtonWidget(this.controller);

  @override
  _ReloadButtonWidgetState createState() => _ReloadButtonWidgetState();
}

class _ReloadButtonWidgetState extends State<ReloadButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:
      Icon(Icons.refresh_sharp, color: Colors.black),
      onPressed: () {
        // widget.controller.pegaAirtable();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeWidget(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
    );
  }
}