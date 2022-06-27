import 'dart:convert';

import 'package:mobx/mobx.dart';

import '../Model/Produto.dart';
import 'Functions.dart';
// part 'controller.g.dart';

// class Controller = ControllerBase with _$Controller;

class Controller {

  autorun(){
    print("autorun");
  }

  //variaveis
  var _contador = Observable(0);
  List _listaEncartes = ObservableList();
  List<Produto> _listaProdutos = ObservableList();

  //actions
  Action incrementar;
  Action pegaEncartes;
  Action pegaProdutos;


  //define as actions
  Controller(){
    incrementar = Action(_incrementar);
    pegaEncartes = Action(_pegaEncartesMemoria);
    pegaProdutos = Action(_pegaProdutos);
  }

  //geters e setters
  int get contador => _contador.value;
  set contador(int novoValor) => _contador.value = novoValor;

  List get listaEncartes => _listaEncartes;
  set listaEncartes(List novoValor) => _listaEncartes = novoValor;

  List<Produto> get listaProdutos => _listaProdutos;
  set listaProdutos(List novoValor) => _listaProdutos = novoValor;


  //actions
  _incrementar(){
    contador++;
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
