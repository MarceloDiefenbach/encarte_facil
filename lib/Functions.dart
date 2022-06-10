import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'Model/Produto.dart';

//essa função pega os produtos no airtable
Future<List> AirtableGet() async {
  List<Produto> listaTodosProdutos = [];

  Uri url = Uri.https("api.airtable.com",
      "v0/appE15cyCmB6d2KVq/Table%201?api_key=keySFSIYnvACQhHAa");
  http.Response response;

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

  listaTodosProdutos.clear();
  for (int i = 0; i < records.length; i++) {
    // print(i);
    listaTodosProdutos.add(Produto(records[i]["fields"]["primeira"],
        records[i]["fields"]["segunda"], "", records[i]["fields"]["imagem"]));
  }
  return listaTodosProdutos;
}

//essa função pega o diretorio onde ficam salvas as cisas
Future<File> getFile() async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/encartes4.json" );

}

//essa função salva o arquivo na memoria do celular
salvarArquivo(List listaEncartes) async {

  var arquivo = await getFile();
  String dados = json.encode( listaEncartes );
  arquivo.writeAsString( dados );

}

Future<File> getEncarteToDelete(String nome) async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/${nome}.json" );

}