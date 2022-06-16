import 'package:encarte_facil_2/Functions.dart';
import 'package:flutter/material.dart';
import 'package:encarte_facil_2/Components/Button.dart';


class CellEncarte extends StatefulWidget {

  String title;
  int indice;
  List listaEncartes;

  CellEncarte(this.title, this.indice, this.listaEncartes);

  @override
  _CellEncarteState createState() => _CellEncarteState();
}

class _CellEncarteState extends State<CellEncarte> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width*0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ButtonWidget("Abrir encarte")
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete,
                  color: Colors.black, size: 20,),
                onPressed: () {
                  deletarEncarte(widget.title, widget.indice, widget.listaEncartes);
                  setState(() {
                    // _lerArquivo();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}