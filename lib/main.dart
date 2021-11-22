import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimistic Rendering Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _favorited = false;
  Future<bool> _toggleFavorite() async {
    // 1. 의도한대로 결과와 상관 없이 무조건 바꾼다.
    setState(() => _favorited = !_favorited);

    final int getNum = Random().nextInt(100);
    await Future.delayed(const Duration(seconds: 2));

    print("generated random number ${getNum}");
    return getNum % 2 == 0 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Optimistic Rendering Demo'),
        ),
        body: Center(
          child: IconButton(
            onPressed: () async {
              bool result = await _toggleFavorite();
              if (result == false) {
                // 2. 결과를 받아와서 그 결과대로 다시 처리한다.
                setState(() => _favorited = !_favorited);
              }
            },
            iconSize: 120,
            icon: Icon(
              _favorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ));
  }
}
