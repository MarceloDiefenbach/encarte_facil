import 'dart:convert';
import 'dart:io';
import 'package:encarte_facil_2/HomeNormal/Encartes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;

import '../DesignSystem/Components/Cell Tema.dart';
import '../Logic/Functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Model/Produto.dart';
import '../Model/Tema.dart';

class EditarEncarteComTema extends StatefulWidget {

  List listaEncartes;
  int posicaoNaLista;
  String fromTo;

  EditarEncarteComTema(this.listaEncartes, this.posicaoNaLista, this.fromTo);

  @override
  _EditarEncarteComTemaState createState() => _EditarEncarteComTemaState();
}

class _EditarEncarteComTemaState extends State<EditarEncarteComTema> {
  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];
  TextEditingController _textController;
  TextEditingController _textControllerValidade;
  List<Tema> temas = [];
  FirebaseAnalytics analyticsEvents = FirebaseAnalytics.instance;
  List<bool> selecionado = [false, false, false];
  String temaSelecionado = "";
  String topoSelecionado = "";

  int dia = 1;
  int mes = 1;
  int ano = 2022;

  _lerArquivo() async {

    // listaTodosProdutos = await AirtableGet() as List<Produto>;

    try {
      final arquivo = await getDiretorioEncartes();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _deixaTudoFalse() {
    for (int i = 0; i < selecionado.length; i++) {
      selecionado[i] = false;
    }
  }

  _pegaTemasAirtable() async {

    http.Response response;
    response = await http.get(
      Uri.parse('https://api.airtable.com/v0/app3yQeCe4U0NEM6H/Table%201'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: "Bearer keySFSIYnvACQhHAa",
      },
    );

    Map<String, dynamic> retorno = json.decode(response.body);
    List records = retorno["records"];
    temas.clear();

    for (int i=0; i<records.length; i++ ) {
      temas.add(Tema(records[i]["fields"]["Nome"], records[i]["fields"]["Fundo"], records[i]["fields"]["Topo"]));
    }
    return temas;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController(text: widget.listaEncartes[widget.posicaoNaLista]["nomeEncarte"]);
    _textControllerValidade = TextEditingController(text: widget.listaEncartes[widget.posicaoNaLista]["validade"]);

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
    String date = "";

    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, height*0.1, 0, 0)),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text("Nome do encarte",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20)
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Container(
                  width: width * 0.9,
                  height: height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    onChanged: (String e) {},
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Digite o nome do encarte',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text("Validade das ofertas",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Container(
                  width: width * 0.9,
                  height: height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: TextField(
                    controller: _textControllerValidade,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    onChanged: (String e) {},
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Digite a validade das ofertas',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text("Tema do encarte",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20)),
              ),
              Padding(padding: EdgeInsets.all(4)),
              FutureBuilder(
                  future: _pegaTemasAirtable(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: width,
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: temas.length,
                            itemBuilder: (context, indice) {
                              selecionado.add(false);
                              if (indice == 0){
                                return GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: CellTema(temas[indice].tema, temas[indice].topo, selecionado[indice]),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _deixaTudoFalse();
                                      selecionado[indice] = true;
                                      temaSelecionado = temas[indice].tema;
                                      topoSelecionado = temas[indice].topo;
                                    });
                                  },
                                );
                              } else {
                                return GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: CellTema(temas[indice].tema, temas[indice].topo, selecionado[indice]),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _deixaTudoFalse();
                                      selecionado[indice] = true;
                                      temaSelecionado = temas[indice].tema;
                                      topoSelecionado = temas[indice].topo;
                                    });
                                  },
                                );
                              }
                            }
                        ),
                      );
                    } else {
                      return Container(
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(
                              animating: true,
                              radius: 15,
                            )
                          ],
                        ),
                      );
                    }
                  }
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              TextButton(
                onPressed: () async {
                  date = "${dia}/${mes}/${ano}";
                  Map<String, dynamic> criarPraSalvar = Map();
                  criarPraSalvar["nomeEncarte"] = _textController.text;
                  criarPraSalvar["validade"] = _textControllerValidade.text;
                  criarPraSalvar["topo"] = topoSelecionado;
                  criarPraSalvar["tema"] = temaSelecionado;
                  print("encarte criado ${criarPraSalvar}");
                  _listaEncartes[widget.posicaoNaLista] = criarPraSalvar;
                  salvarListaEncartes(_listaEncartes);
                  print(_listaEncartes);
                  analyticsEvents.logEvent(
                    name: "criou_encarte",
                    parameters: {
                      "nome": "${_textController.text}",
                    },
                  );

                  if (widget.fromTo == "ProdutosEncarte") {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Encartes()
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Encartes()
                      ),
                    );
                    _textController.text = "";
                    setState(() {
                      _lerArquivo();
                    });
                    FirebaseAnalytics.instance.logEvent(name: "criou_encarte");
                  }
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Salvar alterações',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Encartes()
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cancelar',
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 500,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
