import 'dart:convert';
import 'package:encarte_facil_2/Components/Cell%20Encarte.dart';
import 'package:encarte_facil_2/Components/ReloadButton.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'Logic/Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Logic/controller.dart';
import 'Model/Produto.dart';
import 'ProdutosEncarte.dart';


class Encartes extends StatefulWidget {
  const Encartes({key}) : super(key: key);

  @override
  _EncartesState createState() => _EncartesState();
}

class _EncartesState extends State<Encartes> {
  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];

  Controller controller;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    controller = Provider.of<Controller>(context);
    controller.pegaAirtable();
    controller.pegaProdutos();
  }

  @override
  void didUpdateWidget(covariant Encartes oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    controller.pegaAirtable();
    listaTodosProdutos = controller.listaProdutos;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: SafeArea(
          child: Container(
              height: height,
              width: width,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Observer(builder: (_){
                    return ListView.builder(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 200),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.listaEncartes.length + 1,
                        itemBuilder: (context, indice) {
                          if (indice == 0) {
                            return Column(
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.55,
                                      child: Text(
                                        "Lista de encartes",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            height: 0.9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 24),
                                      ),
                                    ),
                                    Spacer(),
                                    ReloadButtonWidget(controller)
                                  ],
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                              ],
                            );
                          } else {
                            var encarte = controller.listaEncartes[indice - 1];
                            return GestureDetector(
                              child: CellEncarte(encarte["nomeEncarte"],
                                  indice - 1, controller.listaEncartes),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) => ProdutosEncarte(controller.listaEncartes, listaTodosProdutos, indice - 1, "encartes"),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            );
                          }
                        });
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
