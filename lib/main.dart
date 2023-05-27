import 'package:dados_rpg/grid_dados.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RPGMain());
}

class RPGMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: GridDados(),
    );
  }
}
