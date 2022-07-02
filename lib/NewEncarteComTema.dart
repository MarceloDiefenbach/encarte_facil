import 'dart:convert';
import 'dart:io';
import 'package:encarte_facil_2/Components/Cell%20Tema.dart';
import 'package:encarte_facil_2/Encartes.dart';
import 'package:encarte_facil_2/Nova%20Home/Home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Logic/Functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Logic/controller.dart';
import 'Model/Produto.dart';
import 'Model/Tema.dart';
import 'ProdutosEncarte.dart';

class NewEncarteComTema extends StatefulWidget {
  const NewEncarteComTema({key}) : super(key: key);

  @override
  _NewEncarteComTemaState createState() => _NewEncarteComTemaState();
}

class _NewEncarteComTemaState extends State<NewEncarteComTema> {
  List _listaEncartes = [];
  TextEditingController _textController;
  TextEditingController _textControllerValidade;
  List<Tema> temas = [];
  FirebaseAnalytics analyticsEvents = FirebaseAnalytics.instance;
  List<bool> selecionado = [false, false, false, false, false];
  String temaSelecionado = "";
  String topoSelecionado = "";

  int dia = 1;
  int mes = 1;
  int ano = 2022;

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
    _textController = TextEditingController(text: '');
    _textControllerValidade = TextEditingController(text: '');

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String date = "";

    Controller controller = Provider.of<Controller>(context);
    _listaEncartes = controller.listaEncartes;

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
              Padding(
                padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                child: TextButton(
                  onPressed: () async {
                    date = "${dia}/${mes}/${ano}";
                      Map<String, dynamic> criarPraSalvar = Map();
                      criarPraSalvar["nomeEncarte"] = _textController.text;
                      criarPraSalvar["validade"] = _textControllerValidade.text;
                      criarPraSalvar["topo"] = topoSelecionado;
                      criarPraSalvar["tema"] = temaSelecionado;

                      _listaEncartes.add( criarPraSalvar );
                      salvarListaEncartes(_listaEncartes);
                      _textController.text = "";

                    FirebaseAnalytics.instance.logEvent(
                        name: "criou_encarte",
                      parameters: {
                        "nome_encarte": _textController.text,
                        "validade": _textControllerValidade.text,
                        "tema": temaSelecionado
                      }
                    );
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => ProdutosEncarte(_listaEncartes, _listaEncartes.length-1, "newEncarteComTema"),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
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
                        Text('Criar encarte',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
