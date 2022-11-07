import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
//Criação de funções para teste

    test('Abrir campo COM Explosão', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.minar();

      expect(c.abrir, throwsException);
    });
    //Criação de funções para teste
    test('Abrir campo SEM Explosão', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.abrir();

      expect(c.aberto, isTrue);
    });
    //Criação de funções para teste
    test('Adicionar NÃO Vizinho', () {
      Campo c1 = Campo(linha: 0, coluna: 0);
      Campo c2 = Campo(linha: 1, coluna: 3);
      c1.adicionarVizinho(c2);
      expect(c1.vizinhos.isEmpty, isTrue);
    });
    //Criação de funções para teste
    test('Adicionar Vizinho', () {
      Campo c1 = Campo(linha: 3, coluna: 3);
      Campo c2 = Campo(linha: 3, coluna: 4);
      Campo c3 = Campo(linha: 2, coluna: 2);
      Campo c4 = Campo(linha: 4, coluna: 4);

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);
      expect(c1.vizinhos.length, 3);
    });
    //Criação de funções para teste
    test('Minas na vizinhanca', () {
      Campo c1 = Campo(linha: 3, coluna: 3);

      Campo c2 = Campo(linha: 3, coluna: 4);
      c2.minar();

      Campo c3 = Campo(linha: 2, coluna: 2);

      Campo c4 = Campo(linha: 4, coluna: 4);
      c4.minar();

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);

      expect(c1.qtdeMinasNaVizinhanca, 2);
    });
  });
}
