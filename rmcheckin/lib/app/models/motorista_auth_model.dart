// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

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

  Motorista copyWith({
    int? id,
    String? cpf,
    String? nome,
    String? email,
    String? telefone,
    String? foto,
    String? status,
    List<Rede>? redes,
    List<Veiculo>? veiculos,
  }) {
    return Motorista(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      foto: foto ?? this.foto,
      status: status ?? this.status,
      redes: redes ?? this.redes,
      veiculos: veiculos ?? this.veiculos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cpf': cpf,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'foto': foto,
      'status': status,
      'redes': redes.map((x) => x.toMap()).toList(),
      'veiculos': veiculos.map((x) => x.toMap()).toList(),
    };
  }

  factory Motorista.fromMap(Map<String, dynamic> map) {
    return Motorista(
      id: map['id'] ?? 0,
      cpf: map['cpf'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      foto: map['foto'] ?? '',
      status: map['status'] ?? '',
      redes: List<Rede>.from(
        (map['redes'] as List<int>).map<Rede>(
          (x) => Rede.fromMap(x as Map<String, dynamic>),
        ),
      ),
      veiculos: List<Veiculo>.from(
        (map['veiculos'] as List<int>).map<Veiculo>(
          (x) => Veiculo.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Motorista.fromJson(String source) => Motorista.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Motorista(id: $id, cpf: $cpf, nome: $nome, email: $email, telefone: $telefone, foto: $foto, status: $status, redes: $redes, veiculos: $veiculos)';
  }

  @override
  bool operator ==(covariant Motorista other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.cpf == cpf &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.foto == foto &&
        other.status == status &&
        listEquals(other.redes, redes) &&
        listEquals(other.veiculos, veiculos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cpf.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        foto.hashCode ^
        status.hashCode ^
        redes.hashCode ^
        veiculos.hashCode;
  }
}

class Rede {
  int id;
  String descricao;

  Rede({
    required this.id,
    required this.descricao,
  });

  Rede copyWith({
    int? id,
    String? descricao,
  }) {
    return Rede(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
    };
  }

  factory Rede.fromMap(Map<String, dynamic> map) {
    return Rede(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rede.fromJson(String source) => Rede.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rede(id: $id, descricao: $descricao)';

  @override
  bool operator ==(covariant Rede other) {
    if (identical(this, other)) return true;

    return other.id == id && other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ descricao.hashCode;
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

  Veiculo copyWith({
    int? id,
    String? tipoVeiculo,
    String? placa,
    String? foto,
  }) {
    return Veiculo(
      id: id ?? this.id,
      tipoVeiculo: tipoVeiculo ?? this.tipoVeiculo,
      placa: placa ?? this.placa,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipoVeiculo': tipoVeiculo,
      'placa': placa,
      'foto': foto,
    };
  }

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      id: map['id'] ?? 0,
      tipoVeiculo: map['tipoVeiculo'] ?? '',
      placa: map['placa'] ?? '',
      foto: map['foto'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Veiculo.fromJson(String source) => Veiculo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Veiculo(id: $id, tipoVeiculo: $tipoVeiculo, placa: $placa, foto: $foto)';
  }

  @override
  bool operator ==(covariant Veiculo other) {
    if (identical(this, other)) return true;

    return other.id == id && other.tipoVeiculo == tipoVeiculo && other.placa == placa && other.foto == foto;
  }

  @override
  int get hashCode {
    return id.hashCode ^ tipoVeiculo.hashCode ^ placa.hashCode ^ foto.hashCode;
  }
}
