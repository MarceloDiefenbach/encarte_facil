import 'dart:async';
import 'dart:convert';
import 'package:encarte_facil_2/Components/Alert.dart';
import 'package:encarte_facil_2/Components/Button.dart';
import 'package:encarte_facil_2/Encartes.dart';
import 'package:encarte_facil_2/NewProductsForm.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Logic/controller.dart';
import 'Model/Produto.dart';

class ListaProdutos extends StatefulWidget {

  List<Produto> listaTodosProdutos;

  String nomeEncarte;

  ListaProdutos(this.listaTodosProdutos, this.nomeEncarte);

  @override
  _ListaProdutosState createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {

  String pesquisa = "";
  TextEditingController _textController;
  List<Produto> _listaProdutoFiltro = [];
  List _listaProdutos = [];
  Controller controller;

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File( "${diretorio.path}/${widget.nomeEncarte}.json" );
  }

  _selecionaProduto(Produto produtoSelecionado) async {
    Map<String, dynamic> criarPraSalvar = Map();
    criarPraSalvar["nomeProduto"] = produtoSelecionado.nome;
    criarPraSalvar["segundaLinha"] = produtoSelecionado.segunda;
    criarPraSalvar["valor"] = produtoSelecionado.valor;
    criarPraSalvar["imagem"] = produtoSelecionado.imagem;
    _listaProdutos.add(criarPraSalvar);
    _salvarArquivo();
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();
    String dados = json.encode( _listaProdutos );
    arquivo.writeAsString( dados );
    print("salvou");
    Navigator.pop(context);
  }

  _atualizaListaProdutos() {
    List produtosInterno = _listaProdutos;
    _listaProdutoFiltro.clear();
    for (int i=0; i < produtosInterno.length; i++) {
      if(produtosInterno[i].nome.toLowerCase().contains(pesquisa.toLowerCase()) || produtosInterno[i].segunda.toLowerCase().contains(pesquisa.toLowerCase())) {
        setState(() {
          _listaProdutoFiltro.add(produtosInterno[i]);
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = Provider.of<Controller>(context);
  }

  bool isStopped = true;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isStopped) {
        _listaProdutos = controller.listaProdutos;
        _atualizaListaProdutos();
        if(_listaProdutos.isNotEmpty){
          isStopped = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione um produto",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Container(
        //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.topCenter,
        color: Colors.grey[300],
        child: Observer(
          builder: (_) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: CupertinoSearchTextField(
                      controller: _textController,
                      onChanged: (String e) {
                        pesquisa = e;
                        print(pesquisa);
                        _atualizaListaProdutos();
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewProductsForm()
                          ),
                        );
                      },
                      child: AlertWidget()
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listaProdutoFiltro.length,
                      itemBuilder: (context, indice) {
                        var produto = _listaProdutoFiltro[indice];
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                width: 120,
                                height: 70,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
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
                                                    produto.nome,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Text(
                                                  produto.segunda,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            color: Colors.transparent,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            FirebaseAnalytics.instance.logEvent(
                              name: "adicionou_produto",
                              parameters: {
                                "nome_produto": "${produto.nome}",
                              },
                            );
                            _selecionaProduto(produto);
                          },
                        );
                      }
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
