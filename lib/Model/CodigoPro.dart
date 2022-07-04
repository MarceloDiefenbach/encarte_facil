class CodigoPRO {

  String _codigoPro;
  String _nome;

  CodigoPRO(this._codigoPro, this._nome);

  String get codigoPro => _codigoPro;
  String get nome => _nome;

  set codigoPro(String value) {
    _codigoPro = value;
  }

  set nome(String value) {
    _nome = value;
  }
}