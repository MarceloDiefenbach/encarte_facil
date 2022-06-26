import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Model/Produto.dart';
import '../Model/Tema.dart';




//essa função pega os produtos no airtable
Future<List> AirtableGet() async {
  List<Produto> listaTodosProdutos = [];

  listaTodosProdutos.clear();

  http.Response response;
  http.Response response2;
  Map<String, dynamic> retorno;

  bool controle = true;

  List records;

  for (int i = 0; i < 10; i++) {

    if (i <= 0){

      Uri url = Uri.https("api.airtable.com",
          "v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa");

      response = await http.get(
        Uri.parse(
            'https://api.airtable.com/v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa'),
      );

      retorno = json.decode(response.body);
      records = retorno["records"];

      for (int i = 0; i < records.length; i++) {
        listaTodosProdutos.add(Produto(records[i]["fields"]["primeira"],
            records[i]["fields"]["segunda"], "", records[i]["fields"]["imagem"]));
      }
      if (retorno["offset"] == []) {
        return listaTodosProdutos;
        break;
      }
      print("offset ${retorno["offset"]}");


    } else {

      if (controle) {
        response2 = await http.get(
          Uri.parse(
              "https://api.airtable.com/v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa&offset=${retorno["offset"]}"),
        );

        Map<String, dynamic> retorno2 = json.decode(response2.body);
        List records2 = retorno2["records"];

        for (int i = 0; i < records2.length; i++) {
          listaTodosProdutos.add(Produto(records2[i]["fields"]["primeira"],
              records2[i]["fields"]["segunda"], "", records2[i]["fields"]["imagem"]));
        }

        if (records2.length < 99) {
          controle = false;
        }
      } else {
        //nothing to do here
      }
    }
  }
  return listaTodosProdutos;
}




//essa função pega o diretorio onde ficam salvas as cisas
Future<File> getFile() async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/encartes7.json" );

}


//essa função salva o a lista de encartes na memoria do celular
salvarArquivo(List listaEncartes) async {

  print("salvou");
  print("lista de encartes");
  print(listaEncartes);
  var arquivo = await getFile();
  String dados = json.encode( listaEncartes );
  arquivo.writeAsString( dados );

}

Future<File> getFileCodigoPro() async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/codigoPRO.json" );

}

//salva o código pro na memoria
salvarCodigoPro() async {

  var arquivo = await getFileCodigoPro();

  String dados = json.encode( "123lnkjasd" );
  arquivo.writeAsString( dados );

}

//pega o código pro que ja ta salvo na memoria
recuperaCodigoPro() async {

  lerArquivo().then((dados) {
    String dados2 = json.decode(dados);
    print("${dados2} dentro do funcitions");
    return dados2;
  });
}

lerArquivo() async {
  try {
    final arquivo = await getFileCodigoPro();

    return arquivo.readAsString();
  } catch (e) {
    return null;
  }
}


//pega o lugar da memoria que o encarte que vai ser apagado ta salvo
Future<File> getEncarteToDelete(String nome) async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/${nome}.json" );

}

//deleta o encarte da lista de encartes
deletarEncarte(String nome, int indice, List listaEncartes) async {

  var arquivo = await getEncarteToDelete(nome);

  listaEncartes.removeAt(indice);
  salvarArquivo(listaEncartes);
  arquivo.delete();

}

pegaTemasAirtable() async {

  List<Tema> temas = [];

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