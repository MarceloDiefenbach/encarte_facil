import 'dart:convert';
import 'package:encarte_facil_2/EditarEncarteComTema.dart';
import 'package:encarte_facil_2/Encartes.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado1Produto.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado2Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado3Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado4Produtos.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

import 'Components/Cell Tema.dart';
import 'ListaProdutos.dart';
import 'Model/Produto.dart';
import 'SelecionarTema.dart';

class ProdutosEncarte extends StatefulWidget {
  List listaEncartes;
  List<Produto> listaTodosProdutos;
  int posicaoNaList;

  ProdutosEncarte(this.listaEncartes, this.listaTodosProdutos, this.posicaoNaList);

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
                      fontWeight: FontWeight.bold, color: Colors.black)),
              leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                onPressed: () {
                  _salvarArquivo();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Encartes()),
                  );
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarEncarteComTema(widget.listaEncartes, widget.posicaoNaList)
                      ),
                    );
                  },
                  child: Container(
                      height: 30,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Editar encarte',
                              style: TextStyle(color: Colors.blueAccent)),
                        ],
                      )
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAnalytics.instance
                        .logEvent(name: "adicionar_produto_lista");
                    if (_listaProdutos.length == 4) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaProdutos(
                                widget.listaTodosProdutos,
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
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Adicionar',
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                  ),
                ),
              ],
              elevation: 0,
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: _listaProdutos.length+2,
                      itemBuilder: (context, indice) {
                        _textController.add(new TextEditingController());
                        if (indice == _listaProdutos.length+1) {
                          return Container(
                            height: 100,
                            color: Colors.grey[300],
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
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                              Text(
                                'Validade: ${widget.listaEncartes[widget.posicaoNaList]["validade"]}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                              Row(
                                children: [
                                  Text(
                                    'Tema:',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 16, 0)),
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
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                              color: Colors.black,
                                              size: 20,
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
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(20, 0,
                                                  0, 0),
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
                                    color: Colors.blue,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Gerar encarte',
                                          style: TextStyle(
                                              color: Colors.white,
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
                                if (_listaProdutos.length == 1) {
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
