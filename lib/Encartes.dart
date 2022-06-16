import 'dart:convert';
import 'package:encarte_facil_2/Components/Cell%20Encarte.dart';
import 'package:encarte_facil_2/NewEncarte.dart';
import 'package:encarte_facil_2/NewEncarteComTema.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'Logic/Functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Logic/firebase_options.dart';

import 'package:encarte_facil_2/Components/Button.dart';
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
  List<Produto> listaTodosProdutos = [];

  _lerArquivo() async {
    listaTodosProdutos = await AirtableGet() as List<Produto>;

    try{
      final arquivo = await getFile();
      return arquivo.readAsString();
    }catch(e){
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

    _lerArquivo().then((dados){
      setState(() {
        _listaEncartes = json.decode(dados);
        print(_listaEncartes);
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String date = "";

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _listaEncartes.length+1,
            itemBuilder: (context, indice) {
              if (indice == 0) {
                return Column(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                    Row(
                      children: [
                        Container(
                          width: width*0.55,
                          child: Text("Lista de encartes",
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
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewEncarteComTema()));
                        FirebaseAnalytics.instance.logEvent(name: "criar_encarte");
                      },
                      child: Container(
                          width: width,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Criar novo encarte',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width*0.055,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                );
              } else {
                var encarte = _listaEncartes[indice-1];
                return GestureDetector(
                  child: CellEncarte(encarte["nomeEncarte"], indice-1, _listaEncartes),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutosEncarte(encarte, listaTodosProdutos)
                      ),
                    );
                  },
                );
              }
            }
        ),
      ),
    );
  }
}