import 'dart:convert';

import 'package:mobx/mobx.dart';

import '../Model/Produto.dart';
import 'Functions.dart';
// part 'controller.g.dart';

// class Controller = ControllerBase with _$Controller;

class Controller {

  //variaveis
  List _listaEncartes = ObservableList();
  List<Produto> _listaProdutos = ObservableList();
  List _codigoPRO = ObservableList<String>();

  //actions
  Action pegaEncartes;
  Action pegaProdutos;
  Action pegaCodigoPRO;


  //define as actions
  Controller(){
    pegaEncartes = Action(_pegaEncartesMemoria);
    pegaProdutos = Action(_pegaProdutos);
    pegaCodigoPRO = Action(_pegaCodigoPRO);
  }

  //geters e setters
  List get listaEncartes => _listaEncartes;
  set listaEncartes(List novoValor) => _listaEncartes = novoValor;

  List<Produto> get listaProdutos => _listaProdutos;
  set listaProdutos(List novoValor) => _listaProdutos = novoValor;

  List get codigoPro => _codigoPRO[0];
  set codigoPro(var novoValor) => _codigoPRO[0] = novoValor;


  _pegaCodigoPRO() async {
    lerArquivoCodigo().then((dados) {
      String dados2 = json.decode(dados);
      _codigoPRO.add(dados2);
    });
  }

  lerArquivoCodigo() async {
    try {
      final arquivo = await getFileCodigoPro();

      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _pegaEncartesMemoria() async {
    lerArquivo().then((dados) {
      _listaEncartes = json.decode(dados);
    });
  }

  lerArquivo() async {
    try {
      final arquivo = await getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _pegaProdutos() async {
    // print("entrou em pega produtos");
    _listaProdutos = await AirtableGetProdutos() as List<Produto>;
    print("aspokdpaoskd\n\n\n${_listaProdutos}");
  }

}
