import 'package:encarte_facil_2/Encartes/EncarteGerado2Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado3Produtos.dart';
import 'package:encarte_facil_2/Encartes/EncarteGerado4Produtos.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

import 'Encartes/EncarteGerado1Produto.dart';
import 'Model/Tema.dart';

class SelecionarTema extends StatefulWidget {

  List listaProdutos;
  String validade;

  SelecionarTema(this.listaProdutos, this.validade);

  @override
  _SelecionarTemaState createState() => _SelecionarTemaState();
}

class _SelecionarTemaState extends State<SelecionarTema> {

  List<Tema> temas = [];

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
    // super.initState();
      _pegaTemasAirtable().then( (dados){
        setState(() {
          print("foi");
        });
      } );
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione o tema",
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
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: _pegaTemasAirtable(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: temas.length,
                          itemBuilder: (context, indice) {
                            var tema = temas[indice];
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                            width: width*0.9,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: NetworkImage(tema.tema),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                            width: width*0.9,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.fitHeight,
                                                image: NetworkImage(tema.topo),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                onTap: () {
                                  FirebaseAnalytics.instance.logEvent(
                                    name: "escolheu_tema_encarte",
                                    parameters: {
                                      "nome_tema": "${tema.nome}",
                                    },
                                  );
                                  if (widget.listaProdutos.length == 1) {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => EncarteGerado1Produto(widget.listaProdutos, tema.tema, tema.topo, widget.validade)));
                                  } else if (widget.listaProdutos.length == 2) {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => EncarteGerado2Produtos(widget.listaProdutos, tema.tema, tema.topo, widget.validade)));
                                  } else if (widget.listaProdutos.length == 3) {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => EncarteGerado3Produtos(widget.listaProdutos, tema.tema, tema.topo, widget.validade)));
                                  } else if (widget.listaProdutos.length == 4) {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => EncarteGerado4Produtos(widget.listaProdutos, tema.tema, tema.topo, widget.validade)));
                                  }
                                },
                              ),
                            );
                          }
                      );
                    } else {
                      return CupertinoActivityIndicator(
                        animating: true,
                        radius: 15,
                      );
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
// width: width*0.37,
// height: 100,
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.circular(15)
// ),
// )



