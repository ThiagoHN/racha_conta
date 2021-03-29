import 'package:flutter/material.dart';
import 'package:racha_conta/screens/menu.dart';
import 'package:racha_conta/screens/resultado.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha Conta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Menu.routeName,
      routes: {
        Menu.routeName: (ctx) => Menu(),
        Resultado.routeName: (ctx) => Resultado(),
      },
    );
  }
}

  