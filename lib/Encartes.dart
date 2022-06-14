import 'dart:convert';
import 'package:encarte_facil_2/Components/Cell%20Encarte.dart';
import 'package:encarte_facil_2/NewEncarte.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import './Functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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


  _deletarArquivo(String nome, int indice) async {

    var arquivo = await getEncarteToDelete(nome);

    _listaEncartes.removeAt(indice);
    salvarArquivo(_listaEncartes);
    arquivo.delete();
    _lerArquivo();
  }

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
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String date = "";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.topLeft,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewEncarte()));
                      },
                      child: ButtonWidget("Novo encarte")
                  )
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Container(
                height: height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _listaEncartes.length,
                    itemBuilder: (context, indice) {
                      var encarte = _listaEncartes[indice];
                      return GestureDetector(
                        child: CellEncarte(encarte["nomeEncarte"], indice, _listaEncartes),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdutosEncarte(encarte["nomeEncarte"], listaTodosProdutos, encarte["validade"])
                            ),
                          );
                        },
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}