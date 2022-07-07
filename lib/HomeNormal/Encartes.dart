import 'dart:async';
import 'package:encarte_facil_2/DesignSystem/Components/Cell%20Encarte.dart';
import 'package:encarte_facil_2/DesignSystem/Components/ReloadButton.dart';
import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:encarte_facil_2/HomeNormal/Home.dart';
import 'package:encarte_facil_2/HomeNormal/ProdutosEncarte.dart';
import 'package:encarte_facil_2/Logic/controller.dart';
import 'package:encarte_facil_2/Model/Produto.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Encartes extends StatefulWidget {
  const Encartes({key}) : super(key: key);

  @override
  _EncartesState createState() => _EncartesState();
}

class _EncartesState extends State<Encartes> {
  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];
  bool stoped = true;
  Controller controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = Provider.of<Controller>(context);

  }

  @override
  void didUpdateWidget(covariant Encartes oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // controller.pegaAirtable();
    if (stoped) {
      Timer.periodic(Duration(milliseconds: 500), (timer) {
        listaTodosProdutos = controller.listaProdutos;
        // print(listaTodosProdutos);
        if (listaTodosProdutos.isNotEmpty){
          stoped = false;
        }
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {

    controller.pegaAirtable();
    controller.pegaProdutos();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: colorNeutralHighDark(),
            child: SafeArea(
              child: Container(
                  height: height,
                  width: width,
                  color: colorNeutralHighDark(),
                  child: Stack(
                    children: [
                      Observer(builder: (_){
                        return ListView.builder(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 200),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.listaEncartes.length + 1,
                            itemBuilder: (context, indice) {
                              if (controller.listaEncartes.length == 0){
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
                                        GestureDetector(
                                          child: ReloadButtonWidget(controller),
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, animation1, animation2) => HomeWidget(),
                                                transitionDuration: Duration.zero,
                                                reverseTransitionDuration: Duration.zero,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 150, 20, 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width: width*0.6,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                                      child: Text(
                                                        "Você ainda não criou \num encarte",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                                      child: Text(
                                                        "Clique em criar encarte\ne comece a divulgar \nsuas ofertas",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 20),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    CupertinoActivityIndicator(
                                                      color: Colors.black,
                                                      animating: true,
                                                      radius: 15,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else if (indice == 0) {
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
                                      indice - 1),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) => ProdutosEncarte(controller.listaEncartes, indice - 1, "encartes"),
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
          // SafeArea(
          //   child: Container(
          //     width: width,
          //     height: 30,
          //     color: colorBrandPrimary(),
          //     child: Center(
          //       child: Text(
          //         "VOCÊ ESTÁ NA VERSÃO GRÁTIS",
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //             height: 0.9,
          //             fontWeight: FontWeight.bold,
          //             color: colorNeutralHighPure(),
          //             fontSize: fontSizeXXS()),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
