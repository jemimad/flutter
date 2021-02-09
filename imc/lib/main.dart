import 'package:flutter/material.dart';
import 'package:f_imc_2_ext/ui/result.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC ",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _resetCampos() {
    pesoController.clear();
    alturaController.clear();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ], //<Widget>[]
      ), // app bar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.lightGreen),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) return "Insira seu peso!";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) return "Insira sua altura!";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    )),
              ),
            ], //<widget>[]
          ),
        ),
      ),
    );
  }

  void _calcular() {
    String _texto = "";
    String _imagem = "";
    String _subtexto = "";

    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text)/100.0;

    double imc = peso / (altura * altura);
    debugPrint("Peso ${peso} e altura ${altura}");
    debugPrint("$imc");
    if (imc < 18.6) {
      _texto = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/thin.png";
      _subtexto = "Cuidado! Pode ocorrer fadiga, stress, ansiedade";
    } else if (imc >= 18.6 && imc < 24.9) {
      _texto = "Peso ideal (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/shape.png";
      _subtexto =
          "Parabéns, você tem menor risco de doenças cardíacas e vasculares";
    } else if (imc >= 24.9 && imc < 29.9) {
      _texto = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/fat.png";
      _subtexto = "Cuidado! Pode ocorrer fadiga, má circulação, varizes";
    } else if (imc >= 29.9 && imc < 34.9) {
      _texto = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/fat.png";
      _subtexto =
          "Cuidado! Você pode apresentar sintomas de diabetes, angina, infarto, aterosclerose";
    } else if (imc >= 34.9 && imc < 39.9) {
      _texto = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/fat.png";
      _subtexto = "Cuidado! Pode ocorrer apneia do sono, falta de ar";
    } else if (imc >= 40) {
      _texto = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      _imagem = "imagens/fat.png";
      _subtexto =
          "Cuidado! Você pode apresentar sintomas de refluxo, dificuldade para se mover, escaras, diabetes, infarto, AVC";
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result(_imagem, _texto, _subtexto)));
  }
}
