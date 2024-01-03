class LojaModel {
  final int id;
  final String descricao;
  final int grupoEmpresarialId;
  final String grupoEmpresarialDesc;
  final double latitude;
  final double longitude;

  LojaModel({
    required this.id,
    required this.descricao,
    required this.grupoEmpresarialId,
    required this.grupoEmpresarialDesc,
    required this.latitude,
    required this.longitude,
  });

  factory LojaModel.fromMap(Map<String, dynamic> map) {
    return LojaModel(
      id: map['id'],
      descricao: map['descricao'],
      grupoEmpresarialId: map['grupoEmpresarialId'],
      grupoEmpresarialDesc: map['grupoEmpresarialDesc'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
