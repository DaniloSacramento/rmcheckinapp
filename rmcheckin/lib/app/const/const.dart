class ConstsApi {
  static const String baseUrl = 'http://acesso.triviacloud.com.br';
  static const String motoristaAuth = '$baseUrl/api/auth/motorista';
  static const String basicAuth = 'Basic bGVvbmFyZG86MTIzNDU2';
  static const String verificarToken = '$baseUrl/api/motorista/token/sms';
  static const String registrarUser = '$baseUrl/api/motorista/registrar';
  static const String uploadFoto = '$baseUrl/api/motorista/cadastro/upload';
  static const String finalizarRegistro = '$baseUrl/api/motorista/cadastro';
  static const String registrarVeiculo = '$baseUrl/api/motorista/veiculo/registrar';
  static const String esqueciSenha = '$baseUrl/api/motorista/esqueci-minha-senha';
  static const String alterarSenha = '$baseUrl/api/motorista/alterar-senha';
  static const String meusDados = '$baseUrl/api/motorista/meus-dados';
  static const String tipoVeiculo = '$baseUrl/api/tipoveiculo';
  static const String lojasCheckin = '$baseUrl/api/motorista/lojas/checkin';
  static const String registrarCheckin = '$baseUrl/api/motorista/checkin/registrar';
  static const String verificarCpf = '$baseUrl/api/motorista/verificar/registro';
}
