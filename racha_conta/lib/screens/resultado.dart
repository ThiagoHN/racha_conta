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
      body: Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Preço Total: R\$' + resultados['total'].toStringAsFixed(2), style: TextStyle(fontSize: 24)),
            Text('Quem não bebeu: R\$' + resultados['individual'].toStringAsFixed(2), style: TextStyle(fontSize: 24)),
            if(resultados['alcool'] != -1)
              Text('Quem bebeu: R\$' + resultados['alcool'].toStringAsFixed(2), style: TextStyle(fontSize: 24)),
            Text('Gorjeta do garçom: R\$' + resultados['garcom'].toStringAsFixed(2), style: TextStyle(fontSize: 24)),
          ],),
      )
    );
  }
}