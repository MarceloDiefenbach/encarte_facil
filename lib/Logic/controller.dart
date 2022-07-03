import 'dart:convert';

import 'package:encarte_facil_2/Model/CodigoPro.dart';
import 'package:mobx/mobx.dart';

import '../Model/Produto.dart';
import 'Functions.dart';
// part 'controller.g.dart';

// class Controller = ControllerBase with _$Controller;

class Controller {

  //variaveis
  List _listaEncartes = ObservableList();
  List<Produto> _listaProdutos = ObservableList();
  List<CodigoPRO> _codigosPro = ObservableList<CodigoPRO>();

  //actions
  Action pegaAirtable;
  Action pegaProdutos;
  Action pegaCodigosPROinterno;


  //define as actions
  Controller(){
    pegaAirtable = Action(_pegaEncartesMemoria);
    pegaProdutos = Action(_pegaProdutos);
  }

  //geters e setters
  List get listaEncartes => _listaEncartes;
  set listaEncartes(List novoValor) => _listaEncartes = novoValor;

  List<Produto> get listaProdutos => _listaProdutos;
  set listaProdutos(List novoValor) => _listaProdutos = novoValor;

  List get codigosPro => _codigosPro;
  set codigosPro(var novoValor) => _codigosPro = novoValor;

  _pegaEncartesMemoria() async {
    lerArquivo().then((dados) {
      _listaEncartes = json.decode(dados);
    });
  }

  lerArquivo() async {
    try {
      final arquivo = await getDiretorioEncartes();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _pegaProdutos() async {
    _listaProdutos.clear();
    _listaProdutos = await AirtableGet() as List<Produto>;
  }

}
