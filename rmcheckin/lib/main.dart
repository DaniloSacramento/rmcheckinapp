import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rmcheckin/app/home/home_page.dart';
import 'package:rmcheckin/app/input/input_screen.dart';
import 'package:rmcheckin/app/shared/theme/colors_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final bool hasUser = await verificarUser();
  runApp(
    MyApp(hasUser: hasUser),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.hasUser});
  final bool hasUser;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'RMCheckIn',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      home: widget.hasUser ? const HomePage() : const InputScreen(),
    );
  }
}

Future<bool> verificarUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString('data') != null;
}
