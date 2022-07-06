import 'package:flutter/material.dart';

import '../DesignTokens.dart';

class ButtonSecondaryWidget extends StatefulWidget {

  String title;
  ButtonSecondaryWidget(this.title);

  @override
  _ButtonSecondaryWidgetState createState() => _ButtonSecondaryWidgetState();
}

class _ButtonSecondaryWidgetState extends State<ButtonSecondaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium(),
          color: colorBrandPrimary(),
            border: Border.all(color: colorBrandPrimary())
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.title}', style: TextStyle(color: Colors.white)),
          ],
        )
    );
  }
}