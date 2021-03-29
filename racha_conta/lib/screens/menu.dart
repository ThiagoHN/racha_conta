import 'package:flutter/material.dart';
import 'package:racha_conta/screens/resultado.dart';

class Menu extends StatefulWidget {
  static const routeName = 'Tela_principal';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  int num_pessoas = 0;
  int num_pessoas_bebendo = 0;
  double preco_total = 0.0;
  double preco_bebida = 0;
  double porcentagem_garcom = 10;
  bool alcool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Racha Conta Menu'),
      ),
      body: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: preco_total.toStringAsFixed(2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'R\$'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      preco_total = double.parse(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Valor da conta inválido, digite o valor novamente!';
                      } else if (double.tryParse(value) == null)
                        return 'Valor da conta deve ser númerico';
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: num_pessoas.toString(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Número de pessoas'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      num_pessoas = int.parse(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Número de pessoas inválido, digite o valor novamente!';
                      } else if (int.tryParse(value) == null)
                        return 'Número de pessoas deve ser númerico';
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Text('Porcentagem do Garçom: ' +
                      porcentagem_garcom.toStringAsFixed(0) + '%'),
                  Slider(
                    value: porcentagem_garcom,
                    onChanged: (value) {
                      setState(() {
                        porcentagem_garcom = value;
                      });
                    },
                    min: 0,
                    max: 100,
                  ),
                  Card(
                      elevation: 4,
                      child: AnimatedContainer(
                        padding: const EdgeInsets.all(15),
                        duration: Duration(milliseconds: 300),
                        height: alcool ? 260 : 90,
                        child: ListView(
                          children: [
                            CheckboxListTile(
                                title: Text('Bebida Alcoólica'),
                                value: alcool,
                                onChanged: (value) {
                                  setState(() {
                                    alcool = value;
                                  });
                                }),
                            if (alcool) ...buildAlcoolTextFormField(),
                          ],
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () => computaConta(context),
                      child: Text('Calcular'))
                ],
              ),
            ),
          )),
    );
  }

  List<Widget> buildAlcoolTextFormField() {
    return [
      TextFormField(
        enabled: alcool,
        initialValue: preco_bebida.toStringAsFixed(2),
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'R\$'),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          preco_bebida = double.parse(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Valor da conta inválido, digite o valor novamente!';
          } else if (double.tryParse(value) == null)
            return 'Valor da conta deve ser númerico';
          return null;
        },
      ),
      const SizedBox(height: 25),
      TextFormField(
        enabled: alcool,
        initialValue: num_pessoas_bebendo.toString(),
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: 'Número de pessoas'),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          num_pessoas_bebendo = int.parse(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Número de pessoas inválido, digite o valor novamente!';
          } else if (int.tryParse(value) == null)
            return 'Número de pessoas deve ser númerico';
          return null;
        },
      ),
    ];
  }

  void computaConta(BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();

      if (num_pessoas_bebendo > num_pessoas) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text('Atenção'),
                content: Text(
                    'A quantidade de pessoas que estão bebendo, é maior do que o total de pessoas presente na mesa')));
        return;
      }

      double pagamentoGarcom = (porcentagem_garcom / 100) * preco_total;
      preco_total += pagamentoGarcom;

      double precoPessoa = (preco_total - preco_bebida) / num_pessoas;
      double precoAlcool;
      
      if(num_pessoas_bebendo != 0)
        precoAlcool = precoPessoa + (preco_bebida / num_pessoas_bebendo);
      else
        precoAlcool = -1;

      Navigator.of(context).pushNamed(Resultado.routeName, arguments: {
        'total': preco_total,
        'individual': precoPessoa,
        'alcool': precoAlcool,
        'garcom': pagamentoGarcom,
      });
    }
  }
}
