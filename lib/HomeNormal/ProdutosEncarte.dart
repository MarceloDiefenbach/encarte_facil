import 'dart:convert';
import 'package:encarte_facil_2/EditarEncarteComTema.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado1Produto.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado2Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado3Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado4Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado5Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado6Produtos.dart';
import 'package:encarte_facil_2/Nova%20Home/Home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

import 'DesignSystem/Components/Cell Tema.dart';
import 'DesignSystem/DesignTokens.dart';
import 'ListaProdutos.dart';

class ProdutosEncarte extends StatefulWidget {
  List listaEncartes;
  int posicaoNaList;
  String fromTo;

  ProdutosEncarte(this.listaEncartes, this.posicaoNaList, this.fromTo);

  @override
  _ProdutosEncarteState createState() => _ProdutosEncarteState();
}

class _ProdutosEncarteState extends State<ProdutosEncarte> {
  List _listaProdutos = [];

  _ProdutosEncarteState();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/${widget.listaEncartes[widget.posicaoNaList]["nomeEncarte"]}.json");
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();

    String dados = json.encode(_listaProdutos);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaProdutos = json.decode(dados);
      });
    });
  }

  Future<File> _getListaProdutosDoEncarte() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/${widget.listaEncartes[widget.posicaoNaList]["nomeEncarte"]}.json");
  }

  _removerItem(int indice) async {
    var arquivo = await _getListaProdutosDoEncarte();

    _listaProdutos.removeAt(indice);
    _salvarArquivo();
    arquivo.delete();
    _lerArquivo();
    setState((){});
  }

  List<TextEditingController> _textController = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScrollController controller = ScrollController();


    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: Text("",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colorNeutralLowPure())),
              leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios_new_rounded, color: colorNeutralLowPure()),
                onPressed: () {
                  _salvarArquivo();
                  if (widget.fromTo == "newEncarteComTema") {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => HomeWidget(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  } else if (widget.fromTo == "encartes") {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => HomeWidget(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarEncarteComTema(widget.listaEncartes, widget.posicaoNaList, "ProdutosEncarte")
                      ),
                    );
                  },
                  child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorBrandPrimary()),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Editar encarte',
                                style: TextStyle(color: colorBrandPrimary())),
                          ],
                        ),
                      )
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_listaProdutos.length == 6) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title:
                            Text("Número máximo de produtos neste encarte"),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      FirebaseAnalytics.instance
                          .logEvent(name: "adicionar_produto_lista");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaProdutos(
                                widget.listaEncartes[widget.posicaoNaList]["nomeEncarte"]
                            )
                        ),
                      ).then((value) => setState(() {
                        _lerArquivo().then((dados) {
                          setState(() {
                            _listaProdutos = json.decode(dados);
                          });
                        });
                      }));
                    }
                  },
                  child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorBrandPrimary(),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Adicionar',
                                style: TextStyle(color: colorNeutralHighPure())),
                          ],
                        ),
                      )
                  ),
                ),
              ],
              elevation: 0,
              backgroundColor: colorNeutralHighDark(),
              foregroundColor: colorNeutralLowPure(),
            ),
            body: Stack(
              children: [
                Container(
                  color: colorNeutralHighDark(),
                  padding: EdgeInsets.fromLTRB(spacingGlobalMargin(), 0, spacingGlobalMargin(), 0),
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: _listaProdutos.length+2,
                      itemBuilder: (context, indice) {
                        _textController.add(new TextEditingController());
                        if (indice == _listaProdutos.length+1) {
                          return Container(
                            height: 100,
                            color: colorNeutralHighDark(),
                          );
                        }
                        if (indice == 0 ){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ${widget.listaEncartes[widget.posicaoNaList]["nomeEncarte"]}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorNeutralLowPure(),
                                    fontSize: fontSizeSM()),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, spacingNano(height), 0, 0)),
                              Text(
                                'Validade: ${widget.listaEncartes[widget.posicaoNaList]["validade"]}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorNeutralLowPure(),
                                    fontSize: fontSizeSM()),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, spacingNano(height), 0, 0)),
                              Row(
                                children: [
                                  Text(
                                    'Tema:',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorNeutralLowPure(),
                                        fontSize: fontSizeSM()),
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(0, 0, spacingXXXS(height), 0)),
                                  CellTema(widget.listaEncartes[widget.posicaoNaList]["tema"], widget.listaEncartes[widget.posicaoNaList]["topo"], false),
                                ],
                              )
                            ],
                          );
                        } else {
                          var produto = _listaProdutos[indice-1];
                          _textController[indice].text = produto["valor"];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                      child: Text(
                                        'Produto ${indice}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: colorNeutralLowPure(),
                                            fontSize: fontSizeXS()),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: colorNeutralHighPure(),
                                        borderRadius:
                                        BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(20, 8, 0, 0),
                                              child: Text(
                                                produto["nomeProduto"],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: colorNeutralLowPure(),
                                              size: fontSizeSM(),
                                            ),
                                            onPressed: () {
                                              _removerItem(indice-1);
                                              setState(() {
                                                _lerArquivo();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: colorNeutralHighPure(),
                                        borderRadius:
                                        BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                              child: Text(
                                                'Valor do produto:',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                              AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(80, 0, 20, 4),
                                                child: TextField(
                                                    controller: _textController[indice],
                                                    obscureText: false,
                                                    textAlign: TextAlign.end,
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    onChanged: (Stringe) {
                                                      produto["valor"] = _textController[indice].text;
                                                      _salvarArquivo();
                                                      // setState(() {});
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: GestureDetector(
                              child: Container(
                                  width: width * 0.9,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorBrandPrimary(),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Gerar encarte',
                                          style: TextStyle(
                                              color: colorNeutralHighPure(),
                                              fontSize: 18)),
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _lerArquivo().then((dados) {
                                    setState(() {
                                      _listaProdutos = json.decode(dados);
                                      _salvarArquivo();
                                    });
                                  });
                                });
                                if (_listaProdutos.length == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title:
                                        Text("Você ainda não adicionou um produto nesse encarte"),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: Text("Adicionar produtos"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              FirebaseAnalytics.instance
                                                  .logEvent(name: "adicionar_produto_lista");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ListaProdutos(
                                                        widget.listaEncartes[widget.posicaoNaList]["nomeEncarte"]
                                                    )
                                                ),
                                              ).then((value) => setState(() {
                                                _lerArquivo().then((dados) {
                                                  setState(() {
                                                    _listaProdutos = json.decode(dados);
                                                  });
                                                });
                                              }));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (_listaProdutos.length == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado1Produto(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                } else if (_listaProdutos.length == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado2Produtos(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                } else if (_listaProdutos.length == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado3Produtos(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                } else if (_listaProdutos.length == 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado4Produtos(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                } else if (_listaProdutos.length == 5) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado5Produtos(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                } else if (_listaProdutos.length == 6) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EncarteGerado6Produtos(
                                                  _listaProdutos,
                                                  widget.listaEncartes[widget.posicaoNaList]["tema"],
                                                  widget.listaEncartes[widget.posicaoNaList]["topo"],
                                                  widget.listaEncartes[widget.posicaoNaList]["validade"])));
                                }
                                FirebaseAnalytics.instance.logEvent(
                                  name: "gerar_encarte",
                                  parameters: {
                                    "quantidade_itens":
                                        "${_listaProdutos.length.toString()}",
                                  },
                                );
                              },
                            ))
                      ],
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}
