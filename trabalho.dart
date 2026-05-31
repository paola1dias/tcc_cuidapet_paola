import 'dart:io';

void main() {
  int contadorClientes = 0;
  bool rodarSistema = true;

  while (rodarSistema) {
    print("Qual é o seu nome? (Ou digite 'FECHAR' para ver o total e encerrar)");
    String nome = stdin.readLineSync()!;

    if (nome.toLowerCase() == 'fechar') {
      rodarSistema = false;
      break; 
    }
    contadorClientes++;

    String endereco = '''Rua Alegre, Bairro Vila Seresta''';
    int numeroLoja = 144; 

    String mensagem = '''
Prezado(a) $nome, seja muito bem-vindo(a) à nossa loja! 
Oferecemos diversos produtos e serviços para o seu pet.

- Para venda de PRODUTOS: Procure a colaboradora Paola.
- Para SERVIÇOS (Banho ou Tosa): Procure o setor responsável.

Obrigado e esperamos que tenha uma ótima experiência em nossa loja! Logo teremos um sistema de autoatendimento.
''';

    print(mensagem);
    print("--------------------------------------------------");
    print("Endereço: $endereco | Número da loja: $numeroLoja");
    print("--------------------------------------------------\n");

    print("MENU DE OPÇÕES:");
    print("1 - Ver ofertas de Produtos");
    print("2 - Ver ofertas de Serviços");
    print("3 - Ver ofertas de roupas");
    print("4 - Ver novos serviços");
    print("5 - Promoção I 10% de desconto");
    print("6 - Promoção II 20% de desconto");
    print("7 - Sair");
    
    print("\n--- RESULTADO ---");
    print("--------------------------------------------------\n");

    bool continuarNoMenu = true;
    while (continuarNoMenu) {
      print("\nEscolha uma opção (1-7): ");
      String opcao = stdin.readLineSync()!;
      
      switch (opcao) {
        case '1':
          print("Ração Royal Canin Indor 7,5kg com o valor promocional de R\$ 280,00");
          break;
        case '2':
          print("Banho e tosa na promoção pelo preço do banho R\$ 54,00");
          break;
        case '3':
          print("Roupas em oferta - Capa de chuva R\$ 59,99");
          break;
        case '4':
          print("Novos serviços oferecidos: Hidratação de pelo R\$ 39,99 | Tosa higienica por R\$ 10,99 | Tingimento dos pelo por R\$ 55,99");
          break;
        case '5':
          print("Descrição da promoção I: Compre um saco de 15kg de ração (R\$ 345,99) e ganhe 10% de desconto no banho.");
          break;
        case '6':
          print("Descrição da promoção II: Compre 1 banho com tosa higienica e hidratação e ganhe 20% de desconto no valor total.");
          break;
        case '7':
          print("Saindo do atendimento de $nome...");
          continuarNoMenu = false; 
        default:
          print("Opção inválida!");
      }
    }
  }

  print("\n==================================================");
  print("Total de clientes que usaram o sistema hoje: $contadorClientes");
  print("==================================================");
}
