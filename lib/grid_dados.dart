import 'dart:math';

import 'package:flutter/material.dart';

class GridDados extends StatefulWidget {
  const GridDados({super.key});

  @override
  State<GridDados> createState() => _GridDadosState();
}

class _GridDadosState extends State<GridDados> {
  void rolarDados(int numeroFaces) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String text = '';

        void animacaoDados(int numeroFaces, StateSetter setState) {
          for (int i = 0; i < 10; i++) {
            Future.delayed(const Duration(milliseconds: 1), () {
              setState(() {
                text = (Random().nextInt(numeroFaces) + 1).toString();
              });
            });
          }
        }

        return AlertDialog(
            title: const Text("Tirou:"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              animacaoDados(numeroFaces, setState);

              return Text(text);
            }));
      },
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
