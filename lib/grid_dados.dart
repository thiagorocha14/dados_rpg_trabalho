import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GridDados extends StatefulWidget {
  const GridDados({super.key});

  @override
  State<GridDados> createState() => _GridDadosState();
}

class _GridDadosState extends State<GridDados> with TickerProviderStateMixin  {
  String text = '';
  List ultimasEscolhas = [];
  Map<String, String> ultimaEscolha = {};
  double progress = 0.0;

  int index = 0;
  void rolarDados(int numeroFaces) {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (index == 100) {
        mudaProgressoAtivaAnimacao();
        timer.cancel();
        index = 0;
        mostrarResultado();
        adicionaUltimaEscolha(numeroFaces, text);
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

  mostraUltimasEscolhasDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Últimas 6 jogadas'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var item in ultimasEscolhas)
                  Text('D${item['numeroFaces']} - ${item['resultado']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void mudaProgressoAtivaAnimacao() {
    setState(() {
      if (progress >= 6) {
          progress = 1;
        } else {
          progress++;
      }
      double previusProgress = progress;
      double begin = progress == 1 ? 0 : progress - 1;
      _progressAnimation = Tween<double>(begin: begin, end: progress).animate(_animationController!)
      ..addListener(() {
        setState(() {
          progress = _progressAnimation!.value;
        });
      });

      _animationController!.forward(from: 0);

      if (previusProgress == 6) {
        Timer(const Duration(milliseconds: 1500), () {
          progress = 0;
          _progressAnimation = Tween<double>(begin: 0, end: 6).animate(_animationController!);
          _animationController!.reverse(from: 6);
        });
      }
    });
  }

  AnimationController? _animationController;
  Animation<double>? _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Set the duration of the animation
    );
  }

  void startProgressAnimation() {
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void adicionaUltimaEscolha(numeroFaces, resultado) {
    if (ultimasEscolhas.length == 6) {
      ultimasEscolhas = [];
    }

    ultimaEscolha = {};
    ultimaEscolha['numeroFaces'] = numeroFaces.toString();
    ultimaEscolha['resultado'] = resultado;
    ultimasEscolhas.add(ultimaEscolha);
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
                Expanded(
                  child: 
                    LinearProgressIndicator(
                      value: progress / 6,
                      semanticsLabel: 'Progresso até o 6',
                    )
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: 'Últimas 6 jogadas',
                  onPressed: () {
                    mostraUltimasEscolhasDialog();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Resultado: $text',
                  style: const TextStyle(fontSize: 20),
                ),
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
