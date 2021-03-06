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
  String _isPRO;
  String _URLlogo;

  //actions
  Action pegaAirtable;
  Action pegaProdutos;
  Action pegaCodigosPROinterno;
  Action salvaURLimagem;


  //define as actions
  Controller(){
    pegaAirtable = Action(_pegaEncartesMemoria);
    pegaProdutos = Action(_pegaProdutos);
    salvaURLimagem = Action(_salvaURLimagem);
  }

  //geters e setters
  List get listaEncartes => _listaEncartes;
  set listaEncartes(List novoValor) => _listaEncartes = novoValor;

  List<Produto> get listaProdutos => _listaProdutos;
  set listaProdutos(List novoValor) => _listaProdutos = novoValor;

  List get codigosPro => _codigosPro;
  set codigosPro(var novoValor) => _codigosPro = novoValor;

  String get isPRO => _isPRO;
  set isPRO(String novoValor) => _isPRO = novoValor;

  String get URLlogo => _URLlogo;
  set URLlogo(String novoValor) => _URLlogo = novoValor;

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

  _salvaURLimagem(String url) {
    _URLlogo = url;
  }

}
