import 'package:flutter/material.dart';

import '../DesignTokens.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        height: 60,
        width: width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBrandPrimary(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Precisa de outro produto?', style: TextStyle(color: colorNeutralHighPure(), fontSize: 20)),
          ],
        )
    );
  }
}