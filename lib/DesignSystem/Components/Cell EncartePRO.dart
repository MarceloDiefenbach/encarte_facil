import 'package:encarte_facil_2/Logic/Functions.dart';
import 'package:encarte_facil_2/Premium%20flow/HomePRO.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../DesignSystem/Components/Button.dart';
import '../../Logic/controller.dart';
import '../DesignTokens.dart';

class CellEncarte extends StatefulWidget {

  String title;
  int indice;

  CellEncarte(this.title, this.indice);

  @override
  _CellEncarteState createState() => _CellEncarteState();
}


class _CellEncarteState extends State<CellEncarte> {
  @override
  Widget build(BuildContext context) {

    Controller controller = Provider.of<Controller>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 0,
      color: colorNeutralHighPure(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusMedium(),
      ),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(spacingGlobalMargin()),
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
                          padding: EdgeInsets.fromLTRB(0, 0, 0, spacingNano(height)),
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
                  // controller.pegaAirtable();
                  deletarEncarte(widget.title, widget.indice, controller.listaEncartes);
                  setState(() {
                    FirebaseAnalytics.instance.logEvent(
                        name: "delete_encarte",
                        parameters: {
                          "nome_encarte": widget.title,
                        }
                    );
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => HomeWidgetPRO(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
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