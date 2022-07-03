import 'dart:convert';
import 'dart:io';

import 'package:encarte_facil_2/Logic/controller.dart';
import 'package:encarte_facil_2/Model/CodigoPro.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  for (int i = 0; i < 5; i++) {
    do {
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
    } while (retorno["offset"] == []);
  }
  return listaTodosProdutos;
}




//essa função pega o diretorio onde ficam salvas as cisas
Future<File> getDiretorioEncartes() async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/encartes7.json" );

}


//essa função salva o a lista de encartes na memoria do celular
salvarListaEncartes(List listaEncartes) async {

  var arquivo = await getDiretorioEncartes();
  String dados = json.encode( listaEncartes );
  arquivo.writeAsString( dados );

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
  salvarListaEncartes(listaEncartes);
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


lerArquivoCodigoPRO() async {
  try {
    final arquivo = await getFileCodigoPro();
    return arquivo.readAsString();
  } catch (e) {
    return null;
  }
}

Future<File> getFileCodigoPro() async {

  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/codigoPRO.json" );

}

//salva o código pro na memoria
salvarCodigoPro(String codigoPro) async {

  try{
    var arquivo = await getFileCodigoPro();

    String dados = json.encode(codigoPro);
    arquivo.writeAsString( dados );
  } catch (e) {
    return null;
  }
}



//pega o código pro que ja ta salvo na memoria
recuperaCodigoPro() async {

  String dados2 = json.decode(await lerArquivoCodigoPRO());
  String codigoPRO = dados2;

  return codigoPRO;
}

Future<String> verificaProMemoria() async {

  List listComURL = [];
  listComURL.clear();

  http.Response response;
  Map<String, dynamic> retorno;

  List records;

  Uri url = Uri.https("api.airtable.com",
      "v0/app2OpRUT2B6brsT7/Table%201?api_key=keySFSIYnvACQhHAa");

  response = await http.get(
    Uri.parse(
        'https://api.airtable.com/v0/app2OpRUT2B6brsT7/Table%201?api_key=keySFSIYnvACQhHAa'),
  );

  retorno = json.decode(response.body);
  records = retorno["records"];

  for (int i = 0; i < records.length; i++) {
    String url = records[i]["fields"]["url"];
    String codigoCliente = records[i]["fields"]["codigo"];
    salvarURL(url);

    String codigoMemoria = await recuperaCodigoPro();
      if (codigoMemoria == codigoCliente) {
        print("validou certo");
        recuperaCodigoPro();
        return "true";
      }
  }
  return "false";
}

String urlLogoMercado;

retornaURL() {
  return urlLogoMercado;
}

Future<String> verificaProDigitado(String codigoProDigitado) async {

  List listComURL = [];
  listComURL.clear();

  http.Response response;
  Map<String, dynamic> retorno;

  List records;

  Uri url = Uri.https("api.airtable.com",
      "v0/app2OpRUT2B6brsT7/Table%201?api_key=keySFSIYnvACQhHAa");

  response = await http.get(
    Uri.parse(
        'https://api.airtable.com/v0/app2OpRUT2B6brsT7/Table%201?api_key=keySFSIYnvACQhHAa'),
  );

  retorno = json.decode(response.body);
  records = retorno["records"];

  for (int i = 0; i < records.length; i++) {
    String url = records[i]["fields"]["url"];
    String codigoCliente = records[i]["fields"]["codigo"];
    salvarURL(url);
    urlLogoMercado = url;

    if (codigoCliente == codigoProDigitado) {
      print("validou certo");

      salvarCodigoPro(codigoProDigitado);
      return "true";
    }
  }
  return "false";
}



lerArquivoURL() async {
  try {
    final arquivo = await getFileURL();
    return arquivo.readAsString();
  } catch (e) {
    return null;
  }
}

Future<File> getFileURL() async {
  final diretorio = await getApplicationDocumentsDirectory();
  return File( "${diretorio.path}/URL-logo.json" );
}

salvarURL(String codigoPro) async {

  try{
    var arquivo = await getFileURL();
    String dados = json.encode(codigoPro);
    arquivo.writeAsString( dados );
  } catch (e) {
    return null;
  }
}

recuperaURL() async {

  String dados2 = json.decode(await lerArquivoURL());
  String urlLogoMercado = dados2;

  return urlLogoMercado;
}

