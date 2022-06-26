import 'dart:convert';
import 'package:encarte_facil_2/Components/Alert.dart';
import 'package:encarte_facil_2/Components/Button.dart';
import 'package:encarte_facil_2/Encartes.dart';
import 'package:encarte_facil_2/NewProductsForm.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  List _listaProdutos = [];

  Future<File> _getFile() async {

    final diretorio = await getApplicationDocumentsDirectory();
    return File( "${diretorio.path}/${widget.nomeEncarte}.json" );

  }

  _lerArquivo() async {

    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    }catch(e){
      return null;
    }

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

  TextEditingController _textController;

  List<Produto> _listaProdutoFiltro = [];

  _atualizaListaProdutos() {
    print("entrou");
    _listaProdutoFiltro.clear();
    for (int i=0; i < widget.listaTodosProdutos.length; i++) {

      if(widget.listaTodosProdutos[i].nome.toLowerCase().contains(pesquisa.toLowerCase()) || widget.listaTodosProdutos[i].segunda.toLowerCase().contains(pesquisa.toLowerCase())) {
        // print(i);
        setState(() {
          _listaProdutoFiltro.add(widget.listaTodosProdutos[i]);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
    _atualizaListaProdutos();

    _lerArquivo().then( (dados){
      setState(() {

        _listaProdutos = json.decode(dados);

      });
    } );

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
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
