class Motorista {
  int id;
  String cpf;
  String nome;
  String email;
  String telefone;
  String foto;
  String status;
  List<Rede> redes;
  List<Veiculo> veiculos;

  Motorista({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.foto,
    required this.status,
    required this.redes,
    required this.veiculos,
  });

  factory Motorista.fromJson(Map<String, dynamic> json) {
    var redesList = json['redes'] as List;
    List<Rede> redes = redesList.map((item) => Rede.fromJson(item)).toList();

    var veiculosList = json['veiculos'] as List;
    List<Veiculo> veiculos = veiculosList.map((item) => Veiculo.fromJson(item)).toList();

    return Motorista(
      id: json['id'],
      cpf: json['cpf'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      foto: json['foto'],
      status: json['status'],
      redes: redes,
      veiculos: veiculos,
    );
  }
}

class Rede {
  int id;
  String descricao;

  Rede({
    required this.id,
    required this.descricao,
  });

  factory Rede.fromJson(Map<String, dynamic> json) {
    return Rede(
      id: json['id'],
      descricao: json['descricao'],
    );
  }
}

class Veiculo {
  int id;
  String tipoVeiculo;
  String placa;
  String foto;

  Veiculo({
    required this.id,
    required this.tipoVeiculo,
    required this.placa,
    required this.foto,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      id: json['id'],
      tipoVeiculo: json['tipoVeiculo'],
      placa: json['placa'],
      foto: json['foto'],
    );
  }
}
