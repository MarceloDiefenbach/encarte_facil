class Produto {

  String _nome;
  String _segunda;
  String _valor;
  String _imagem;

  Produto(this._nome, this._segunda, this._valor, this._imagem);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get segunda => _segunda;

  set segunda(String value) {
    _segunda = value;
  }

  String get valor => _valor;

  set valor(String value) {
    _valor = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }
}