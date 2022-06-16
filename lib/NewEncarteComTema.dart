import 'dart:convert';
import 'package:encarte_facil_2/Encartes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:numberpicker/numberpicker.dart';


import './Functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Model/Produto.dart';
import 'ProdutosEncarte.dart';

class NewEncarteComTema extends StatefulWidget {
  const NewEncarteComTema({key}) : super(key: key);

  @override
  _NewEncarteComTemaState createState() => _NewEncarteComTemaState();
}

class _NewEncarteComTemaState extends State<NewEncarteComTema> {
  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];

  FirebaseAnalytics analyticsEvents = FirebaseAnalytics.instance;

  int dia = 1;
  int mes = 1;
  int ano = 2022;

  _lerArquivo() async {

    listaTodosProdutos = await AirtableGet() as List<Produto>;

    try {
      final arquivo = await getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController(text: '');

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
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, height*0.1, 0, 0)),
              Text("Nome do encarte",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20)
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                    autofocus: true,
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
              Text("Defina a validade das ofertas",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  width: width * 0.9,
                  height: height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, height*0.01, 24, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Escolha uma data",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_rounded, color: Colors.black),
                        onPressed: () {
                          //do something
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Text("Tema do encarte",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20)),
              Padding(padding: EdgeInsets.all(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),

                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),

                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),

                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),

                  Container(
                    width: width*0.28,
                    height: width*0.28,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              TextButton(
                onPressed: () async {
                  date = "${dia}/${mes}/${ano}";
                    Map<String, dynamic> criarPraSalvar = Map();
                    criarPraSalvar["nomeEncarte"] = _textController.text;
                    criarPraSalvar["validade"] = date;
                    _listaEncartes.add( criarPraSalvar );
                    salvarArquivo(_listaEncartes);
                    Navigator.of(context).pop();
                    analyticsEvents.logEvent(
                        name: "criou_encarte",
                      parameters: {
                        "nome": "${_textController.text}",
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutosEncarte(_textController.text, listaTodosProdutos, date)
                      ),
                    );
                    _textController.text = "";
                    setState(() {
                      _lerArquivo();
                    });
                  FirebaseAnalytics.instance.logEvent(name: "criou_encarte");
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
