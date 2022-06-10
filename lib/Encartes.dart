import 'dart:convert';

import 'package:encarte_facil_2/Components/Button.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'Model/Produto.dart';
import 'ProdutosEncarte.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class Encartes extends StatefulWidget {
  const Encartes({key}) : super(key: key);

  @override
  _EncartesState createState() => _EncartesState();
}

class _EncartesState extends State<Encartes> {

  List _listaEncartes = [];
  List<Produto> listaTodosProdutos = [];

  Future<File> _getFile() async {

    final diretorio = await getApplicationDocumentsDirectory();
    return File( "${diretorio.path}/encartes4.json" );
  }

  _pegaProdutosAirTable() async {

    Uri url = Uri.https("api.airtable.com", "v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa");
    http.Response response;

    response = await http.get(
      Uri.parse('https://api.airtable.com/v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa'),
      // Send authorization headers to the backend.
      // headers: {
      //   HttpHeaders.authorizationHeader: "Bearer keySFSIYnvACQhHAa",
      // },
    );

    Map<String, dynamic> retorno = json.decode(response.body);

    List records = retorno["records"];

    listaTodosProdutos.clear();
    for (int i=0; i<records.length; i++ ) {
      // print(i);
      listaTodosProdutos.add(Produto(records[i]["fields"]["primeira"], records[i]["fields"]["segunda"], "", records[i]["fields"]["imagem"]));
    }
  }

  _salvarArquivo() async {

    var arquivo = await _getFile();

    String dados = json.encode( _listaEncartes );
    arquivo.writeAsString( dados );
    print("salvou");

  }

  Future<File> _getEncarteToDelete(String nome) async {

    final diretorio = await getApplicationDocumentsDirectory();
    return File( "${diretorio.path}/${nome}.json" );

  }

  _deletarArquivo(String nome, int indice) async {

    var arquivo = await _getEncarteToDelete(nome);

    _listaEncartes.removeAt(indice);
    _salvarArquivo();
    arquivo.delete();
    _lerArquivo();
  }

  _lerArquivo() async {

    _pegaProdutosAirTable();

    try{
      final arquivo = await _getFile();
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
    // print("INIT");

    _lerArquivo().then( (dados){
      setState(() {

        _listaEncartes = json.decode(dados);

      });
    } );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Qual é o nome do encarte?",
                    textAlign: TextAlign.left,
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
                  Text("Qual é a validade das ofertas:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 0.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 12, 31),
                                  onConfirm: (date) {
                                    print('confirm $date');
                                    _date = '  ${date.day}/${date.month}/${date.year}';
                                    setState(() {
                                      _date = '  ${date.day}/${date.month}/${date.year}';
                                    });
                                  },
                                  currentTime: DateTime.now());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.black54,
                                            ),
                                            Text(
                                              "$_date",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.0,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        // datetime()
                      ],
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
                    criarPraSalvar["validade"] = _textControllerValidade.text;
                    _listaEncartes.add( criarPraSalvar );
                    _salvarArquivo();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutosEncarte(_textController.text, listaTodosProdutos, _textControllerValidade.text)
                      ),
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
        alignment: Alignment.topLeft,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text("Lista de \nencartes",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 0.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 40),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        addEncarte();
                      },
                      child: ButtonWidget()
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
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 00, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: width*0.71,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              child: Text(
                                                encarte["nomeEncarte"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                                          onPressed: () {
                                            setState(() {
                                              _lerArquivo();
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ProdutosEncarte(encarte["nomeEncarte"], listaTodosProdutos, encarte["validade"])
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: Text("Deseja remover este encarte?"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text(
                                                  "Cancelar",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _lerArquivo();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text("Apagar"),
                                                onPressed: () {
                                                  _deletarArquivo(encarte["nomeEncarte"], indice);
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    _lerArquivo();
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
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