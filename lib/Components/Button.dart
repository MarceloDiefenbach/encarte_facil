import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Novo', style: TextStyle(color: Colors.white)),
          ],
        )
    );
  }
}