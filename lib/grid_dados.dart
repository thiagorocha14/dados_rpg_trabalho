import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GridDados extends StatefulWidget {
  const GridDados({super.key});

  @override
  State<GridDados> createState() => _GridDadosState();
}

class _GridDadosState extends State<GridDados> {
  String text = '';

  int index = 0;
  void rolarDados(int numeroFaces) {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (index == 100) {
        timer.cancel();
        index = 0;
        mostrarResultado();
        return;
      }
      index++;
      setState(() {
        text = (Random().nextInt(numeroFaces) + 1).toString();
      });
    });
  }

  mostrarResultado() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        content: Text("Você tirou um $text!"),
        // action: SnackBarAction(label: "Fechar", onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados RPG'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Resultado: $text',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('D4'),
                  onPressed: () {
                    rolarDados(4);
                  },
                ),
                ElevatedButton(
                  child: const Text('D6'),
                  onPressed: () {
                    rolarDados(6);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('D8'),
                  onPressed: () {
                    rolarDados(8);
                  },
                ),
                ElevatedButton(
                  child: const Text('D10'),
                  onPressed: () {
                    rolarDados(10);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('D12'),
                  onPressed: () {
                    rolarDados(12);
                  },
                ),
                ElevatedButton(
                  child: const Text('D20'),
                  onPressed: () {
                    rolarDados(20);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
