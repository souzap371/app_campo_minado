import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

//Constantes
class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

//Variaveis
  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  //Construtor
  Campo({
    required this.linha,
    required this.coluna,
  });

  //Logica (Funções)

  //Adicionar vizinhos
  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    //Lógica
    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }
    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  //Abrir uma bomba
  void abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  //Método Revelar Bombas
  void revelarBombas() {
    if (_minado) {
      _aberto = true;
    }
  }

  //Método Minar
  void minar() {
    _minado = true;
  }

  //Método Alterar marcacao
  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  //Método reiniciar
  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  //Geters

  //Retorna Minado
  bool get minado {
    return _minado;
  }

  //Retorna explodidos
  bool get explodido {
    return _explodido;
  }

  //Retorna abertos
  bool get aberto {
    return _aberto;
  }

  //Retorna marcados
  bool get marcado {
    return _marcado;
  }

  //Retorna resolvido ou nao
  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  //Retornar vizinhança segura
  bool get vizinhancaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  //Retornar quantidade de minas ao redor
  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((v) => v.minado).length;
  }
}
