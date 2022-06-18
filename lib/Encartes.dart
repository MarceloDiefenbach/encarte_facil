import 'dart:convert';
import 'package:encarte_facil_2/Components/Cell%20Encarte.dart';
import 'package:encarte_facil_2/Components/ReloadButton.dart';
import 'package:encarte_facil_2/NewEncarteComTema.dart';
import 'package:encarte_facil_2/SugestionForm.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'Logic/Functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Model/Produto.dart';
import 'ProdutosEncarte.dart';

class Encartes extends StatefulWidget {
  const Encartes({key}) : super(key: key);

  @override
  _EncartesState createState() => _EncartesState();
}

class _EncartesState extends State<Encartes> {
  List _listaEncartes = [];
  List<Produto> listaTodosEncartes = [];

  _lerArquivo() async {
    listaTodosEncartes = await AirtableGet() as List<Produto>;

    try {
      final arquivo = await getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  TextEditingController _textController;
  TextEditingController _textControllerValidade;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController(text: '');
    _textControllerValidade = TextEditingController(text: '');

    _lerArquivo().then((dados) {
      setState(() {
        _listaEncartes = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: height,
          width: width,
          color: Colors.grey[300],
          child: Stack(
            children: [
              FutureBuilder(
                  future: _lerArquivo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.fromLTRB(20, 60, 20, 200),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _listaEncartes.length + 1,
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
                                      ReloadButtonWidget()
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                                ],
                              );
                            } else {
                              var encarte = _listaEncartes[indice - 1];
                              return GestureDetector(
                                child: CellEncarte(encarte["nomeEncarte"],
                                    indice - 1, _listaEncartes),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) => ProdutosEncarte(_listaEncartes, listaTodosEncartes, indice - 1, "encartes"),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                              );
                            }
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                              padding: EdgeInsets.fromLTRB(20, 60, 20, 200),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _listaEncartes.length + 1,
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
                                        ],
                                      ),
                                      CupertinoActivityIndicator(
                                        animating: true,
                                        radius: 15,
                                      )
                                    ],
                                  );
                                }
                              }),
                        ],
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
