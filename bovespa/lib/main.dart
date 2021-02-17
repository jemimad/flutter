import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance/stock_price?key=4ff7a058&symbol=";
void main() {
  runApp(MyApp());
}

Future<Map> getData(selectedCotacao) async {
  http.Response response = await http.get('$request$selectedCotacao');
  return json.decode(response.body);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBOVESPA',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'IBOVESPA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedValue = 'BTOW3';
  List actions = ['BTOW3', 'BIDI11', 'PGMN3', 'BBDC3', 'SANB3'];

  double cotacao;
  String cotacao_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(selectedValue),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar os dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    cotacao =
                        snapshot.data["results"]['$selectedValue']["price"];
                    cotacao_name = snapshot.data["results"]['$selectedValue']
                        ["company_name"];

                    return SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Text("Selecione a cotação:", 
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        textAlign: TextAlign.center,),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              hint: Text('Selecione a ação'),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                              value: selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                              items: actions.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Text("O valor da $cotacao_name é $cotacao",
                            style: TextStyle(fontSize: 20.0)),
                      ],
                    ));
                  }
              }
            }));
  }
}
