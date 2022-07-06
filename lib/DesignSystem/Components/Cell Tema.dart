import 'package:flutter/material.dart';

class CellTema extends StatefulWidget {

  String tema;
  String topo;
  bool isSelect;
  CellTema(this.tema, this.topo, this.isSelect);

  @override
  _CellTemaState createState() => _CellTemaState();
}

class _CellTemaState extends State<CellTema> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (widget.isSelect){
      return Container(
        width: width*0.278,
        height: width*0.278,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueAccent, width: 3)
        ),
        child: Stack(
          children: [
            Container(
              width: width*0.9,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.tema),
                ),
              ),
            ),
            Container(
              width: width*0.9,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.topo),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: width*0.278,
        height: width*0.278,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Stack(
          children: [
            Container(
              width: width*0.9,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.tema),
                ),
              ),
            ),
            Container(
              width: width*0.9,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.topo),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}