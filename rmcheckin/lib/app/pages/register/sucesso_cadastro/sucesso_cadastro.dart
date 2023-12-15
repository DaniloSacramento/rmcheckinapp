// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/services/finalizar_registro_service.dart';

class SucessoPageCadastro extends StatefulWidget {
  final String cpf;
  final String email;
  final String telefone;
  final String nome;
  final String password;
  const SucessoPageCadastro({
    Key? key,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.nome,
    required this.password,
  }) : super(key: key);

  @override
  State<SucessoPageCadastro> createState() => _SucessoPageCadastroState();
}

class _SucessoPageCadastroState extends State<SucessoPageCadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                finalizarRegistro(
                  nome: widget.nome,
                  cpf: widget.cpf,
                  email: widget.email,
                  password: widget.password,
                  telefone: widget.telefone,
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('Finalizar Cadastroß'),
            )
          ],
        ),
      ),
    );
  }
}
