import 'dart:io';

int totalVendasDia = 0;
double valorTotalVendas = 0.0;

void main() {
  while (true) {
    print("\n=== Bem vindo ao autoatendimento do Cuidapet ===");
    print("Digite seu nome (ou '0' para sair):");
    String nome = stdin.readLineSync()!;

    if (nome == '0') break;

    if (nome == "cuidapetrestrito") {
      executarAreaRestrita();
    } else {
      executarMenuPrincipal(nome);
    }
  }

  print("\n================ FECHAMENTO DO DIA ================");
  print("Total de vendas: $totalVendasDia");
  print("Valor total: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
  print("====================================================");
}

void executarMenuPrincipal(String nomeCliente) {
  // Criamos listas simples para o carrinho (apenas textos e preços separados)
  List<String> itensCarrinho = [];
  double precoCarrinho = 0.0;
  int quantidadeItens = 0;

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
        double valorAdicionado = mostrarPromocoes(itensCarrinho, quantidadeItens);
        if (valorAdicionado > 0) {
          precoCarrinho += valorAdicionado;
          quantidadeItens++;
        }
        break;
      case '2':
        double valorAdicionado = mostrarServicos(itensCarrinho, quantidadeItens);
        if (valorAdicionado > 0) {
          precoCarrinho += valorAdicionado;
          quantidadeItens++;
        }
        break;
      case '3':
        listarItens(itensCarrinho, precoCarrinho);
        break;
      case '4':
        if (quantidadeItens == 0) {
          print("Seu carrinho está vazio!");
        } else {
          finalizarVenda(precoCarrinho);
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

double mostrarPromocoes(List<String> carrinho, int qtd) {
  print("\n--- PROMOÇÕES ---");
  print("101 - Ração Royal Canin 7,5kg - R\$ 290,00");
  print("102 - Ração Royal Gatos Castrados - R\$ 492,00");
  print("103 - Bifinho Keldog - R\$ 23,92");
  print("104 - Fraldas Super Secão - R\$ 38,61");
  print("8 - Adicionar ao carrinho | 0 - Voltar");

  String op = stdin.readLineSync()!;
  if (op == '8') {
    return processarAdicao(carrinho, qtd);
  }
  return 0.0;
}

double mostrarServicos(List<String> carrinho, int qtd) {
  print("\n--- SERVIÇOS ---");
  print("201 - Banho e tosa - R\$ 55,99");
  print("202 - Tosa higiênica - R\$ 12,99");
  print("203 - Hidratação - R\$ 20,99");
  print("8 - Adicionar ao carrinho | 0 - Voltar");

  String op = stdin.readLineSync()!;
  if (op == '8') {
    return processarAdicao(carrinho, qtd);
  }
  return 0.0;
}

double processarAdicao(List<String> carrinho, int qtd) {
  if (qtd >= 3) {
    print("Carrinho cheio! Limite de 3 itens.");
    return 0.0;
  }

  stdout.write("Digite o código: ");
  String codigo = stdin.readLineSync()!;

  if (codigo == "101") { carrinho.add("Ração Canin 7,5kg"); return 290.00; }
  if (codigo == "102") { carrinho.add("Ração Gatos Castrados"); return 492.00; }
  if (codigo == "103") { carrinho.add("Bifinho Keldog"); return 23.92; }
  if (codigo == "104") { carrinho.add("Fraldas Super Secão"); return 38.61; }
  if (codigo == "201") { carrinho.add("Banho e tosa"); return 55.99; }
  if (codigo == "202") { carrinho.add("Tosa higiênica"); return 12.99; }
  if (codigo == "203") { carrinho.add("Hidratação"); return 20.99; }

  print("Código não encontrado!");
  return 0.0;
}

void listarItens(List<String> carrinho, double total) {
  print("\n--- ITENS NO CARRINHO ---");
  if (carrinho.isEmpty) {
    print("Vazio.");
  } else {
    for (String item in carrinho) {
      print("- $item");
    }
    print("Subtotal atual: R\$ ${total.toStringAsFixed(2)}");
  }
}

void finalizarVenda(double total) {
  print("\nTotal: R\$ ${total.toStringAsFixed(2)}");
  print("Pagamento: (1) Dinheiro [10% desc] | (2) Cartão");
  String forma = stdin.readLineSync()!;

  if (forma == '1') {
    total *= 0.9;
    print("Desconto de 10% aplicado!");
  }

  print("Valor final: R\$ ${total.toStringAsFixed(2)}");
  totalVendasDia++;
  valorTotalVendas += total;
}

void executarAreaRestrita() {
  print("\n--- ÁREA RESTRITA ---");
  stdout.write("Nome do cliente: ");
  String nome = stdin.readLineSync()!;
  stdout.write("Valor total: ");
  double valor = double.parse(stdin.readLineSync()!);
  stdout.write("Pagamento (D/C): ");
  String forma = stdin.readLineSync()!.toUpperCase();

  if (forma == 'D') valor *= 0.9;

  print("Venda para $nome finalizada: R\$ ${valor.toStringAsFixed(2)}");
  totalVendasDia++;
  valorTotalVendas += valor;
}
