import 'dart:io';

class Produto {
  final String nome;
  final double preco;

  Produto(this.nome, this.preco);
}

class Carrinho {
  final List<Produto> _itens = [];
  static const int limiteItens = 3;

  List<Produto> get itens => List.unmodifiable(_itens);
  int get quantidade => _itens.length;
  bool get estaVazio => _itens.isEmpty;
  bool get estaCheio => _itens.length >= limiteItens;

  double get subtotal {
    return _itens.fold(0.0, (soma, item) => soma + item.preco);
  }

  bool adicionar(Produto? produto) {
    if (produto == null) {
      return false;
    }
    if (estaCheio) {
      print("Carrinho cheio! Limite de $limiteItens itens.");
      return false;
    }
    _itens.add(produto);
    return true;
  }

  void limpar() => _itens.clear();
}

class RelatorioVendas {
  int _totalVendasDia = 0;
  double _valorTotalVendas = 0.0;

  void registrarVenda(double valor) {
    _totalVendasDia++;
    _valorTotalVendas += valor;
  }

  void exibirFechamento() {
    print("\n================ FECHAMENTO DO DIA ================");
    print("Total de vendas: $_totalVendasDia");
    print("Valor total: R\$ ${_valorTotalVendas.toStringAsFixed(2)}");
    print("====================================================");
  }
}

class MenuAutoatendimento {
  final RelatorioVendas _relatorio = RelatorioVendas();

  void iniciar() {
    while (true) {
      print("\n=== Bem vindo ao autoatendimento do Cuidapet ===");
      print("Digite seu nome (ou '0' para sair):");
      String nome = stdin.readLineSync()!;

      if (nome == '0') break;

      if (nome == "cuidapetrestrito") {
        _executarAreaRestrita();
      } else {
        _executarMenuPrincipal(nome);
      }
    }
    _relatorio.exibirFechamento();
  }

  void _executarMenuPrincipal(String nomeCliente) {
    Carrinho carrinho = Carrinho();
    bool continuar = true;

    while (continuar) {
      print("\nOlá $nomeCliente, escolha uma opção:");
      print("1 - Ver promoções");
      print("2 - Solicitar serviço");
      print("3 - Listar carrinho de compra");
      print("4 - Finalizar carrinho de compra");
      print("0 - Sair");
      stdout.write("Digite sua opção desejada: ");
      
      String opcao = stdin.readLineSync()!;

      switch (opcao) {
        case '1':
          _mostrarPromocoes(carrinho);
          break;
        case '2':
          _mostrarServicos(carrinho);
          break;
        case '3':
          _listarItens(carrinho);
          break;
        case '4':
          if (carrinho.estaVazio) {
            print("Seu carrinho está vazio!");
          } else {
            _finalizarVenda(carrinho);
            continuar = false;
          }
          break;
        case '0':
          continuar = false;
          break;
        default:
          print("Opção inválida!");
      }
    }
  }

  void _mostrarPromocoes(Carrinho carrinho) {
    print("\n--- PROMOÇÕES ---");
    print("101 - Ração Royal Canin 7,5kg - R\$ 290,00");
    print("102 - Ração Royal Gatos Castrados - R\$ 492,00");
    print("103 - Bifinho Keldog - R\$ 23,92");
    print("104 - Fraldas Super Secão - R\$ 38,61");
    print("8 - Adicionar ao carrinho | 0 - Voltar");

    String op = stdin.readLineSync()!;
    if (op == '8') {
      _processarAdicao(carrinho);
    }
  }

  void _mostrarServicos(Carrinho carrinho) {
    print("\n--- SERVIÇOS ---");
    print("201 - Banho e tosa - R\$ 55,99");
    print("202 - Tosa higiênica - R\$ 12,99");
    print("203 - Hidratação - R\$ 20,99");
    print("8 - Adicionar ao carrinho | 0 - Voltar");

    String op = stdin.readLineSync()!;
    if (op == '8') {
      _processarAdicao(carrinho);
    }
  }

  void _processarAdicao(Carrinho carrinho) {
    if (carrinho.estaCheio) {
      print("Carrinho cheio! Limite de 3 itens.");
      return;
    }

    stdout.write("Digite o código: ");
    String codigo = stdin.readLineSync()!;

    Produto? produtoEncontrado;

    if (codigo == "101") { produtoEncontrado = Produto("Ração Canin 7,5kg", 290.00); }
    else if (codigo == "102") { produtoEncontrado = Produto("Ração Gatos Castrados", 492.00); }
    else if (codigo == "103") { produtoEncontrado = Produto("Bifinho Keldog", 23.92); }
    else if (codigo == "104") { produtoEncontrado = Produto("Fraldas Super Secão", 38.61); }
    else if (codigo == "201") { produtoEncontrado = Produto("Banho e tosa", 55.99); }
    else if (codigo == "202") { produtoEncontrado = Produto("Tosa higiênica", 12.99); }
    else if (codigo == "203") { produtoEncontrado = Produto("Hidratação", 20.99); }

    if (produtoEncontrado != null) {
      carrinho.adicionar(produtoEncontrado);
    } else {
      print("Código não encontrado!");
    }
  }

  void _listarItens(Carrinho carrinho) {
    print("\n--- ITENS NO CARRINHO ---");
    if (carrinho.estaVazio) {
      print("Vazio.");
    } else {
      for (var item in carrinho.itens) {
        print("- ${item.nome}");
      }
      print("Subtotal atual: R\$ ${carrinho.subtotal.toStringAsFixed(2)}");
    }
  }

  void _finalizarVenda(Carrinho carrinho) {
    double total = carrinho.subtotal;
    print("\nTotal: R\$ ${total.toStringAsFixed(2)}");
    print("Pagamento: (1) Dinheiro [10% desc] | (2) Cartão");
    String forma = stdin.readLineSync()!;

    if (forma == '1') {
      total *= 0.9;
      print("Desconto de 10% aplicado!");
    }

    print("Valor final: R\$ ${total.toStringAsFixed(2)}");
    _relatorio.registrarVenda(total);
  }

  void _executarAreaRestrita() {
    print("\n--- ÁREA RESTRITA ---");
    stdout.write("Nome do cliente: ");
    String nome = stdin.readLineSync()!;
    stdout.write("Valor total: ");
    double valor = double.parse(stdin.readLineSync()!);
    stdout.write("Pagamento (D/C): ");
    String forma = stdin.readLineSync()!.toUpperCase();

    if (forma == 'D') valor *= 0.9;

    print("Venda para $nome finalizada: R\$ ${valor.toStringAsFixed(2)}");
    _relatorio.registrarVenda(valor);
  }
}

void main() {
  MenuAutoatendimento().iniciar();
}
