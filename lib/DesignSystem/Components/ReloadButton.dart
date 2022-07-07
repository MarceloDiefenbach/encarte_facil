import 'package:encarte_facil_2/HomeNormal/Home.dart';
import 'package:flutter/material.dart';

import '../../Logic/controller.dart';
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
    );
  }
}