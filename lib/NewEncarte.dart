import 'dart:convert';
import 'package:numberpicker/numberpicker.dart';


import './Functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Model/Produto.dart';
import 'ProdutosEncarte.dart';

class NewEncarte extends StatefulWidget {
  const NewEncarte({key}) : super(key: key);

  @override
  _NewEncarteState createState() => _NewEncarteState();
}

class _NewEncarteState extends State<NewEncarte> {
  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];

  DateTime _selectedDate = DateTime.now();

  _deletarArquivo(String nome, int indice) async {
    var arquivo = await getEncarteToDelete(nome);

    _listaEncartes.removeAt(indice);
    salvarArquivo(_listaEncartes);
    arquivo.delete();
    _lerArquivo();
  }

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
    String _date = "  Validade";

    void addEncarte() {
      setState(() {
        showDialog<void>(
          context: context,
          builder: (context) {
            int selectedRadio = 0;
            return CupertinoAlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Qual é o nome do encarte?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: CupertinoTextField(
                      controller: _textController,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _lerArquivo();
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Criar"),
                  onPressed: () {
                    Map<String, dynamic> criarPraSalvar = Map();
                    criarPraSalvar["nomeEncarte"] = _textController.text;
                    _listaEncartes.add(criarPraSalvar);
                    salvarArquivo(_listaEncartes);
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutosEncarte(
                              _textController.text,
                              listaTodosProdutos,
                              _textControllerValidade.text)),
                    );
                    _textController.text = "";
                    setState(() {
                      _lerArquivo();
                    });
                  },
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        height: height,
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
              Text("Escolhe o nome do encarte",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24)),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Container(
                width: width * 0.85,
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
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  onChanged: (String e) {},
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Digite o nome do encarte',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 20)),
              Text("Defina a validade das ofertas",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24)),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),

              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              TextButton(
                onPressed: () async {},
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
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
