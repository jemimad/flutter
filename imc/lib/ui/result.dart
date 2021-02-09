import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String _imagem;
  String _texto;
  String _subtexto;

  Result(this._imagem, this._texto, this._subtexto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultado"), backgroundColor: Colors.green),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            _imagem,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          Center(
            child: Text(
              _texto,
              style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
            ),
          ),
          Center(
            child: Text(
              _subtexto,
              style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}
