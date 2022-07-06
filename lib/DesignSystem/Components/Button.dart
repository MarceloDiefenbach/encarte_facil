import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {

  String title;
  ButtonWidget(this.title);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium(),
          color: colorBrandPrimary(),
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