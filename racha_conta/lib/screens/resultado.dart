import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  static const routeName = 'resultado';
  
  @override
  Widget build(BuildContext context) {
    final resultados =
    ModalRoute.of(context).settings.arguments as Map<String, double>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conta a ser paga'),
      ),
      body: Column(
        children: [
          Text('Preço Total: R\$' + resultados['total'].toString()),
          Text('Quem não bebeu: R\$' + resultados['individual'].toString()),
          Text('Quem bebeu: R\$' + resultados['alcool'].toString()),
          Text('Quem não bebeu: R\$' + resultados['garcom'].toString()),
        ],)
    );
  }
}