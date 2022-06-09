class Tema{

  String _nome;
  String _tema;
  String _topo;

  Tema(this._nome, this._tema, this._topo);

  String get topo => _topo;

  set topo(String value) {
    _topo = value;
  }

  String get tema => _tema;

  set tema(String value) {
    _tema = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}