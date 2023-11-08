import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rmcheckin/app/models/motorista_auth_model.dart';
import 'package:rmcheckin/app/pages/alterar_dados/alterar_dados_page.dart';
import 'package:rmcheckin/app/pages/caminhao/caminhao_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Motorista? user;
  motoristaUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString("data");
    setState(() {
      user = Motorista.fromMap(jsonDecode(result!)["data"]);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        motoristaUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double telaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 200));
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: telaHeight * 0.02,
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170,
                      height: telaHeight * 0.25,
                      child: CachedNetworkImage(
                        imageUrl: user!.foto,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.camera),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: telaHeight * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dados Pessoais',
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: darkBlueColor),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    // Largura total e altura mínima
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CaminhaoPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Dados do caminhao',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(
              height: telaHeight * 0.03,
            ),
            Row(
              children: [
                Text(
                  'Nome',
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                Text(
                  user!.nome,
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("CPF",
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 70.0),
                  child: Text("Telefone",
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user!.cpf,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    user!.telefone,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "E-mail",
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 83.0),
                  child: Text(
                    "Status",
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user!.email,
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: telaHeight * 0.05,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    minimumSize: const Size(double.infinity, 50), // Largura total e altura mínima
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AlterarDadosPage()));
                  },
                  child: const Text('Alterar dados'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
