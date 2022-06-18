import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Model/Produto.dart';
import '../Model/Tema.dart';




//essa função pega os produtos no airtable
Future<List> AirtableGet() async {
  List<Produto> listaTodosProdutos = [];

  Uri url = Uri.https("api.airtable.com",
      "v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa");
  http.Response response;
  http.Response response2;

  response = await http.get(
    Uri.parse(
        'https://api.airtable.com/v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa'),
    // Send authorization headers to the backend.
    // headers: {
    //   HttpHeaders.authorizationHeader: "Bearer keySFSIYnvACQhHAa",
    // },
  );

  Map<String, dynamic> retorno = json.decode(response.body);
  List records = retorno["records"];
  // print(retorno["offset"]);

  listaTodosProdutos.clear();
  for (int i = 0; i < records.length; i++) {
    // print(i);
    listaTodosProdutos.add(Produto(records[i]["fields"]["primeira"],
        records[i]["fields"]["segunda"], "", records[i]["fields"]["imagem"]));
  }

  response2 = await http.get(
    Uri.parse(
        "https://api.airtable.com/v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa&offset=${retorno["offset"]}"),
    // Send authorization headers to the backend.
    // headers: {
    //   HttpHeaders.authorizationHeader: "Bearer keySFSIYnvACQhHAa",
    // },
  );

  Map<String, dynamic> retorno2 = json.decode(response2.body);
  List records2 = retorno2["records"];

  for (int i = 0; i < records2.length; i++) {
    // print(records2[i]["fields"]["primeira"]);
    listaTodosProdutos.add(Produto(records2[i]["fields"]["primeira"],
        records2[i]["fields"]["segunda"], "", records2[i]["fields"]["imagem"]));
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

  print("lista de encartes");
  print(listaEncartes);
  var arquivo = await getFile();
  String dados = json.encode( listaEncartes );
  arquivo.writeAsString( dados );

}




Future<File> getEncarteToDelete(String nome) async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/${nome}.json" );

}


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