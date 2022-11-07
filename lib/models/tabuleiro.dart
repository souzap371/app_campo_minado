import 'dart:math';

import 'campo.dart';
import 'package:flutter/foundation.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  //Construtor
  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

//Método Público
  void reiniciar() {
    for (var c in _campos) {
      c.reiniciar();
    }
    _sortearMinas();
  }

//Método para Revelar Bombas
  void revelarBombas() {
    _campos.forEach((c) => c.revelarBombas());
  }

//Método para criar campos
  void _criarCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

//Método relacionar vizinhos
  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

//Metodo Sortear minas
  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdeBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  //Geters
  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((c) => c.resolvido);
  }
}
